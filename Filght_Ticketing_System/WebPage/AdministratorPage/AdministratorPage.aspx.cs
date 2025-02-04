using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace Assignemnt_Draft_1.WebPage
{
    public partial class AdministratorPage : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["userType"] == null || Session["userType"].ToString() != "Admin")
            {

                Response.Redirect("~/Webpage/AccessDeniedPage/AccessDenied.aspx");
            }

            if (!IsPostBack)
            {
                LoadUsers();
            }
        }


        [WebMethod]
        public static string GetMonthlySalesData()
        {
            string connString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
            string query = @"
    SELECT 
        FORMAT(bookingDate, 'yyyy-MM') AS Month, 
        SUM(totalPayment) AS TotalSales
    FROM Booking
    GROUP BY FORMAT(bookingDate, 'yyyy-MM')
    ORDER BY Month";

            List<object> chartData = new List<object>
    {
        new { Month = "Month", TotalSales = "TotalSales" } 
    };

            using (SqlConnection connection = new SqlConnection(connString)) 
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    chartData.Add(new
                    {
                        Month = reader["Month"].ToString(),
                        TotalSales = Convert.ToDouble(reader["TotalSales"])
                    });
                }
            }

            return JsonConvert.SerializeObject(chartData);
        }


        private void LoadUsers()
        {
            string connString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
            string query = "SELECT userID, userName, userEmail, userStatus, userType FROM UserRegistration";

            using (SqlConnection connection = new SqlConnection(connString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        private void ExecuteNonQuery(string query, int userId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userID", userId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            LoadUsers();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Validate the RowIndex
            if (e.RowIndex < 0 || e.RowIndex >= gvUsers.Rows.Count)
            {
                throw new ArgumentOutOfRangeException("RowIndex is out of range.");
            }

            // Ensure DataKeyNames is properly set
            int userID = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex]?.Value);

            // Get the new values from the dropdowns
            GridViewRow row = gvUsers.Rows[e.RowIndex];
            DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");
            DropDownList ddlType = (DropDownList)row.FindControl("ddlType");

            string newStatus = ddlStatus?.SelectedValue;
            string newType = ddlType?.SelectedValue;

            if (string.IsNullOrEmpty(newStatus) || string.IsNullOrEmpty(newType))
            {
                lblError.Text = "Invalid status or type selected.";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
            string query = "UPDATE UserRegistration SET userStatus = @userStatus, userType = @userType WHERE userID = @userID";

            using (SqlConnection connection = new SqlConnection(connString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userStatus", newStatus);
                command.Parameters.AddWithValue("@userType", newType);
                command.Parameters.AddWithValue("@userID", userID);

                connection.Open();
                command.ExecuteNonQuery();
            }

            // Reset edit index and reload users
            gvUsers.EditIndex = -1;
            LoadUsers();
        }


        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            LoadUsers();
        }

        public class DashboardData
        {
            public int TotalUsers { get; set; }
            public int TotalAdmins { get; set; }
            public int TotalFlights { get; set; }
            public int TotalTrains { get; set; }
        }

        [WebMethod]
        public static DashboardData GetDashboardData()
        {
            string connString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;

            DashboardData data = new DashboardData();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM UserRegistration", conn))
                {
                    data.TotalUsers = (int)cmd.ExecuteScalar();
                }

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM UserRegistration WHERE userType = 'Admin'", conn))
                {
                    data.TotalAdmins = (int)cmd.ExecuteScalar();
                }

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Flight", conn))
                {
                    data.TotalFlights = (int)cmd.ExecuteScalar();
                }

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM booking", conn))
                {
                    data.TotalTrains = (int)cmd.ExecuteScalar();
                }
            }

            return data;
        }


        protected void btnAddFlight_Click(object sender, EventArgs e)
        {
            try
            {
                string flightID = txtFlightID.Text.Trim();
                DateTime departDateTime = DateTime.Parse(txtDepartDateTime.Text);
                DateTime arriveDateTime = DateTime.Parse(txtArriveDateTime.Text);
                string departCity = txtDepartCity.Text.Trim();
                string arriveCity = txtArriveCity.Text.Trim();
                string flightStatus = ddlFlightStatus.SelectedValue;
                string airplaneID = txtAirplaneID.Text.Trim();

                string query = "INSERT INTO Flight (FlightID, DepartDateTime, ArriveDateTime, DepartCity, ArriveCity, FlightStatus, AirplaneID) " +
                               "VALUES (@FlightID, @DepartDateTime, @ArriveDateTime, @DepartCity, @ArriveCity, @FlightStatus, @AirplaneID)";

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@FlightID", flightID);
                        cmd.Parameters.AddWithValue("@DepartDateTime", departDateTime);
                        cmd.Parameters.AddWithValue("@ArriveDateTime", arriveDateTime);
                        cmd.Parameters.AddWithValue("@DepartCity", departCity);
                        cmd.Parameters.AddWithValue("@ArriveCity", arriveCity);
                        cmd.Parameters.AddWithValue("@FlightStatus", flightStatus);
                        cmd.Parameters.AddWithValue("@AirplaneID", airplaneID);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                lblMessage.Text = "Flight added/updated successfully!";
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }

            gvFlights.DataBind();
        }
        [WebMethod]
        public static object GetChartData()
        {
            string connString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;

            var genderData = new List<object>();
            var geographyData = new List<object>();
            var ageData = new List<object>();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Gender Data
                using (SqlCommand cmd = new SqlCommand("SELECT gender, COUNT(*) AS Count FROM UserRegistration GROUP BY gender", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            genderData.Add(new { Gender = reader["gender"], Count = reader["Count"] });
                        }
                    }
                }

                // Geography Data
                using (SqlCommand cmd = new SqlCommand("SELECT address, COUNT(*) AS Count FROM UserRegistration GROUP BY address", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            geographyData.Add(new { Address = reader["address"], Count = reader["Count"] });
                        }
                    }
                }

                // Age Data
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT 
                CASE 
                    WHEN DATEDIFF(YEAR, dateOfBirth, GETDATE()) < 20 THEN 'Under 20'
                    WHEN DATEDIFF(YEAR, dateOfBirth, GETDATE()) BETWEEN 20 AND 29 THEN '20-29'
                    WHEN DATEDIFF(YEAR, dateOfBirth, GETDATE()) BETWEEN 30 AND 39 THEN '30-39'
                    ELSE '40+' 
                END AS AgeGroup, 
                COUNT(*) AS Count 
            FROM UserRegistration 
            GROUP BY 
                CASE 
                    WHEN DATEDIFF(YEAR, dateOfBirth, GETDATE()) < 20 THEN 'Under 20'
                    WHEN DATEDIFF(YEAR, dateOfBirth, GETDATE()) BETWEEN 20 AND 29 THEN '20-29'
                    WHEN DATEDIFF(YEAR, dateOfBirth, GETDATE()) BETWEEN 30 AND 39 THEN '30-39'
                    ELSE '40+' 
                END", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ageData.Add(new { AgeGroup = reader["AgeGroup"], Count = reader["Count"] });
                        }
                    }
                }
            }

            return new
            {
                GenderData = genderData,
                GeographyData = geographyData,
                AgeData = ageData
            };
        }

        protected void btnAddAirport_Click(object sender, EventArgs e)
        {
            try
            {
                string airportID = txtAirportID.Text.Trim();
                string airportName = txtAirportName.Text.Trim();
                string city = txtCity.Text.Trim();
                string IATA_Code = txtIATACode.Text.Trim();

                string query = "INSERT INTO Airport (AirportID, AirportName, City, IATA_Code) " +
                               "VALUES (@AirportID, @AirportName, @City, @IATA_Code)";

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@AirportID", airportID);
                        cmd.Parameters.AddWithValue("@AirportName", airportName);
                        cmd.Parameters.AddWithValue("@City", city);
                        cmd.Parameters.AddWithValue("@IATA_Code", IATA_Code);


                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                lblAirportMessage.Text = "Airport added/updated successfully!";
            }
            catch (Exception ex)
            {
                lblAirportMessage.ForeColor = System.Drawing.Color.Red;
                lblAirportMessage.Text = "Error: " + ex.Message;
            }

            gvAirport.DataBind();
        }

        protected void UploadImage(object sender, EventArgs e)
        {
            try
            {
                if (fileUpload.HasFile)
                {
                    string fileExtension = System.IO.Path.GetExtension(fileUpload.FileName).ToLower();
                    if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".jpeg")
                    {
                        byte[] airplaneImage = null;
                        using (System.IO.Stream fs = fileUpload.PostedFile.InputStream)
                        {
                            using (System.IO.BinaryReader br = new System.IO.BinaryReader(fs))
                            {
                                airplaneImage = br.ReadBytes((int)fs.Length);
                            }
                        }

                        // Store the image in Session 先不要store进database 过后upload才store
                        Session["UploadedImage"] = airplaneImage;

                        lblUploadMessage.Text = "Image uploaded successfully!";
                        lblUploadMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblUploadMessage.Text = "Only can upload .jpg and .png files";
                        lblUploadMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    lblUploadMessage.Text = "Please select a Imag to upload.";
                    lblUploadMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblUploadMessage.Text = "Error: " + ex.Message;
                lblUploadMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnAddAirplane_Click(object sender, EventArgs e)
        {
            try
            {
                // Retrieve form data
                int airplaneID = int.Parse(txtAirplaneID1.Text);
                string airplaneName = txtAirplaneName.Text;
                string airplaneStatus = txtAirplaneStatus.Text;
                int capacity = int.Parse(txtCapacity1.Text);
                int airportID = int.Parse(txtAirportID1.Text);

                // Retrieve the uploaded image from Session (or another source)
                byte[] airplaneImage = Session["UploadedImage"] as byte[];

                if (airplaneImage == null)
                {
                    lblAirplaneMessage.Text = "Please upload an image first.";
                    lblAirplaneMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Database connection string
                string connString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;

                // Declare the variable to hold record existence check result
                int recordExists = 0;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    // Check if the airplaneID already exists
                    string checkQuery = "SELECT COUNT(1) FROM Airplane WHERE airplaneID = @airplaneID";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@airplaneID", airplaneID);
                        conn.Open();
                        recordExists = (int)checkCmd.ExecuteScalar();
                        conn.Close();
                    }

                    if (recordExists > 0)
                    {
                        // If record exists, update the record
                        string updateQuery = "UPDATE Airplane SET airplaneName = @airplaneName, airplaneStatus = @airplaneStatus, " +
                                             "capacity = @capacity, airplaneImage = @airplaneImage, airportID = @airportID " +
                                             "WHERE airplaneID = @airplaneID";
                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                        {
                            updateCmd.Parameters.AddWithValue("@airplaneID", airplaneID);
                            updateCmd.Parameters.AddWithValue("@airplaneName", airplaneName);
                            updateCmd.Parameters.AddWithValue("@airplaneStatus", airplaneStatus);
                            updateCmd.Parameters.AddWithValue("@capacity", capacity);
                            updateCmd.Parameters.AddWithValue("@airplaneImage", airplaneImage != null ? (object)airplaneImage : DBNull.Value);
                            updateCmd.Parameters.AddWithValue("@airportID", airportID);

                            conn.Open();
                            updateCmd.ExecuteNonQuery();
                            conn.Close();
                        }

                        lblAirplaneMessage.Text = "Airplane details updated successfully!";
                    }
                    else
                    {
                        // If record does not exist, insert new record
                        string insertQuery = "INSERT INTO Airplane (airplaneID, airplaneName, airplaneStatus, capacity, airplaneImage, airportID) " +
                                             "VALUES (@airplaneID, @airplaneName, @airplaneStatus, @capacity, @airplaneImage, @airportID)";
                        using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                        {
                            insertCmd.Parameters.AddWithValue("@airplaneID", airplaneID);
                            insertCmd.Parameters.AddWithValue("@airplaneName", airplaneName);
                            insertCmd.Parameters.AddWithValue("@airplaneStatus", airplaneStatus);
                            insertCmd.Parameters.AddWithValue("@capacity", capacity);
                            insertCmd.Parameters.AddWithValue("@airplaneImage", airplaneImage != null ? (object)airplaneImage : DBNull.Value);
                            insertCmd.Parameters.AddWithValue("@airportID", airportID);

                            conn.Open();
                            insertCmd.ExecuteNonQuery();
                            conn.Close();
                        }

                        lblAirplaneMessage.Text = "Airplane details added successfully!";
                    }

                    lblAirplaneMessage.ForeColor = System.Drawing.Color.Green;
                    gvAirplane.DataBind(); // Refresh the GridView
                }
            }
            catch (Exception ex)
            {
                lblAirplaneMessage.Text = "Error: " + ex.Message;
                lblAirplaneMessage.ForeColor = System.Drawing.Color.Red;
            }
        }


    }


}
