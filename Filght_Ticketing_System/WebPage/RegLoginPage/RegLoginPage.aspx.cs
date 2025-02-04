using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using BCrypt.Net;

using System.Net.Mail;

namespace Assignemnt_Draft_1
{
    public partial class RegLoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["IsLoggedIn"] = false;
            }
        }

        protected void BtnForgotPassword_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", @"
        document.getElementById('ForgotPasswordModal').classList.add('active');
        document.getElementById('overlay').classList.add('active');
    ", true);
        }


        private string GenerateSalt()
        {
            byte[] saltBytes = new byte[16];
            using (var rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(saltBytes);
            }
            return Convert.ToBase64String(saltBytes);
        }

        private string HashPasswordWithSalt(string password, string salt)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                string saltedPassword = password + salt;
                byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(saltedPassword));
                return Convert.ToBase64String(hashBytes);
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            bool isValid = true;

            isValid &= ValidateEmail(txtLoginEmail, lblLoginEmailError);
            isValid &= ValidatePassword(txtLoginPassword, lblLoginPasswordError);

            if (!isValid)
            {
                return; 
            }

            int userID;
            string userType;
            string userStatus = string.Empty;

            if (ValidateLogin(txtLoginEmail.Text.Trim(), txtLoginPassword.Text.Trim(), out userID, out userType, out userStatus))
            {

                if (userStatus.Equals("Lock", StringComparison.OrdinalIgnoreCase))
                {
                    lblLoginEmailError.Text = "Your account has been locked.";
                    txtLoginEmail.BorderColor = System.Drawing.Color.Red;
                    txtLoginPassword.BorderColor = System.Drawing.Color.Red;
                    txtLoginPassword.Text = string.Empty;
                    return; // Stop further login processing if account is locked
                }


                Session["IsLoggedIn"] = true;
                Session["UserEmail"] = txtLoginEmail.Text.Trim();
                Session["UserID"] = userID;
                Session["UserType"] = userType;

                // Redirect based on userType
                if (userType.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("~/WebPage/AdministratorPage/AdministratorPage.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal",
                        "showModal('Login Successful', 'Welcome back! Redirecting to the homepage...');", true);
                }
            }
            else
            {
                lblLoginEmailError.Text = "Invalid email or password.";
                txtLoginEmail.BorderColor = System.Drawing.Color.Red;
                txtLoginPassword.BorderColor = System.Drawing.Color.Red;

                txtLoginPassword.Text = string.Empty; 
            }
        }




        protected void btnSignup_Click(object sender, EventArgs e)
        {

            bool isValid = true;

            isValid &= ValidateUsername(txtSignupUsername, lblSignupUsernameError);
            isValid &= ValidateEmail(txtSignupEmail, lblSignupEmailError);
            isValid &= ValidatePassword(txtSignupPassword, lblSignupPasswordError);

            if (txtSignupPassword.Text != txtSignupConfirmPassword.Text)
            {
                txtSignupConfirmPassword.BorderColor = System.Drawing.Color.Red;
                lblSignupConfirmPasswordError.Text = "Passwords do not match";
                isValid = false;
            }
            else
            {
                txtSignupConfirmPassword.BorderColor = System.Drawing.Color.Empty;
                lblSignupConfirmPasswordError.Text = "";
            }

            if (!isValid)
            {
                return;
            }


            if (RegisterUser(txtSignupUsername.Text, txtSignupEmail.Text, txtSignupPassword.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal",
                    "showModal('Registration Successful', 'Your account has been created! Redirecting to the homepage...');", true);
            }
            else
            {
                lblSignupSuccess.Text = "Registration failed. Please try again.";
                lblSignupSuccess.ForeColor = System.Drawing.Color.Red;
            }
        }

        public class LoginResult
        {
            public int UserID { get; set; }
            public string UserType { get; set; }
            public bool IsValid { get; set; }
        }

        private bool ValidateUsername(TextBox field, Label errorLabel)
        {
            if (string.IsNullOrWhiteSpace(field.Text))
            {
                field.BorderColor = System.Drawing.Color.Red;
                errorLabel.Text = "Username is required";
                return false;
            }
            else if (field.Text.Length > 15)
            {
                field.BorderColor = System.Drawing.Color.Red;
                errorLabel.Text = "Username cannot exceed 15 characters";
                return false;
            }
            else
            {
                field.BorderColor = System.Drawing.Color.Empty;
                errorLabel.Text = "";
                return true;
            }
        }

        private bool ValidateEmail(TextBox field, Label errorLabel)
        {
            string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            if (string.IsNullOrWhiteSpace(field.Text))
            {
                field.BorderColor = System.Drawing.Color.Red;
                errorLabel.Text = "Email is required";
                return false;
            }
            else if (!Regex.IsMatch(field.Text, emailPattern))
            {
                field.BorderColor = System.Drawing.Color.Red;
                errorLabel.Text = "Invalid email format";
                return false;
            }
            else
            {
                field.BorderColor = System.Drawing.Color.Empty;
                errorLabel.Text = "";
                return true;
            }
        }

        private bool ValidatePassword(TextBox field, Label errorLabel)
        {
            string passwordPattern = @"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
            if (string.IsNullOrWhiteSpace(field.Text))
            {
                field.BorderColor = System.Drawing.Color.Red;
                errorLabel.Text = "Password is required";
                return false;
            }
            else if (!Regex.IsMatch(field.Text, passwordPattern))
            {
                field.BorderColor = System.Drawing.Color.Red;
                errorLabel.Text = "Weak password! ";
                return false;
            }
            else
            {
                field.BorderColor = System.Drawing.Color.Empty;
                errorLabel.Text = "";
                return true;
            }
        }

        private bool RegisterUser(string username, string email, string password)
        {
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                string getNextUserIDQuery = "SELECT ISNULL(MAX(userID), 9000) + 1 FROM UserRegistration";
                SqlCommand getNextUserIDCmd = new SqlCommand(getNextUserIDQuery, conn);

                string query = "INSERT INTO UserRegistration (userID, userName, userEmail, userPassword, createdDate, userType, userStatus) " +
                               "VALUES (@userID, @userName, @userEmail, @userPassword, @createdDate, @userType, @userStatus)";
                SqlCommand cmd = new SqlCommand(query, conn);

                try
                {
                    conn.Open();

                    int nextUserID = (int)getNextUserIDCmd.ExecuteScalar();

                    cmd.Parameters.AddWithValue("@userID", nextUserID);
                    cmd.Parameters.AddWithValue("@userName", username);
                    cmd.Parameters.AddWithValue("@userEmail", email);
                    cmd.Parameters.AddWithValue("@userPassword", hashedPassword);
                    cmd.Parameters.AddWithValue("@createdDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@userType", "User");
                    cmd.Parameters.AddWithValue("@userStatus", "Active");

                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch (Exception)
                {
                    return false;
                }
            }
        }


        protected void btnHomePage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/WebPage/HomePage/HomePage.aspx");
        }

        private bool ValidateLogin(string email, string password, out int userID, out string userType, out string userStatus)
        {
            userID = -1;
            userType = null;
            userStatus = string.Empty; // Initialize userStatus

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                string query = "SELECT userID, userPassword, userType, userStatus FROM UserRegistration WHERE userEmail = @userEmail";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userEmail", email);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string storedHash = reader["userPassword"].ToString();
                        userID = Convert.ToInt32(reader["userID"]);
                        userType = reader["userType"].ToString();
                        userStatus = reader["userStatus"].ToString(); // Retrieve userStatus from the database

                        // Verify the password using BCrypt
                        if (BCrypt.Net.BCrypt.Verify(password, storedHash))
                        {
                            return true;
                        }
                        else
                        {
                            return false; // Incorrect password
                        }
                    }
                    else
                    {
                        return false; // Email not found
                    }
                }
                catch (Exception)
                {
                    // Log exception or handle as necessary
                    return false;
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
            string email = txtEmail.Text.Trim();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                string query = "SELECT COUNT(*) FROM UserRegistration WHERE userEmail = @userEmail";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userEmail", email);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    Session["UserEmail"] = email;

                    Random random = new Random();
                    string verificationCode = random.Next(100000, 999999).ToString();
                    Session["VerificationCode"] = verificationCode;

                    MailMessage mail = new MailMessage
                    {
                        From = new MailAddress("noreplytravelfreesdnbhd@gmail.com"),
                        Subject = "Email Verification Code",
                        Body = $"<p>Your verification code is:</p><h2>{verificationCode}</h2>",
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

                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", @"
    document.getElementById('VerifyIdentityModal').style.display = 'block';
    document.getElementById('overlay').style.display = 'block';
", true);


                }
                else
                {

                    lblEmailError.Text = "Email not found.";

                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", @"
    document.getElementById('ForgotPasswordModal').style.display = 'block';
    document.getElementById('overlay').style.display = 'block';
", true);

                }
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
                string showChangePasswordModalScript = @"
            document.getElementById('ChangePasswordModal').classList.add('active');
            document.getElementById('overlay').classList.add('active');
        ";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowChangePasswordModal", showChangePasswordModalScript, true);

                Session["VerificationCode"] = null;
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid verification code. Please try again.');", true);
            }
        }

        protected void btnSetPassword_Click(object sender, EventArgs e)
        {
            string newPassword = txtPasswordSet.Text;
            string repeatPassword = txtRepeatPasswordSet.Text;

            if (newPassword != repeatPassword)
            {
                lblErrorPassword.Text = "Passwords do not match.";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowChangePasswordModal", @"
            document.getElementById('ChangePasswordModal').classList.add('active');
            document.getElementById('overlay').classList.add('active');
        ", true);
                return;
            }

            string userEmail = Session["UserEmail"]?.ToString();
            if (string.IsNullOrEmpty(userEmail))
            {
                lblErrorPassword.Text = "Session expired. Please try again.";
                return;
            }

            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(newPassword);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                string query = "UPDATE UserRegistration SET userPassword = @newPassword WHERE userEmail = @userEmail";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@newPassword", hashedPassword);
                cmd.Parameters.AddWithValue("@userEmail", userEmail);

                conn.Open();
                cmd.ExecuteNonQuery();
            }


            string showSuccessModalScript = @"
        document.getElementById('SuccessfulModal').classList.add('active');
        document.getElementById('overlay').classList.add('active');
        setTimeout(function() {
            document.getElementById('SuccessfulModal').classList.remove('active');
            document.getElementById('overlay').classList.remove('active');
        }, 3000); // Hide modal after 3 seconds
    ";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessModal", showSuccessModalScript, true);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseModal", @"
        document.getElementById('VerifyIdentityModal').classList.remove('active');
        document.getElementById('overlay').classList.remove('active');
    ", true);
        }

    }
}
