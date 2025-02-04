using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignemnt_Draft_1
{
    public partial class FlightPassengerInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int selectedFlightID = (int)Session["SelectedFlightID"];
                int selectedReturnFlightID = (int)Session["SelectedReturnFlightID"];
                int adults = (int)(Session["Adults"] ?? 1);
                int children = (int)(Session["Children"] ?? 0);

                BindFlightDetails(selectedFlightID, true);
                BindFlightDetails(selectedReturnFlightID, false);
                UpdatePriceSummary(selectedFlightID, selectedReturnFlightID, adults, children);



            }

            int totalPassengers = (int)(Session["Adults"] ?? 1) + (int)(Session["Children"] ?? 0);
            GeneratePassengerForms(totalPassengers);
        }




        [WebMethod]
        public static List<Country> GetSuggestions(string query)
        {
            List<Country> countries = new List<Country>();
            string connString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = @"SELECT TOP 10 CountryName, callingCodes 
                               FROM Country 
                               WHERE CountryName LIKE @query + '%' OR callingCodes LIKE @query + '%'";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@query", query);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    countries.Add(new Country
                    {
                        CountryName = reader["CountryName"].ToString(),
                        callingCodes = reader["callingCodes"].ToString()
                    });
                }
            }
            return countries;
        }

        public class Country
        {
            public string CountryName { get; set; }
            public string callingCodes { get; set; }
        }

        private void UpdatePriceSummary(int departFlightID, int returnFlightID, int adults, int children)
        {
            decimal ticketPrice = GetFlightPrice(departFlightID) + GetFlightPrice(returnFlightID);
            int totalPassengers = adults + children;

            decimal totalTicketPrice = ticketPrice * totalPassengers;
            decimal fare = 30m * totalPassengers;
            decimal taxes = totalTicketPrice * 0.1m; 

            TicketsPriceLabel.Text = $"RM {totalTicketPrice + fare + taxes:F2}";
            AdultsPriceLabel.Text = $"RM {ticketPrice:F2} x {adults}";
            if (children > 0)
                ChildrenPriceLabel.Text = $"RM {ticketPrice:F2} x {children}";
            else
                ChildrenPriceLabel.Visible = false;

            FareLabel.Text = $"RM 30.00 x {totalPassengers}";
            TaxesLabel.Text = $"RM {taxes:F2}";
            TotalLabel.Text = $"RM {totalTicketPrice + fare + taxes:F2}";
        }

        private decimal GetFlightPrice(int flightID)
        {
            string query = "SELECT CAST(Price AS DECIMAL(10,2)) FROM Flight WHERE FlightID = @FlightID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FlightID", flightID);
                    conn.Open();
                    return (decimal)cmd.ExecuteScalar();
                }
            }
        }

        protected void BaggageSelection_Click(object sender, EventArgs e)
        {
            Button selectedButton = sender as Button;

            if (selectedButton != null)
            {
                if (selectedButton.CssClass.Contains("selected"))
                {
                    return;
                }

                ResetBaggageSelection();

                selectedButton.CssClass += " selected";

                decimal baggageCost = 0;
                string text = selectedButton.Text;
                if (text.Contains("MYR"))
                {
                    baggageCost = Convert.ToDecimal(text.Split(new[] { "MYR" }, StringSplitOptions.None)[1].Trim());
                }

                if (text.Contains("25 kg") || text.Contains("30 kg") || text.Contains("40 kg"))
                {
                    BaggageStatusLabel.Text = $"RM {baggageCost:F2}";
                }
                else
                {
                    BaggageStatusLabel.Text = "Not Included";
                }

                ViewState["BaggageCost"] = baggageCost;
                UpdateTotalWithBaggage();
            }
        }

        private void ResetBaggageSelection()
        {
            btnNone.CssClass = "option-btn";
            btn15kg.CssClass = "option-btn";
            btn20kg.CssClass = "option-btn";
            btn25kg.CssClass = "option-btn";
            btn30kg.CssClass = "option-btn";
            btn40kg.CssClass = "option-btn";
        }

        private void UpdateTotalWithBaggage()
        {
            decimal baggageCost = (decimal)(ViewState["BaggageCost"] ?? 0);
            decimal baseTotal = Convert.ToDecimal(TotalLabel.Text.Replace("RM ", ""));

            decimal previousBaggageCost = 0;
            if (ViewState["PreviousBaggageCost"] != null && decimal.TryParse(ViewState["PreviousBaggageCost"].ToString(), out decimal parsedValue))
            {
                previousBaggageCost = parsedValue;
            }

            decimal newTotal = baseTotal - previousBaggageCost + baggageCost;

            TotalLabel.Text = $"RM {newTotal:F2}";
            ViewState["PreviousBaggageCost"] = baggageCost;
        }


        private void GeneratePassengerForms(int totalPassengers)
        {
            PassengerPlaceholder.Controls.Clear();

            for (int i = 1; i <= totalPassengers; i++)
            {
                Panel passengerPanel = new Panel
                {
                    Style =
            {
                ["border"] = "1px solid #dadce0",
                ["border-radius"] = "8px",
                ["padding"] = "20px",
                ["margin-bottom"] = "20px",
                ["background-color"] = "white"
            }
                };

                Label passengerHeader = new Label
                {
                    Text = $"Passenger {i}",
                    Style =
            {
                ["font-size"] = "18px",
                ["font-weight"] = "bold",
                ["margin-bottom"] = "15px",
                ["display"] = "block"
            }
                };
                passengerPanel.Controls.Add(passengerHeader);

                Label titleLabel = new Label
                {
                    Text = "Title",
                    Style =
            {
                ["display"] = "block",
                ["margin-bottom"] = "5px",
                ["font-size"] = "14px",
                ["color"] = "#80868b"
            }
                };
                passengerPanel.Controls.Add(titleLabel);

                DropDownList titleDropdown = new DropDownList
                {
                    ID = $"TitleDropdown_{i}",
                    Style =
            {
                ["width"] = "100%",
                ["padding"] = "10px",
                ["font-size"] = "14px",
                ["border"] = "1px solid #dadce0",
                ["border-radius"] = "4px",
                ["margin-bottom"] = "15px",
                ["box-sizing"] = "border-box"
            }
                };
                titleDropdown.Items.Add(new ListItem("Mr", "Mr"));
                titleDropdown.Items.Add(new ListItem("Mrs", "Mrs"));
                titleDropdown.Items.Add(new ListItem("Ms", "Ms"));
                passengerPanel.Controls.Add(titleDropdown);

                Label firstNameLabel = new Label
                {
                    Text = "First & Middle Name",
                    Style =
            {
                ["display"] = "block",
                ["margin-bottom"] = "5px",
                ["font-size"] = "14px",
                ["color"] = "#80868b"
            }
                };
                passengerPanel.Controls.Add(firstNameLabel);

                TextBox firstNameTextBox = new TextBox
                {
                    ID = $"FirstNameTextBox_{i}",
                    Style =
            {
                ["width"] = "100%",
                ["padding"] = "10px",
                ["font-size"] = "14px",
                ["border"] = "1px solid #dadce0",
                ["border-radius"] = "4px",
                ["margin-bottom"] = "15px",
                ["box-sizing"] = "border-box"
            }
                };
                passengerPanel.Controls.Add(firstNameTextBox);

                Label lastNameLabel = new Label
                {
                    Text = "Last Name/Surname",
                    Style =
            {
                ["display"] = "block",
                ["margin-bottom"] = "5px",
                ["font-size"] = "14px",
                ["color"] = "#80868b"
            }
                };
                passengerPanel.Controls.Add(lastNameLabel);

                TextBox lastNameTextBox = new TextBox
                {
                    ID = $"LastNameTextBox_{i}",
                    Style =
            {
                ["width"] = "100%",
                ["padding"] = "10px",
                ["font-size"] = "14px",
                ["border"] = "1px solid #dadce0",
                ["border-radius"] = "4px",
                ["margin-bottom"] = "15px",
                ["box-sizing"] = "border-box"
            }
                };
                passengerPanel.Controls.Add(lastNameTextBox);

                PassengerPlaceholder.Controls.Add(passengerPanel);
            }
        }



        private void BindFlightDetails(int flightID, bool isDepartFlight)
        {
            string query = @"
        SELECT f.FlightID, 
               a.AirplaneName AS AirlineName, 
               a.airlineCode AS FlightNumber, 
               f.AirplaneID,
               f.Price, 
               FORMAT(f.DepartDateTime, 'ddd, MMM dd') AS DepartDate,
               FORMAT(f.DepartDateTime, 'hh:mm tt') AS DepartTime,
               FORMAT(f.ArriveDateTime, 'hh:mm tt') AS ArrivalTime,
               DATEDIFF(MINUTE, f.DepartDateTime, f.ArriveDateTime) / 60 AS Duration,
               f.DepartCity, f.ArriveCity, 
               c.cabinClassName AS CabinClass, 
               f.FlightID, a.AirplaneName
        FROM Flight f
        JOIN Airplane a ON f.AirplaneID = a.AirplaneID
        JOIN CabinClass c ON f.CabinClassID = c.CabinClassID
        WHERE f.FlightID = @FlightID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FlightID", flightID);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        if (isDepartFlight)
                        {
                            DepartDateDuration.Text = $"{reader["DepartDate"]} | Duration {reader["Duration"]}h";
                            DepartTimeStart.Text = reader["DepartTime"].ToString();
                            DepartTimeEnd.Text = reader["ArrivalTime"].ToString();
                            DepartLocationStart.Text = reader["DepartCity"].ToString();
                            DepartLocationEnd.Text = reader["ArriveCity"].ToString();
                            DepartAirline.Text = reader["AirlineName"].ToString();
                            DepartFlightNumber.Text = reader["FlightNumber"].ToString(); 
                            DepartPlane.Text = reader["AirplaneName"].ToString();
                            DepartClass.Text = reader["CabinClass"].ToString();

                            DepartAirplaneIcon.ImageUrl = ResolveUrl("~/ImageHandler.ashx?airplaneID=" + reader["AirplaneID"]);
                            DepartAirplaneIcon.AlternateText = reader["AirlineName"].ToString();
                        }
                        else
                        {
                            ReturnDateDuration.Text = $"{reader["DepartDate"]} | Duration {reader["Duration"]}h";
                            ReturnTimeStart.Text = reader["DepartTime"].ToString();
                            ReturnLocationStart.Text = reader["DepartCity"].ToString();
                            ReturnLocationEnd.Text = reader["ArriveCity"].ToString();
                            ReturnTimeEnd.Text = reader["ArrivalTime"].ToString();
                            ReturnAirline.Text = reader["AirlineName"].ToString();
                            ReturnFlightNumber.Text = reader["FlightNumber"].ToString();  
                            ReturnPlane.Text = reader["AirplaneName"].ToString();
                            ReturnClass.Text = reader["CabinClass"].ToString();

                            ReturnAirplaneIcon.ImageUrl = ResolveUrl("~/ImageHandler.ashx?airplaneID=" + reader["AirplaneID"]);
                            ReturnAirplaneIcon.AlternateText = reader["AirlineName"].ToString();
                        }
                    }
                }
            }
        }

        protected void btnPayment_Click(object sender, EventArgs e)
        {
            try
            {


                if (Session["SelectedFlightID"] == null)
                {
                    ErrorMessageLabel.Text = "Error: SelectedFlightID is missing.";
                    ErrorMessageLabel.Visible = true;
                    return;
                }

                if (Session["SelectedReturnFlightID"] == null)
                {
                    ErrorMessageLabel.Text = "Error: SelectedReturnFlightID is missing.";
                    ErrorMessageLabel.Visible = true;
                    return;
                }

                if (Session["UserID"] == null)
                {
                    ErrorMessageLabel.Text = "You need to login first before make the payment";
                    ErrorMessageLabel.Visible = true;
                    return;
                }


                int adults = (int)(Session["Adults"] ?? 1);
                int children = (int)(Session["Children"] ?? 0);
                int totalPassengers = adults + children;

                int departFlightID = (int)Session["SelectedFlightID"];
                int returnFlightID = (int)Session["SelectedReturnFlightID"];
                int userID = (int)Session["UserID"];
                string totalPayment = TotalLabel.Text.Replace("RM ", "").Trim();
                DateTime bookingDate = DateTime.Now;

                Session["TotalPassengers"] = totalPassengers;
                Session["FromLocation"] = DepartLocationStart.Text;
                Session["ToLocation"] = DepartLocationEnd.Text;
                Session["DepartDate"] = DepartDateDuration.Text;
                Session["DepartTimeStart"] = DepartTimeStart.Text;
                Session["DepartTimeEnd"] = DepartTimeEnd.Text;

                Session["ReturnDate"] = ReturnDateDuration.Text;
                Session["ReturnTimeStart"] = ReturnTimeStart.Text;
                Session["ReturnTimeEnd"] = ReturnTimeEnd.Text;

                Session["TotalPrice"] = TotalLabel.Text;


                if (departFlightID <= 0 || returnFlightID <= 0 || userID <= 0)
                {
                    ErrorMessageLabel.Text = "Error: Invalid flight or user information.";
                    ErrorMessageLabel.Visible = true;
                    return;
                }

                string connectionString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    foreach (int passengerIndex in Enumerable.Range(1, totalPassengers))
                    {
                        DropDownList titleDropdown = (DropDownList)PassengerPlaceholder.FindControl($"TitleDropdown_{passengerIndex}");
                        TextBox firstNameTextBox = (TextBox)PassengerPlaceholder.FindControl($"FirstNameTextBox_{passengerIndex}");
                        TextBox lastNameTextBox = (TextBox)PassengerPlaceholder.FindControl($"LastNameTextBox_{passengerIndex}");

                        if (titleDropdown == null || firstNameTextBox == null || lastNameTextBox == null)
                        {
                            ErrorMessageLabel.Text = $"Error: Missing data for passenger {passengerIndex}.";
                            ErrorMessageLabel.Visible = true;
                            return;
                        }

                        string title = titleDropdown.SelectedValue;
                        string firstName = firstNameTextBox.Text.Trim();
                        string lastName = lastNameTextBox.Text.Trim();
                        string phoneNo = $"{txtCountry.Text.Trim()} {PhoneNumberTextBox.Text.Trim()}";

                        if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName))
                        {
                            ErrorMessageLabel.Text = $"Error: Missing data for passenger {passengerIndex}.";
                            ErrorMessageLabel.Visible = true;
                            return;
                        }

                        foreach (int flightID in new[] { departFlightID, returnFlightID })
                        {

                            int departBookingID = GenerateUniqueBookingID();
                            int returnBookingID = GenerateUniqueBookingID2();


                            string insertQuery = @"
                    INSERT INTO Booking (
                        bookingID, bookingType, bookingDate, passengerTitle, 
                        passengerFistName, passengerLastName, phoneNo, 
                        totalPayment, flightID, userID
                    ) VALUES (
                        @BookingID, @BookingType, @BookingDate, @PassengerTitle, 
                        @PassengerFirstName, @PassengerLastName, @PhoneNo, 
                        @TotalPayment, @FlightID, @UserID
                    )";

                            using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                            {
                                cmd.Parameters.AddWithValue("@BookingID", departBookingID);
                                cmd.Parameters.AddWithValue("@BookingType", "Flight");
                                cmd.Parameters.AddWithValue("@BookingDate", bookingDate);
                                cmd.Parameters.AddWithValue("@PassengerTitle", title);
                                cmd.Parameters.AddWithValue("@PassengerFirstName", firstName);
                                cmd.Parameters.AddWithValue("@PassengerLastName", lastName);
                                cmd.Parameters.AddWithValue("@PhoneNo", phoneNo);
                                cmd.Parameters.AddWithValue("@TotalPayment", totalPayment);
                                cmd.Parameters.AddWithValue("@FlightID", departFlightID);
                                cmd.Parameters.AddWithValue("@UserID", userID);

                                cmd.ExecuteNonQuery();
                            }

                            using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                            {
                                cmd.Parameters.AddWithValue("@BookingID", returnBookingID);
                                cmd.Parameters.AddWithValue("@BookingType", "Flight");
                                cmd.Parameters.AddWithValue("@BookingDate", bookingDate);
                                cmd.Parameters.AddWithValue("@PassengerTitle", title);
                                cmd.Parameters.AddWithValue("@PassengerFirstName", firstName);
                                cmd.Parameters.AddWithValue("@PassengerLastName", lastName);
                                cmd.Parameters.AddWithValue("@PhoneNo", phoneNo);
                                cmd.Parameters.AddWithValue("@TotalPayment", totalPayment);
                                cmd.Parameters.AddWithValue("@FlightID", returnFlightID);
                                cmd.Parameters.AddWithValue("@UserID", userID);

                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                    Response.Redirect("PaymentPage.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/WebPage/FlightPaymentPage/FlightPaymentPage.aspx");
            }
        }



        protected void ChangeFlightButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/WebPage/FlightSelectionPage/FlightSelectionPage.aspx");
        }

        private int GenerateUniqueBookingID()
        {
            return new Random().Next(1, int.MaxValue); 
        }

        private int GenerateUniqueBookingID2()
        {
            return new Random().Next(10000,99999);
        }

    }
}