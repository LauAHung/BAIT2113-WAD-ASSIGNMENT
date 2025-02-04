using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Diagnostics;

namespace Assignemnt_Draft_1.WebPage
{
    public partial class FlightReturnSelection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string departCity = Session["To"] as string;
                string arriveCity = Session["From"] as string;
                string returnDate = Session["Return"] as string;

                int adults = (int)(Session["Adults"] ?? 1);
                int children = (int)(Session["Children"] ?? 0);

                txtFrom.Text = departCity;
                txtTo.Text = arriveCity;
                txtOneWayDate.Text = returnDate;

                // Update the dropdown text
                UpdatePassengerDropdownText(adults, children);

                if (!string.IsNullOrEmpty(departCity) && !string.IsNullOrEmpty(arriveCity) && !string.IsNullOrEmpty(returnDate))
                {
                    if (DateTime.TryParse(returnDate, out DateTime parsedReturnDate))
                    {
                        BindReturnFlights(departCity, arriveCity, parsedReturnDate);
                    }
                }
            }
        }

        protected void btnFilterSubmit_Click(object sender, EventArgs e)
        {
            string departCity = txtFrom.Text.Trim();
            string arriveCity = txtTo.Text.Trim();
            string returnDateText = txtOneWayDate.Text;

            if (string.IsNullOrEmpty(departCity) || string.IsNullOrEmpty(arriveCity) || string.IsNullOrEmpty(returnDateText))
            {
                Debug.WriteLine("Required fields are missing.");
                return;
            }

            if (!DateTime.TryParse(returnDateText, out DateTime returnDate))
            {
                Debug.WriteLine("Invalid date format.");
                return;
            }

            string layovers = GetLayoverSelection();
            string cabinClass = GetCabinClassSelection();
            string depTime = GetDepartureTimeSelection();

            BindReturnFlights(departCity, arriveCity, returnDate, layovers, cabinClass, depTime);
        }

        private void BindReturnFlights(string departCity, string arriveCity, DateTime returnDate, string layovers = "", string cabinClass = "", string depTime = "")
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
  AND CAST(f.DepartDateTime AS DATE) = @ReturnDate
  AND f.FlightStatus = 'Scheduled'";

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
                    cmd.Parameters.AddWithValue("@ReturnDate", returnDate);

                    if (!string.IsNullOrEmpty(cabinClass))
                        cmd.Parameters.AddWithValue("@CabinClass", cabinClass);

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptReturnFlights.DataSource = dt;
                    rptReturnFlights.DataBind();

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

        private void UpdatePassengerDropdownText(int adults, int children)
        {
            int totalPassengers = adults + children;



            dropdownButton.Text = $"{totalPassengers} Passenger{(totalPassengers > 1 ? "s" : "")}";
        }

        protected void UpdateDropdownText(object sender, EventArgs e)
        {
            int adults = int.Parse(adultCounter.Text);
            int children = int.Parse(childCounter.Text);
            int totalPassengers = adults + children;


            dropdownButton.Text = $"{totalPassengers} Passenger{(totalPassengers > 1 ? "s" : "")}";
        }

        protected void SelectFlight_Command(object sender, CommandEventArgs e)
        {
            int flightID = int.Parse(e.CommandArgument.ToString());

            Session["SelectedReturnFlightID"] = flightID;

            Response.Redirect("~/WebPage/FlightPassengerInfoPage/FlightPassengerInfo.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string arriveCity = txtTo.Text.Trim();
            DateTime returnDate = DateTime.Parse(txtOneWayDate.Text);

            string departCity = Session["From"] as string;

            BindReturnFlights(departCity, arriveCity, returnDate);
        }




    }
}