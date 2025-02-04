using System.Data.SqlClient;
using System.Web;
using System;

public class AvatarHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string userID = context.Request.QueryString["userID"];
        if (string.IsNullOrEmpty(userID))
        {
            context.Response.StatusCode = 400;
            context.Response.Write("Invalid userID.");
            return;
        }

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

                    object image = cmd.ExecuteScalar();
                    if (image != null && image != DBNull.Value)
                    {
                        byte[] imageData = (byte[])image;
                        context.Response.ContentType = "image/jpeg"; // 默认设置为 JPEG
                        context.Response.BinaryWrite(imageData);
                    }
                    else
                    {
                        ServeDefaultAvatar(context);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // 日志记录（可选）
            LogError(ex);

            // 返回 500 错误
            context.Response.StatusCode = 500;
            context.Response.Write("An error occurred while retrieving the avatar.");
        }
    }

    private void ServeDefaultAvatar(HttpContext context)
    {
        context.Response.ContentType = "image/png";
        context.Response.WriteFile(HttpContext.Current.Server.MapPath("~/Images/avatar-icon.png"));
    }

    private void LogError(Exception ex)
    {
        // 简单错误日志记录，实际应用中可以替换为更复杂的日志框架
        System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");
    }

    public bool IsReusable => false;
}
