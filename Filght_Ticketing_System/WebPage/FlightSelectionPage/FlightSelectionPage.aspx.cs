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
    public partial class FlightSelectionPage : System.Web.UI.Page
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
                txtDepartureDate.Text = departDate;
                txtOneWayDate.Text = Session["Return"] as string;

                dropdownButton.Text = $"{adults + children} Passenger{(adults + children > 1 ? "s" : "")}";

                if (!string.IsNullOrEmpty(departCity) && !string.IsNullOrEmpty(arriveCity) && !string.IsNullOrEmpty(departDate))
                {
                    if (DateTime.TryParse(departDate, out DateTime parsedDepartDate))
                    {
                        BindFlights(departCity, arriveCity, parsedDepartDate);
                    }
                }

                
                if (string.IsNullOrEmpty(Session["Return"] as string))
                {
                    
                    txtOneWayDate.ReadOnly = true;
                    txtOneWayDate.BackColor = System.Drawing.Color.Gray; 
                }
                else
                {
                    txtOneWayDate.ReadOnly = false;
                    txtOneWayDate.BackColor = System.Drawing.Color.White;
                }
            }
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
            string departDate = txtDepartureDate.Text;

            Session["From"] = departCity;
            Session["To"] = arriveCity;
            Session["Departure"] = departDate;
            Session["Return"] = txtOneWayDate.Text;

            if (!string.IsNullOrEmpty(departCity) && !string.IsNullOrEmpty(arriveCity) && DateTime.TryParse(departDate, out DateTime parsedDepartDate))
            {
                BindFlights(departCity, arriveCity, parsedDepartDate);
            }
            else
            {
                Debug.WriteLine("Please ensure all fields are filled correctly.");
            }
        }

        protected void btnFilterSubmit_Click(object sender, EventArgs e)
        {
            string departCity = txtFrom.Text.Trim();
            string arriveCity = txtTo.Text.Trim();
            string departDateText = txtDepartureDate.Text;

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

            string layovers = GetLayoverSelection();
            string cabinClass = GetCabinClassSelection();
            string depTime = GetDepartureTimeSelection();

            BindFlights(departCity, arriveCity, departDate, layovers, cabinClass, depTime);
        }

        private void BindFlights(string departCity, string arriveCity, DateTime departDate, string layovers = "", string cabinClass = "", string depTime = "")
        {
            string query = @"
SELECT f.FlightID, 
       a.AirplaneName AS AirlineName, 
       f.AirplaneID,
       f.Price, 
       FORMAT(f.DepartDateTime, 'hh:mm tt') AS FlightTime,
       FORMAT(f.ArriveDateTime, 'hh:mm tt') AS ArrivalTime,
       DATEDIFF(MINUTE, f.DepartDateTime, f.ArriveDateTime) / 60 AS Duration
FROM Flight f
JOIN Airplane a ON f.AirplaneID = a.AirplaneID
JOIN CabinClass c ON f.cabinClassID = c.cabinClassID
WHERE LOWER(f.DepartCity) = LOWER(@DepartCity)
  AND LOWER(f.ArriveCity) = LOWER(@ArriveCity)
  AND CAST(f.DepartDateTime AS DATE) = @DepartDate
  AND f.FlightStatus = 'Scheduled'
  AND DATEDIFF(MINUTE, f.DepartDateTime, f.ArriveDateTime) / 60 <= @MaxDuration";

            // Dynamic query building for layovers
            if (!string.IsNullOrEmpty(layovers))
            {
                List<string> layoverConditions = new List<string>();

                if (layovers.Contains("Direct"))
                    layoverConditions.Add("f.stopoverAirportID1 IS NULL");
                if (layovers.Contains("1 Stop"))
                    layoverConditions.Add("f.stopoverAirportID1 IS NOT NULL AND f.stopoverAirportID2 IS NULL");
                if (layovers.Contains("2 Stops"))
                    layoverConditions.Add("f.stopoverAirportID2 IS NOT NULL");

                if (layoverConditions.Count > 0)
                {
                    query += " AND (" + string.Join(" OR ", layoverConditions) + ")";
                }
            }

            if (!string.IsNullOrEmpty(cabinClass))
            {
                query += " AND c.cabinClassName = @CabinClass";
            }

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

                    if (!string.IsNullOrEmpty(cabinClass))
                        cmd.Parameters.AddWithValue("@CabinClass", cabinClass);

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptFlights.DataSource = dt;
                    rptFlights.DataBind();

                    if (dt.Rows.Count == 0)
                    {
                        lblNoFlightsFound.Visible = true;

                    }
                    else
                    {
                        lblNoFlightsFound.Visible = false;
                    }
                }
            }
        }



        private string GetLayoverSelection()
        {
            List<string> layovers = new List<string>();
            if (direct.Checked) layovers.Add("Direct");
            if (oneStop.Checked) layovers.Add("1 Stop");
            if (twoStops.Checked) layovers.Add("2 Stops");
            return string.Join(" ", layovers);
        }

        private string GetCabinClassSelection()
        {
            if (economy.Checked) return "Economy";
            if (business.Checked) return "Business";
            if (firstClass.Checked) return "First Class";
            return string.Empty;
        }

        private string GetDepartureTimeSelection()
        {
            if (EarlyFlight.Checked) return "Early";
            if (MorningFlight.Checked) return "Morning";
            if (AfternoonFlight.Checked) return "Afternoon";
            if (NightFlight.Checked) return "Night";
            return string.Empty;
        }

        public string GetFlightSelectCommand(string fromLocation, string toLocation, string departureDate, string returnDate)
        {
            string query = "SELECT * FROM [dbo].[Flight] WHERE departCity = @DepartCity AND arriveCity = @ArriveCity AND departDateTime >= @DepartDate";

            if (!string.IsNullOrEmpty(returnDate))
            {
                query += " AND arriveDateTime <= @ReturnDate";
            }

            return query;
        }

        protected void SelectFlight_Command(object sender, CommandEventArgs e)
        {
            int flightID = int.Parse(e.CommandArgument.ToString());

            Session["SelectedFlightID"] = flightID;

            bool isReturnFlight = Session["IsReturnFlight"] != null && (bool)Session["IsReturnFlight"];

            if (isReturnFlight)
            {
                Response.Redirect("~/WebPage/FlightReturnSelectionPage/FlightReturnSelection.aspx");
            }
            else
            {
                Response.Redirect("~/WebPage/FlightPassengerInfoPage/FlightPassengerInfoOneWay.aspx");
            }
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
