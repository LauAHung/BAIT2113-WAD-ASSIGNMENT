using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignemnt_Draft_1.WebPage.FeedBack
{
    public partial class FeedbackPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    BindAirplaneData();
                }
                catch (Exception ex)
                {
                    // 显示错误消息，或记录日志

                    // Log error (use a logging framework)
                }
            }
        }

        private void BindAirplaneData()
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["FlightSystemDatabase"].ConnectionString;
            string query = "SELECT airplaneID, airplaneName, airplaneImage FROM Airplane";

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            rptAirplaneFeedback.DataSource = reader;
                            rptAirplaneFeedback.DataBind();
                        }
                        else
                        {
                            // 如果没有数据，显示提示信息

                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                // 捕获SQL异常，记录日志或通知用户
                throw new Exception("数据库操作失败，请检查连接配置或数据库状态。", ex);
            }
        }
    }
}
