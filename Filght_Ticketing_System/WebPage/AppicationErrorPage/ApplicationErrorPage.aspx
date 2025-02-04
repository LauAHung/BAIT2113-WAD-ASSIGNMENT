<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplicationErrorPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.ApplicationErrorPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>404 Page Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        img {
            max-width: 500px;
            margin-bottom: 20px;
        }

        h1 {
            font-size: 36px;
            color: #333;
            margin: 10px 0;
        }

        p {
            font-size: 18px;
            color: #666;
            margin: 5px 0 20px;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }

            .btn:hover {
                background-color: #0056b3;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <img src="../../Images/ApplicationNotFound.png" />
            <h1>404 - Page Not Found</h1>
            <p>Sorry, the page you are looking for does not exist.</p>
            <asp:Button ID="btnHome" runat="server" CssClass="btn" Text="Return to Home" OnClick="btnHome_Click" />
        </div>
    </form>
</body>
</html>
