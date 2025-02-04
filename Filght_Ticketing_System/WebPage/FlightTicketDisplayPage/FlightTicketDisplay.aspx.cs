using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Assignemnt_Draft_1.WebPage
{
    public partial class FlightTicketDisplay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string bookingID = Request.QueryString["bookingID"];
                if (!string.IsNullOrEmpty(bookingID))
                {
                    LoadTicketDetails(Convert.ToInt32(bookingID));
                }
            }
        }

        private int GetBookingIdFromQuery()
        {
            int bookingId;
            int.TryParse(Request.QueryString["bookingID"], out bookingId);
            return bookingId;
        }

        private void LoadTicketDetails(int bookingID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"
                    SELECT 
                        b.passengerTitle, b.passengerFistName, b.passengerLastName, 
                        f.departCity, f.arriveCity, f.departDateTime, 
                        a.airlineCode, a.airplaneName, a.airplaneID,
                        a.airplaneName AS AirlineName
                    FROM 
                        Booking b
                    INNER JOIN 
                        Flight f ON b.flightID = f.flightID
                    INNER JOIN 
                        Airplane a ON f.airplaneID = a.airplaneID
                    WHERE 
                        b.bookingID = @BookingID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@BookingID", bookingID);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        ImageLogo.ImageUrl = ResolveUrl("~/ImageHandler.ashx?airplaneID=" + reader["AirplaneID"]);
                        ImageLogo.AlternateText = reader["AirlineName"].ToString();

                        ImageLogoTearoff.ImageUrl = ResolveUrl("~/ImageHandler.ashx?airplaneID=" + reader["AirplaneID"]);
                        ImageLogoTearoff.AlternateText = reader["AirlineName"].ToString();

                        string passengerName = $"{reader["passengerTitle"]} {reader["passengerFistName"]} {reader["passengerLastName"]}";
                        lblPassengerName.Text = passengerName;
                        lblTearoffPassengerName.Text = passengerName;

                        lblFlightNumber.Text = reader["airlineCode"].ToString();
                        lblTearoffFlightNumber.Text = reader["airlineCode"].ToString();
                        lblFrom.Text = reader["departCity"].ToString();
                        lblTo.Text = reader["arriveCity"].ToString();

                        DateTime departDateTime = Convert.ToDateTime(reader["departDateTime"]);
                        lblBoardingTime.Text = departDateTime.ToString("hh:mm tt");
                        lblTearoffDate.Text = departDateTime.ToString("dd/MM/yyyy");
                        lblAirlineName.Text = reader["AirlineName"].ToString();
                        lblAirlineNameTearoff.Text = reader["AirlineName"].ToString();
                    }
                }
            }
        }
    }
}
