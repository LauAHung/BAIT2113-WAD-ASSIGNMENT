using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignemnt_Draft_1.WebPage.CreditCardPaymentPage
{
    public partial class CreditCardPaymentPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblFromLocation.Text = Session["FromLocation"]?.ToString() ?? "N/A";
                lblToLocation.Text = Session["ToLocation"]?.ToString() ?? "N/A";
                lblDepartDate.Text = Session["DepartDate"]?.ToString() ?? "N/A";
                lblReturnDate.Text = Session["ReturnDate"]?.ToString() ?? "N/A";
                lblTotalPrice.Text = Session["TotalPrice"]?.ToString() ?? "N/A";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string cardNumber = txtCardNumber.Text.Trim();
            string cardHolderName = txtCardHolderName.Text.Trim();
            string expiryDate = txtCardExpire.Text.Trim();
            string cvv = txtCardCVV.Text.Trim();

            string validationError = ValidatePaymentDetails(cardNumber, cardHolderName, expiryDate, cvv);

            if (!string.IsNullOrEmpty(validationError))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{validationError}');", true);
                return;
            }

            bool isPaymentSuccessful = ProcessPayment(cardNumber, cardHolderName, expiryDate, cvv);

            if (isPaymentSuccessful)
            {
                Response.Redirect("~/WebPage/UserBookingPage/UserBookingPage.aspx");

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Payment failed. Please try again.');", true);
            }
        }

        private string ValidatePaymentDetails(string cardNumber, string cardHolderName, string expiryDate, string cvv)
        {
            if (!Regex.IsMatch(cardNumber, @"^\d{16}$"))
            {
                return "Invalid card number. Please enter a valid 16-digit card number.";
            }

            if (cardHolderName.Length < 3 || !Regex.IsMatch(cardHolderName, @"^[a-zA-Z\s]+$"))
            {
                return "Invalid cardholder name. It must be at least 3 characters long and contain only letters.";
            }

            if (!Regex.IsMatch(expiryDate, @"^(0[1-9]|1[0-2])\/\d{2}$"))
            {
                return "Invalid expiry date. Please enter in MM/YY format.";
            }

            // Check if card is expired
            string[] expParts = expiryDate.Split('/');
            int expMonth = int.Parse(expParts[0]);
            int expYear = int.Parse(expParts[1]) + 2000;

            DateTime currentDate = DateTime.Now;
            DateTime expiryDateTime = new DateTime(expYear, expMonth, 1).AddMonths(1).AddDays(-1);

            if (expiryDateTime < currentDate)
            {
                return "The card is expired.";
            }

            if (!Regex.IsMatch(cvv, @"^\d{3}$"))
            {
                return "Invalid CVV. Please enter a valid 3-digit number.";
            }

            return null; 
        }

        private bool ProcessPayment(string cardNumber, string cardHolderName, string expiryDate, string cvv)
        {

            return true; 
        }
    }
}