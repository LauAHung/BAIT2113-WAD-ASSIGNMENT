using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignemnt_Draft_1.WebPage.TrainBookingPage
{
    public partial class TrainBookingPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string fromCity = Request.Form["txtFrom"];
                string toCity = Request.Form["txtTo"];
                string departDate = Request.Form["txtDepartDate"];
                if (!string.IsNullOrEmpty(fromCity) && !string.IsNullOrEmpty(toCity) && !string.IsNullOrEmpty(departDate))
                {
                    BindTrains(fromCity, toCity, departDate);
                }
            }
        }

        private void BindTrains(string departCity, string arriveCity, string departDate, string depTime = "")
        {
            string query = @"
    SELECT 
        t.trainNoID,
        t.departDateTime,
        t.arriveDateTime,
        t.departCity + ' → ' + t.arriveCity AS Route,
        t.trainStatus,
        t.price,
        t.duration,
        tr.trainName AS Company,
        'TrainIcon.png' AS TrainIconPath
    FROM TrainNo t
    JOIN Train tr ON t.trainID = tr.trainID
    WHERE t.departCity = @DepartCity
    AND t.arriveCity = @ArriveCity
    AND CAST(t.departDateTime AS DATE) = @DepartDate";

            if (!string.IsNullOrEmpty(depTime))
            {
                query += depTime switch
                {
                    "Early" => " AND DATEPART(HOUR, t.departDateTime) BETWEEN 0 AND 5",
                    "Morning" => " AND DATEPART(HOUR, t.departDateTime) BETWEEN 6 AND 11",
                    "Afternoon" => " AND DATEPART(HOUR, t.departDateTime) BETWEEN 12 AND 17",
                    "Night" => " AND DATEPART(HOUR, t.departDateTime) BETWEEN 18 AND 23",
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

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        Debug.WriteLine("No trains found for the specified search criteria.");
                    }
                    else
                    {
                        // Bind the results to the control
                        rptTrain.DataSource = dt;
                        rptTrain.DataBind();
                    }
                }
            }
        }


        [WebMethod]
        public static List<object> GetTrains(string searchTerm)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString))
            {
                string query = "SELECT city, trainDepotName FROM TrainDepot WHERE city LIKE @SearchTerm OR trainDepotName LIKE @SearchTerm";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                List<object> result = new List<object>();
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    result.Add(new
                    {
                        City = reader["city"].ToString(),
                        TrainDepotName = reader["trainDepotName"].ToString()
                    });
                }
                con.Close();
                return result;
            }
        }
        public class TrainDetails
        {
            public string TrainName { get; set; }
            public string DepartCity { get; set; }
            public string ArriveCity { get; set; }
            public string Company { get; set; }
        }

        public class TrainNo
        {
            public int trainNoID { get; set; }
            public DateTime departDateTime { get; set; }
            public DateTime arriveDateTime { get; set; }
            public string departCity { get; set; }
            public string arriveCity { get; set; }
            public string trainStatus { get; set; }
            public decimal price { get; set; }
            public decimal duration { get; set; }
            public int trainID { get; set; }
        }


        public class TrainDepot
        {
            public string City { get; set; }
            public string TrainDepotName { get; set; }
        }

        public class Train
        {
            public int trainID { get; set; }
            public string trainName { get; set; }
            public string trainStatus { get; set; }
            public string company { get; set; }
            public decimal capacity { get; set; }
            public int trainDepotID { get; set; }
        }
    }
}