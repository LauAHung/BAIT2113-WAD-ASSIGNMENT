using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignemnt_Draft_1.WebPage
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string departCity = Request.QueryString["departCity"] ?? Session["From"] as string;
                string arriveCity = Request.QueryString["arriveCity"] ?? Session["To"] as string;
                string departDate = Request.QueryString["departDate"] ?? Session["Departure"] as string;

                int adults = (int)(Session["Adults"] ?? 1);
                int children = (int)(Session["Children"] ?? 0);

                txtFrom.Text = departCity;
                txtTo.Text = arriveCity;
                txtDepartDate.Text = departDate;

                dropdownButton.Text = $"{adults + children} Passenger{(adults + children > 1 ? "s" : "")}";

                if (!string.IsNullOrEmpty(departCity) && !string.IsNullOrEmpty(arriveCity) && !string.IsNullOrEmpty(departDate))
                {
                    if (DateTime.TryParse(departDate, out DateTime parsedDepartDate))
                    {
                        BindTrains(departCity, arriveCity, parsedDepartDate);
                    }
                }


            }

        }

        protected void btnFilterSubmit_Click(object sender, EventArgs e)
        {
            string departCity = txtFrom.Text.Trim();
            string arriveCity = txtTo.Text.Trim();
            string departDateText = txtDepartDate.Text;

            if (string.IsNullOrEmpty(departCity) || string.IsNullOrEmpty(arriveCity) || string.IsNullOrEmpty(departDateText))
            {
                Debug.WriteLine("Required fields are missing.");
                return;
            }

            if (!DateTime.TryParse(departDateText, out DateTime departDate))
            {
                Debug.WriteLine("Invalid date format.");
                return;
            }

            BindTrains(departCity, arriveCity, departDate);
        }

        private void BindTrains(string departCity, string arriveCity, DateTime departDate, string depTime = "")
        {
            string query = @"
SELECT 
    t.trainNoID,
    t.departDateTime,
    t.arriveDateTime,
    t.departCity + ' → ' + t.arriveCity AS Route,
    t.trainStatus,
    t.price,
    t.duration,
    tr.trainName AS Company,
    'TrainIcon.png' AS TrainIconPath -- Replace this with your actual image file or URL
FROM TrainNo t
JOIN Train tr ON t.trainID = tr.trainID;";


            // Dynamic query building for layovers


            if (!string.IsNullOrEmpty(depTime))
            {
                query += depTime switch
                {
                    "Early" => " AND DATEPART(HOUR, f.DepartDateTime) BETWEEN 0 AND 5",
                    "Morning" => " AND DATEPART(HOUR, f.DepartDateTime) BETWEEN 6 AND 11",
                    "Afternoon" => " AND DATEPART(HOUR, f.DepartDateTime) BETWEEN 12 AND 17",
                    "Night" => " AND DATEPART(HOUR, f.DepartDateTime) BETWEEN 18 AND 23",
                    _ => ""
                };
            }

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DepartCity", departCity);
                    cmd.Parameters.AddWithValue("@ArriveCity", arriveCity);
                    cmd.Parameters.AddWithValue("@DepartDate", departDate);
                    cmd.Parameters.AddWithValue("@MaxDuration", 24);

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    //rptFlights.DataSource = dt;
                    //rptFlights.DataBind();
                }
            }
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string departCity = txtFrom.Text.Trim();
            string arriveCity = txtTo.Text.Trim();
            string departDate = txtDepartDate.Text;

            Session["From"] = departCity;
            Session["To"] = arriveCity;
            Session["Departure"] = departDate;

            if (!string.IsNullOrEmpty(departCity) && !string.IsNullOrEmpty(arriveCity) && DateTime.TryParse(departDate, out DateTime parsedDepartDate))
            {
                BindTrains(departCity, arriveCity, parsedDepartDate);
            }
            else
            {
                Debug.WriteLine("Please ensure all fields are filled correctly.");
            }
        }


        protected void IncrementAdult(object sender, EventArgs e)
        {
            int currentValue = int.Parse(adultCounter.Text);
            adultCounter.Text = (currentValue + 1).ToString();
            UpdateDropdownText(sender, e);
        }

        protected void DecrementAdult(object sender, EventArgs e)
        {
            int currentValue = int.Parse(adultCounter.Text);
            if (currentValue > 1)
            {
                adultCounter.Text = (currentValue - 1).ToString();
            }
            UpdateDropdownText(sender, e);
        }

        protected void IncrementChild(object sender, EventArgs e)
        {
            int currentValue = int.Parse(childCounter.Text);
            childCounter.Text = (currentValue + 1).ToString();
            UpdateDropdownText(sender, e);
        }

        protected void DecrementChild(object sender, EventArgs e)
        {
            int currentValue = int.Parse(childCounter.Text);
            if (currentValue > 0)
            {
                childCounter.Text = (currentValue - 1).ToString();
            }
            UpdateDropdownText(sender, e);
        }

        protected void UpdateDropdownText(object sender, EventArgs e)
        {
            int adults = int.Parse(adultCounter.Text);
            int children = int.Parse(childCounter.Text);
            int totalPassengers = adults + children;



            dropdownButton.Text = $"{totalPassengers} Passenger{(totalPassengers > 1 ? "s" : "")}";
        }

        [WebMethod]
        public static List<object> GetTrains(string searchTerm)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                string query = "SELECT city, trainDepotName FROM TrainDepot WHERE city LIKE @SearchTerm OR trainDepotName LIKE @SearchTerm";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                List<object> result = new List<object>();
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    result.Add(new
                    {
                        City = reader["city"].ToString(),
                        TrainDepotName = reader["trainDepotName"].ToString()
                    });
                }
                con.Close();
                return result;
            }
        }
        public class TrainDetails
        {
            public string TrainName { get; set; }
            public string DepartCity { get; set; }
            public string ArriveCity { get; set; }
            public string Company { get; set; }
        }

        public class TrainNo
        {
            public int trainNoID { get; set; }
            public DateTime departDateTime { get; set; }
            public DateTime arriveDateTime { get; set; }
            public string departCity { get; set; }
            public string arriveCity { get; set; }
            public string trainStatus { get; set; }
            public decimal price { get; set; }
            public decimal duration { get; set; }
            public int trainID { get; set; }
        }


        public class TrainDepot
        {
            public string City { get; set; }
            public string TrainDepotName { get; set; }
        }

        public class Train
        {
            public int trainID { get; set; }
            public string trainName { get; set; }
            public string trainStatus { get; set; }
            public string company { get; set; }
            public decimal capacity { get; set; }
            public int trainDepotID { get; set; }
        }
    }
}