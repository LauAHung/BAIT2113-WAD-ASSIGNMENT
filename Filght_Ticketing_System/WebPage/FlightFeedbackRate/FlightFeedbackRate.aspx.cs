using System.Data.SqlClient;
using System.Web.UI;
using System;

namespace Assignemnt_Draft_1.WebPage.FeedBack
{
    public partial class FeedbackRate : System.Web.UI.Page
    {
        protected string CompanyName { get; set; }
        protected string CompanyImageUrl { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string companyID = Request.QueryString["company"];

                if (!string.IsNullOrEmpty(companyID))
                {
                    LoadCompanyData(companyID); // Load company details on first load
                    DisplayFeedback(); // Display feedback for the company
                }
            }
        }

        // Ensure that company data is reloaded before rendering
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(CompanyName) && Request.QueryString["company"] != null)
            {
                LoadCompanyData(Request.QueryString["company"]);
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

        private void LoadCompanyData(string companyID)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
            string query = "SELECT airplaneName, airplaneImage FROM Airplane WHERE airplaneID = @companyID";

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@companyID", companyID);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            CompanyName = reader["airplaneName"].ToString();
                            CompanyImageUrl = "~/ImageHandler.ashx?airplaneID=" + companyID;
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new Exception("Error retrieving company data.", ex);
            }
        }

        private void DisplayFeedback()
        {
            string companyID = Request.QueryString["company"];
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;

            // Query to get total feedback count and average rating
            string feedbackSummaryQuery = @"
        SELECT COUNT(*) AS TotalFeedback, AVG(f.ratingvalue) AS AverageRating
        FROM FlightFeedback f
        WHERE f.airplaneID = @companyID";

            // Query to get feedback details
            string feedbackQuery = @"
        SELECT 
            u.userID, 
            u.userName, 
            f.ratingvalue, 
            f.feedbacktext
        FROM FlightFeedback f
        JOIN UserRegistration u ON f.userID = u.userID
        WHERE f.airplaneID = @companyID
        ORDER BY f.feedbackid DESC";

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    // Get total feedback count and average rating
                    using (SqlCommand cmd = new SqlCommand(feedbackSummaryQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@companyID", companyID);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int totalFeedback = Convert.ToInt32(reader["TotalFeedback"]);
                                double averageRating = reader.IsDBNull(reader.GetOrdinal("AverageRating")) ? 0 : Convert.ToDouble(reader["AverageRating"]);

                                // Display total feedback and average rating
                                lblTotalFeedback.Text = $"Total Feedback: {totalFeedback}";
                                lblAverageRating.Text = $"Average Rating: {averageRating:F1}";
                            }
                        }
                    }

                    // Get feedback details
                    using (SqlCommand cmd = new SqlCommand(feedbackQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@companyID", companyID);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            rptFeedback.DataSource = reader;
                            rptFeedback.DataBind();
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('Error loading feedback: {ex.Message}');", true);
            }
        }

        protected void SubmitFeedback_Click(object sender, EventArgs e)
        {
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                ShowLoginPrompt();
                return;
            }

            // 提交反馈
            SubmitFeedback();
        }

        private void SubmitFeedback()
        {
            // Retrieve user information
            int currentUserId = Convert.ToInt32(Session["UserID"]);
            string companyID = Request.QueryString["company"];
            string feedbackText = Request.Form["opinion"];
            int ratingValue;

            // Validate rating value
            if (!int.TryParse(Request.Form["rating1"], out ratingValue) || ratingValue < 1 || ratingValue > 5)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please rate first.');", true);
                return;
            }

            // Validate feedback text
            if (string.IsNullOrWhiteSpace(feedbackText))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please provide feedback text.');", true);
                return;
            }

            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
            int feedbackId;

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    // Generate unique feedback ID
                    string getMaxIdQuery = "SELECT ISNULL(MAX(feedbackid), 999) + 1 FROM FlightFeedback";
                    using (SqlCommand cmd = new SqlCommand(getMaxIdQuery, conn))
                    {
                        feedbackId = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    // Insert feedback into the database
                    string insertFeedbackQuery = @"
                INSERT INTO FlightFeedback (feedbackid, airplaneID, userID, ratingvalue, feedbacktext)
                VALUES (@feedbackid, @airplaneID, @userID, @ratingvalue, @feedbacktext)";
                    using (SqlCommand cmd = new SqlCommand(insertFeedbackQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@feedbackid", feedbackId);
                        cmd.Parameters.AddWithValue("@airplaneID", companyID);
                        cmd.Parameters.AddWithValue("@userID", currentUserId);
                        cmd.Parameters.AddWithValue("@ratingvalue", ratingValue);
                        cmd.Parameters.AddWithValue("@feedbacktext", feedbackText);

                        cmd.ExecuteNonQuery();
                    }
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Thank you for your feedback!');", true);

                // Optionally redirect or clear feedback form
                Response.Redirect(Request.RawUrl); // Reload the page to display updated feedback list
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('Error submitting feedback: {ex.Message}');", true);
            }
        }


        protected void rptFeedback_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {

        }
    }
}
