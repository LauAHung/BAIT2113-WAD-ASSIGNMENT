using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;

namespace Assignemnt_Draft_1
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition(
                "jquery",
                new ScriptResourceDefinition
                {
                    Path = "~/Scripts/jquery-3.6.0.min.js", // Adjust the path based on your jQuery version and location
                    DebugPath = "~/Scripts/jquery-3.6.0.js",
                    CdnPath = "https://code.jquery.com/jquery-3.6.0.min.js",
                    CdnDebugPath = "https://code.jquery.com/jquery-3.6.0.js",
                    CdnSupportsSecureConnection = true
                });
        }


        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception lastError = Server.GetLastError();

            LogError(lastError);

            if (lastError is HttpException httpException)
            {
                int httpCode = httpException.GetHttpCode();

                if (httpCode == 404)
                {
                    Server.ClearError();
                    Response.Redirect("~/WebPage/ApplicationErrorPage/ApplicationErrorPage.aspx");
                }
                else
                {
                    Server.ClearError();
                    Response.Redirect("~/WebPage/ApplicationLogError/ApplicationLogError.aspx");
                }
            }
            else
            {
                Server.ClearError();
                Response.Redirect("~/WebPage/ApplicationLogError/ApplicationLogError.aspx");
            }
        }

        private void LogError(Exception ex)
        {
            string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");

            string errorDetails = $@"
            Time: {DateTime.Now}
            Message: {ex.Message}
            StackTrace: {ex.StackTrace}
            InnerException: {ex.InnerException?.Message}
        ";

            System.IO.File.AppendAllText(logFilePath, errorDetails);
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}