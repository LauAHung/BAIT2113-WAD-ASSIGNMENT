using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignemnt_Draft_1.WebPage
{
    public partial class FlightPaymentPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string fromLocation = Session["FromLocation"]?.ToString();
                string toLocation = Session["ToLocation"]?.ToString();
                string departDate = Session["DepartDate"]?.ToString();
                string departTimeStart = Session["DepartTimeStart"]?.ToString();
                string departTimeEnd = Session["DepartTimeEnd"]?.ToString();
                string returnDate = Session["ReturnDate"]?.ToString();
                string returnTimeStart = Session["ReturnTimeStart"]?.ToString();
                string returnTimeEnd = Session["ReturnTimeEnd"]?.ToString();
                string totalPassengers = Session["TotalPassengers"]?.ToString();
                string totalPrice = Session["TotalPrice"]?.ToString();

                lblBookingInfo.Text = $@"
            <h3>Booking Info</h3>
            <p><strong>{fromLocation} ⇌ {toLocation}</strong></p>
            <p>Depart: {departDate} - {departTimeStart} → {departTimeEnd}</p>
            <p>Return: {returnDate} - {returnTimeStart} → {returnTimeEnd}</p>
            <p>Total Passenger: {totalPassengers}</p>
            <h3>Total Price: {totalPrice}</h3>";
            }
        }


        protected void btnCreditCardOption_Click(object sender, EventArgs e)
        {
            Session["TotalPrice"] = Session["TotalPrice"];
            Response.Redirect("~/WebPage/CreditCardPaymentPage/CreditCardPaymentPage.aspx");
        }

        protected void TngOption_Click(object sender, EventArgs e)
        {
            Session["TotalPrice"] = Session["TotalPrice"];

            Response.Redirect("~/WebPage/TngEwalletPaymentPage/TngEwalletPaymentPage.aspx");
        }


    }
}