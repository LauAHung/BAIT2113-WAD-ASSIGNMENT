using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignemnt_Draft_1.WebPage
{
    public partial class UserBookingPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                ShowLoginPrompt();
                return;
            }
            if (!IsPostBack)
            {

                int userID = (int)Session["UserID"];

                string connectionString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string query = @"
                        SELECT 
                            b.bookingID, 
                            b.bookingDate, 
                            f.departDateTime, 
                            f.arriveDateTime, 
                            f.departCity, 
                            f.arriveCity
                        FROM 
                            Booking b
                        INNER JOIN 
                            Flight f ON b.flightID = f.flightID
                        WHERE 
                            b.userID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind the data to the Repeater control
                        repeaterBooking.DataSource = dt;
                        repeaterBooking.DataBind();
                    }
                }
            }
        }

        private void ShowLoginPrompt()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", @"
                document.getElementById('loginPromptModal').classList.add('active');
                document.getElementById('overlay').classList.add('active');
            ", true);
        }

        protected void btnNavigateToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("../../WebPage/RegLoginPage/RegLoginPage.aspx");
        }

    }
}

