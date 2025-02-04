<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplicationLogError.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.ApplicationLogError" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Log Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background-color: #f8f9fa;
            text-align: center;
        }

        .error-container {
            max-width: 600px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

            .error-container img {
                width: 100px;
                margin-bottom: 20px;
            }

            .error-container h1 {
                font-size: 24px;
                color: #d9534f;
                margin-bottom: 10px;
            }

            .error-container p {
                color: #333;
                margin-bottom: 20px;
            }

            .error-container .btn {
                display: inline-block;
                padding: 10px 20px;
                font-size: 16px;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                background-color: #0056b3;
            }

                .error-container .btn:hover {
                    background-color: #0056b3;
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="error-container">
            <img src="../Images/serverError.jpg" />
            <h1>Oops! Something went wrong.</h1>
            <p>We’re sorry for the inconvenience. Please try again later.</p>
            <asp:Button ID="btnHome" runat="server" CssClass="btn" Text="Return to Home" OnClick="btnHome_Click" />
        </div>
    </form>
</body>
</html>
