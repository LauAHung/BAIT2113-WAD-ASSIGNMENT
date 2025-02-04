using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using BCrypt.Net;
using System.Web.UI.WebControls;

namespace Assignemnt_Draft_1.WebPage
{
    public partial class UserAccountPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            System.Diagnostics.Debug.WriteLine($"UserEmail: {Session["UserEmail"]}");
            System.Diagnostics.Debug.WriteLine($"UserID: {Session["UserID"]}");

            PopulateDayDropdown();
            PopulateMonthDropdown();
            PopulateYearDropdown();

            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                ShowLoginPrompt();
                SetDefaultAvatar();
            }
            else if (!IsPostBack)
            {
                lblEmail.Text = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "-";
                hfModalState.Value = "close";

                if (Session["UserID"] != null)
                {
                    int userID = Convert.ToInt32(Session["UserID"]);
                    LoadPhoneNumber(userID);
                    LoadPersonalDetails(userID);
                    LoadUserAvatar(userID); // 调用加载头像的方法

                }
                else
                {
                    SetDefaultAvatar(); // 如果是首次登录或无用户 ID，显示默认头像
                }
            }
        }

        private void LoadUserAvatar(int userID)
        {
            try
            {
                string connString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "SELECT userAvatar FROM UserRegistration WHERE userID = @userID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@userID", userID);
                        conn.Open();
                        object avatarData = cmd.ExecuteScalar();

                        if (avatarData != null && avatarData != DBNull.Value)
                        {
                            imgAvatar.ImageUrl = "~/AvatarHandler.ashx?userID=" + Session["UserID"];
                        }
                        else
                        {
                            SetDefaultAvatar();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetDefaultAvatar(); 
                System.Diagnostics.Debug.WriteLine("Error loading avatar: " + ex.Message);
            }
        }

        private void SetDefaultAvatar()
        {
            // 设置默认头像路径
            imgAvatar.ImageUrl = "../../Images/avatar-icon.png";
        }

        protected void UploadAvatar(object sender, EventArgs e)
        {
            try
            {
                if (fileUploadAvatar.HasFile)
                {
                    string fileExtension = System.IO.Path.GetExtension(fileUploadAvatar.FileName).ToLower();
                    if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".jpeg")
                    {
                        byte[] uploadedImage = null;
                        using (System.IO.Stream fs = fileUploadAvatar.PostedFile.InputStream)
                        {
                            using (System.IO.BinaryReader br = new System.IO.BinaryReader(fs))
                            {
                                uploadedImage = br.ReadBytes((int)fs.Length);
                            }
                        }

                        SaveAvatarToDatabase(uploadedImage);

                        lblAvatarUploadMessage.Text = "Avatar uploaded successfully!";
                        lblAvatarUploadMessage.ForeColor = System.Drawing.Color.Green;

                        imgAvatar.ImageUrl = "~/AvatarHandler.ashx?userID=" + Session["UserID"] + "&t=" + DateTime.Now.Ticks;
                    }
                    else
                    {
                        lblAvatarUploadMessage.Text = "Only .jpg, .jpeg, and .png files are allowed.";
                        lblAvatarUploadMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    lblAvatarUploadMessage.Text = "Please select an image to upload.";
                    lblAvatarUploadMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblAvatarUploadMessage.Text = "Error: " + ex.Message;
                lblAvatarUploadMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        private void SaveAvatarToDatabase(byte[] uploadedImage)
        {
            try
            {
                int userID = Convert.ToInt32(Session["UserID"]);
                string connString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "UPDATE UserRegistration SET userAvatar = @userAvatar WHERE userID = @userID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@userAvatar", uploadedImage);
                        cmd.Parameters.AddWithValue("@userID", userID);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                lblAvatarUploadMessage.Text = "Error saving avatar: " + ex.Message;
                lblAvatarUploadMessage.ForeColor = System.Drawing.Color.Red;
            }
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


        private void PopulateDayDropdown()
        {
            ddlDay.Items.Clear();
            for (int day = 1; day <= 31; day++)
            {
                ddlDay.Items.Add(new ListItem(day.ToString(), day.ToString()));
            }
        }

        private void PopulateMonthDropdown()
        {
            ddlMonth.Items.Clear();
            for (int month = 1; month <= 12; month++)
            {
                ddlMonth.Items.Add(new ListItem(month.ToString("D2"), month.ToString()));
            }
        }

        private void PopulateYearDropdown()
        {
            ddlYear.Items.Clear();
            int currentYear = DateTime.Now.Year;
            for (int year = currentYear; year >= 1900; year--)
            {
                ddlYear.Items.Add(new ListItem(year.ToString(), year.ToString()));
            }
        }

        private bool IsUserLoggedIn()
        {

            return Session["UserID"] != null;
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

        protected void btnUpdateEmail_Click(object sender, EventArgs e)
        {
            string currentEmail = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "N/A";

            string showModalScript = $@"
        document.getElementById('UpdateEmailModal').classList.add('active');
        document.getElementById('overlay').classList.add('active');
        document.getElementById('currentEmail').innerHTML = '{currentEmail}';
    ";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowEmailModal", showModalScript, true);
        }

        private void LoadPhoneNumber(int userID)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                string query = "SELECT userContactNo FROM UserRegistration WHERE userID = @userID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userID", userID);

                try
                {
                    conn.Open();
                    string phoneNumber = cmd.ExecuteScalar()?.ToString()?.Trim();

                    if (!string.IsNullOrEmpty(phoneNumber))
                    {
                        Phone_No.Text = phoneNumber;
                    }
                }
                catch (Exception ex)
                {
                    Phone_No.Text = "Error loading phone number.";
                    System.Diagnostics.Debug.WriteLine("Error loading phone number: " + ex.Message);
                }
            }
        }

        private string GenerateVerificationCode()
        {
            Random random = new Random();
            return random.Next(100000, 999999).ToString();
        }

        protected void btnVerifyIdentity_Click(object sender, EventArgs e)
        {
            string currentEmail = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : null;

            if (string.IsNullOrEmpty(currentEmail))
            {
                string errorScript = "alert('User email not found. Please log in again.');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorScript", errorScript, true);
                return;
            }

            string verificationCode = GenerateVerificationCode();
            Session["VerificationCode"] = verificationCode;

            try
            {
                MailMessage mail = new MailMessage
                {
                    From = new MailAddress("noreplytravelfreesdnbhd@gmail.com"),
                    Subject = "Email Changing Verification Code",
                    Body = $"<p>Your verification code is:</p><h2>{verificationCode}</h2>",
                    IsBodyHtml = true
                };
                mail.To.Add(currentEmail);

                SmtpClient smtp = new SmtpClient("smtp.gmail.com")
                {
                    Port = 587,
                    Credentials = new System.Net.NetworkCredential("noreplytravelfreesdnbhd@gmail.com", "jnby yrik cjdh opjj"),
                    EnableSsl = true
                };

                smtp.Send(mail);

                string successScript = @"
            document.getElementById('VerifyIdentityModal').classList.add('active');
            document.getElementById('overlay').classList.add('active');
            document.getElementById('currentEmail').innerHTML = '" + currentEmail + @"';
        ";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowVerificationModal", successScript, true);
            }
            catch (Exception ex)
            {
                string errorScript = "alert('Failed to send verification code. Please try again.');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorScript", errorScript, true);

                System.Diagnostics.Debug.WriteLine("Error sending email: " + ex.Message);
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            string enteredCode = txtVerificationCode.Text;
            string storedCode = Session["VerificationCode"]?.ToString();

            if (string.IsNullOrEmpty(enteredCode))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter the verification code.');", true);
                return;
            }

            if (storedCode == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('No verification code was found.');", true);
                return;
            }

            if (enteredCode == storedCode)
            {
                string showChangeEmailModalScript = @"
            document.getElementById('ChangeEmailModal').classList.add('active');
            document.getElementById('overlay').classList.add('active');
        ";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowChangeEmailModal", showChangeEmailModalScript, true);

                Session["VerificationCode"] = null;
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid verification code. Please try again.');", true);
            }
        }


        private bool IsValidEmail(string email)
        {
            try
            {
                var mailAddress = new System.Net.Mail.MailAddress(email);
                return mailAddress.Address == email;
            }
            catch
            {
                return false;
            }
        }

        protected void btnEmailNew_Click(object sender, EventArgs e)
        {
            string newEmail = TextBox1.Text.Trim();

            if (string.IsNullOrEmpty(newEmail) || !IsValidEmail(newEmail))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter a valid email address.');", true);
                return;
            }

            string userEmail = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : string.Empty;
            int userID = Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : 0;

            if (string.IsNullOrEmpty(userEmail) || userID == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User not found. Please log in again.');", true);
                return;
            }

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE UserRegistration SET userEmail = @Email WHERE userID = @UserID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", newEmail);
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                Session["UserEmail"] = newEmail;

                lblEmail.Text = newEmail;

                string showSuccessModalScript = @"
            document.getElementById('SuccessfulModal').classList.add('active');
            document.getElementById('overlay').classList.add('active');

    setTimeout(function() {
        document.getElementById('SuccessfulModal').classList.remove('active');
        document.getElementById('overlay').classList.remove('active');
    }, 3000); 
        ";


                ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessModal", showSuccessModalScript, true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Failed to update email. Please try again.');", true);
                System.Diagnostics.Debug.WriteLine("Error updating email: " + ex.Message);
            }
        }



        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseModal", @"
        document.getElementById('VerifyIdentityModal').classList.remove('active');
        document.getElementById('overlay').classList.remove('active');
    ", true);
        }



        protected void btnLinkPhone_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", @"
                document.getElementById('LinkPhoneNoModal').classList.add('active');
                document.getElementById('overlay').classList.add('active');
            ", true);
        }

        protected void btnAddPhone_Click(object sender, EventArgs e)
        {
            string country = txtCountry.Text.Trim();
            string phoneNumber = TextBox2.Text.Trim();

            System.Diagnostics.Debug.WriteLine($"Input Country: {country}, Input Phone Number: {phoneNumber}");

            if (string.IsNullOrWhiteSpace(country) || string.IsNullOrWhiteSpace(phoneNumber) || !Regex.IsMatch(phoneNumber, @"^\d+$"))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorModal",
                    "alert('Please enter a valid country and phone number.');", true);
                return;
            }

            string callingCode = GetCallingCodeByCountry(country);
            System.Diagnostics.Debug.WriteLine($"Retrieved Calling Code: {callingCode}");

            if (string.IsNullOrWhiteSpace(callingCode))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorModal",
                    "alert('Invalid country selected.');", true);
                return;
            }

            string formattedPhoneNumber = $"{callingCode} {phoneNumber}";

            if (Session["UserID"] == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorModal",
                    "alert('User session expired. Please log in again.');", true);
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                string query = @"
        UPDATE UserRegistration 
        SET userContactNo = @userContactNo, CountryId = 
            (SELECT CountryId FROM Country WHERE callingCodes = @callingCode) 
        WHERE userID = @userID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userContactNo", formattedPhoneNumber);
                cmd.Parameters.AddWithValue("@callingCode", callingCode);
                cmd.Parameters.AddWithValue("@userID", userID);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    Phone_No.Text = formattedPhoneNumber;

                    // Show success message
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal",
                        "alert('Phone number updated successfully!');" +
                        "document.getElementById('LinkPhoneNoModal').style.display = 'none';", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showErrorModal",
                        $"alert('Error updating phone number: {ex.Message}');", true);
                }
            }
        }

        private string GetCallingCodeByCountry(string input)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))

            {
                string query = "SELECT callingCodes FROM Country WHERE CountryName = @input OR callingCodes = @input";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@input", input);

                try
                {
                    conn.Open();
                    return cmd.ExecuteScalar()?.ToString()?.Trim();
                }
                catch
                {
                    return null;
                }
            }
        }



        protected void btnSetPassword_Click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", @"
        document.getElementById('ChangePasswordModal').classList.add('active');
        document.getElementById('overlay').classList.add('active');
    ", true);

            string newPassword = txtPasswordSet.Text.Trim();
            string repeatPassword = txtRepeatPasswordSet.Text.Trim();

            if (string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(repeatPassword))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorModal",
                    "alert('Password fields cannot be empty.');", true);
                return;
            }

            if (newPassword != repeatPassword)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorModal",
                    "alert('Passwords do not match. Please try again.');", true);
                return;
            }

            if (Session["UserID"] == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorModal",
                    "alert('User session expired. Please log in again.');", true);
                return;
            }

            string passwordPattern = @"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
            if (!Regex.IsMatch(newPassword, passwordPattern))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorModal",
                    "alert('Password must be at least 8 characters long, contain an uppercase letter, a number, and a special character.');", true);
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]);

            try
            {
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(newPassword);

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
                {
                    string query = "UPDATE UserRegistration SET userPassword = @newPassword WHERE userID = @userID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@newPassword", hashedPassword);
                    cmd.Parameters.AddWithValue("@userID", userID);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal",
                        "alert('Password updated successfully!');", true);
                }
            }
            catch (Exception ex)
            {

                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorModal",
                    "alert('An error occurred while updating your password. Please try again later.');", true);
            }
        }

        private void LoadPersonalDetails(int userID)
        {
            string query = @"SELECT userFirstName, userLastName, gender, dateOfBirth 
                     FROM UserRegistration 
                     WHERE userID = @UserID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        lblDisplayFirstName.Text = reader["userFirstName"]?.ToString() ?? "-";
                        lblDisplayLastName.Text = reader["userLastName"]?.ToString() ?? "-";
                        lblGender.Text = reader["gender"]?.ToString() ?? "-";

                        lblDisplayDateOfBirth.Text = reader["dateOfBirth"] != DBNull.Value
                            ? Convert.ToDateTime(reader["dateOfBirth"]).ToString("yyyy-MM-dd")
                            : "-";
                    }
                    else
                    {
                        lblDisplayFirstName.Text = "-";
                        lblDisplayLastName.Text = "-";
                        lblGender.Text = "-";
                        lblDisplayDateOfBirth.Text = "-";
                    }
                }
            }
        }

        protected void btnEditPersonalInfo_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string query = "SELECT userFirstName, userLastName, gender, dateOfBirth FROM UserRegistration WHERE userID = @UserID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtFirstName.Text = reader["userFirstName"].ToString();
                        txtLastName.Text = reader["userLastName"].ToString();
                        DropDownList1.SelectedValue = reader["gender"].ToString();
                        if (DateTime.TryParse(reader["dateOfBirth"].ToString(), out DateTime dob))
                        {
                            ddlDay.SelectedValue = dob.Day.ToString();
                            ddlMonth.SelectedValue = dob.Month.ToString();
                            ddlYear.SelectedValue = dob.Year.ToString();
                        }
                    }
                }
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", @"
                document.getElementById('PersonalInformationModal').classList.add('active');
                document.getElementById('overlay').classList.add('active');
            ", true);
        }

        protected void btnEditInfo_Click(object sender, EventArgs e)
        {
            // Get user inputs
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string gender = DropDownList1.SelectedValue;
            int day = int.Parse(ddlDay.SelectedValue);
            int month = int.Parse(ddlMonth.SelectedValue);
            int year = int.Parse(ddlYear.SelectedValue);

            DateTime dob = new DateTime(year, month, day);

            int userId = Convert.ToInt32(Session["UserID"]);

            string updateQuery = @"UPDATE UserRegistration 
                           SET userFirstName = @FirstName, userLastName = @LastName, 
                               gender = @Gender, dateOfBirth = @DateOfBirth
                           WHERE userID = @UserID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@DateOfBirth", dob);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            lblDisplayFirstName.Text = firstName;
            lblDisplayLastName.Text = lastName;
            lblGender.Text = gender;
            lblDisplayDateOfBirth.Text = dob.ToString("yyyy-MM-dd");

            hfModalState.Value = "close";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "hideModal('PersonalInformationModal');", true);
        }


        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/WebPage/RegLoginPage/RegLoginPage.aspx");
        }


    }
}