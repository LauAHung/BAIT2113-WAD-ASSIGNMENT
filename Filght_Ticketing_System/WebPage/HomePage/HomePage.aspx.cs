using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignemnt_Draft_1.WebPage
{
    public partial class HomePage2 : System.Web.UI.Page
    {
        protected string passengerCount = "1";
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorMsg.Text = string.Empty;


            ScriptManager.RegisterStartupScript(this, GetType(), "initializeScripts", "handleFlightTypeChange(); validateDates();", true);
            UpdateDropdownText(sender, e);
        }

        [WebMethod]
        public static List<Airport> GetAirports(string searchTerm)
        {
            List<Airport> airports = new List<Airport>();
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT TOP 10 * FROM Airport WHERE airportName LIKE @searchTerm OR city LIKE @searchTerm";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@searchTerm", $"%{searchTerm}%");
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    airports.Add(new Airport
                    {
                        AirportID = Convert.ToInt32(reader["airportID"]),
                        AirportName = reader["airportName"].ToString(),
                        City = reader["city"].ToString(),
                        IATACode = reader["IATA_Code"].ToString()
                    });
                }
            }

            return airports;
        }

        protected void btnSubscribe_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = txtEmail.Text.Trim();
                string city = txtCity.Text.Trim();

                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
                string query = "INSERT INTO Subscribe (email, preferenceCity) VALUES (@Email, @City)";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    int nextId = 5001;
                    string maxIdQuery = "SELECT ISNULL(MAX(Id), 5000) FROM Subscribe";
                    using (SqlCommand cmd = new SqlCommand(maxIdQuery, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            nextId = Convert.ToInt32(result) + 1; 
                        }
                    }

                    string insertQuery = "INSERT INTO Subscribe (Id, email, preferenceCity) VALUES (@Id, @Email, @City)";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", nextId);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@City", city);

                        try
                        {
                            cmd.ExecuteNonQuery();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "displaySuccess", "displaySuccessfulSubscribePopup();", true);
                        }
                        catch (Exception)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "displayFailure", "displayUnsuccessfulSubscribePopup();", true);
                        }
                    }

                    conn.Close();
                }

                SendConfirmationEmail(email);
            }
        }


        private void SendConfirmationEmail(string email)
        {
            try
            {
                MailMessage mail = new MailMessage
                {
                    From = new MailAddress("noreplytravelfreesdnbhd@gmail.com"),
                    Subject = "Subscription Confirmation TRAVELFREE",
                    Body = "Thank you for subscribing to our offers!",
                    IsBodyHtml = true
                };
                mail.To.Add(email);

                SmtpClient smtp = new SmtpClient("smtp.gmail.com")
                {
                    Port = 587,
                    Credentials = new System.Net.NetworkCredential("noreplytravelfreesdnbhd@gmail.com", "jnby yrik cjdh opjj"),
                    EnableSsl = true
                };

                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error sending email: {ex.Message}');</script>");
            }
        }

        protected void cvConsent_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkConsent.Checked;
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string departCity = txtFrom.Text.Trim();
            string arriveCity = txtTo.Text.Trim();
            string returnDate = txtOneWayDate.Text.Trim();

            int adults = int.Parse(adultCounter.Text);
            int children = int.Parse(childCounter.Text);

            bool isReturnFlight = RadioButton1.Checked;

            DateTime departDate;
            try
            {
                departDate = DateTime.Parse(txtDepartureDate.Text);
            }
            catch (FormatException)
            {
                lblErrorMsg.Text = "Please select a valid departure date.";
                return;
            }

            // Validation
            if (string.IsNullOrEmpty(departCity))
            {
                lblErrorMsg.Text = "Please enter the departure location.";
                return;
            }
            if (string.IsNullOrEmpty(arriveCity))
            {
                lblErrorMsg.Text = "Please enter the arrival location.";
                return;
            }
            if (isReturnFlight && string.IsNullOrEmpty(returnDate))
            {
                lblErrorMsg.Text = "Please select a return date for a return flight.";
                return;
            }

            Session["IsReturnFlight"] = isReturnFlight;
            Session["From"] = departCity;
            Session["To"] = arriveCity;
            Session["Departure"] = departDate.ToString("yyyy-MM-dd");
            Session["Return"] = isReturnFlight ? returnDate : null;
            Session["Adults"] = adults;
            Session["Children"] = children;


            Response.Redirect("~/WebPage/FlightSelectionPage/FlightSelectionPage.aspx");
        }

        public class Airport
        {
            public int AirportID { get; set; }
            public string AirportName { get; set; }
            public string City { get; set; }
            public string IATACode { get; set; }
        }


    }

}



