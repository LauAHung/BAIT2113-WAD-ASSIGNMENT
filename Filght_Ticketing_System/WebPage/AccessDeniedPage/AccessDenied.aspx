<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="AccessDenied.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.AccessDenied.AccessDenied" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f5f5f5;
        }

        .container {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
            max-width: 800px;
            width: 100%;
            padding: 20px;
            background: #ffffff;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }

        .left-content {
            flex: 1;
            margin-right: 20px;
        }

        .left-content h1 {
            color: #d9534f;
            font-size: 24px;
            margin-bottom: 10px;
        }

        .left-content p {
            font-size: 14px;
            color: #555;
            margin-bottom: 20px;
        }

        .left-content button, .left-content asp:Button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .left-content asp:Button:hover {
            background-color: #0056b3;
        }

        .right-content img {
            max-width: 200px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

            <div class="left-content">
                <h1>You don't have access to the page!</h1>
                <p>Only the authorized person can access the administrator page.</p>
                <asp:Button ID="btnGoBack" runat="server" Text="Go Back" OnClick="btnGoBack_Click" CssClass="go-back-button" />
            </div>

            <div class="right-content">
                <asp:Image ID="imgAccessDenied" runat="server" ImageUrl="~/Images/AccessD.jpg" AlternateText="Access Denied" />
            </div>
        </div>
    </form>
</body>
</html>