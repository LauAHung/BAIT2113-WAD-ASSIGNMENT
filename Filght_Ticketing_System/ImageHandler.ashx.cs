using System;
using System.Data.SqlClient;
using System.Web;

public class ImageHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string airplaneID = context.Request.QueryString["airplaneID"];
        if (!string.IsNullOrEmpty(airplaneID))
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT airplaneImage FROM Airplane WHERE airplaneID = @airplaneID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@airplaneID", airplaneID);
                    conn.Open();

                    object image = cmd.ExecuteScalar();
                    if (image != null && image != DBNull.Value)
                    {
                        byte[] imageData = (byte[])image;
                        context.Response.ContentType = "image/jpeg"; 
                        context.Response.BinaryWrite(imageData);
                    }
                    else
                    {
                        context.Response.ContentType = "image/png";
                        context.Response.WriteFile(HttpContext.Current.Server.MapPath("~/Images/placeholder.png"));
                    }
                }
            }
        }
        else
        {
            context.Response.StatusCode = 400; 
            context.Response.Write("Invalid airplaneID.");
        }
    }

    public bool IsReusable => false;
}
