using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignemnt_Draft_1.WebPage.TngEwalletPaymentPage
{
    public partial class TngEwalletPaymentPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string totalPrice = Session["TotalPrice"]?.ToString();
            lblTotalPrice.Text = $"Total Price: {totalPrice}";


            if (Session["TransactionNo"] == null)
            {
                Session["TransactionNo"] = GenerateTransactionNumber();
            }

            if (Session["BookingID"] == null)
            {
                Session["BookingID"] = GenerateBookingID();
            }

            string transactionNo = Session["TransactionNo"].ToString();
            string bookingID = Session["BookingID"].ToString();

            // Display values on the page
            lblTransactionNo.Text = $"Transaction No.: {transactionNo}";
            lblBookingID.Text = $"Booking ID: {bookingID}";

        }

            private string GenerateTransactionNumber()
            {
                return DateTime.Now.Ticks.ToString(); // You can modify this to suit your needs
            }

            // Generate a random booking ID
            private string GenerateBookingID()
            {
                Random random = new Random();
                return random.Next(100000, 999999).ToString(); // 6-digit random number
            }
        
    }
}