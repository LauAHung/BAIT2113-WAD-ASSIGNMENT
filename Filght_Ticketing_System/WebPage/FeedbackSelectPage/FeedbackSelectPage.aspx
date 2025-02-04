<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FeedbackSelectPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.FeedbackSelectPage.FeedbackSelectPage" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Main container for plane and train options */
        .large-square {
            display: flex;
            justify-content: space-evenly; /* 调整为更紧凑布局 */
            align-items: center;
            width: 100%;
            max-width: 800px; /* 调整最大宽度，使内容更居中 */
            margin: 50px auto; /* 居中显示 */
            gap: 20px; /* 选项间距 */
        }

        /* Individual selection button styling */
        .selection {
            cursor: pointer;
            width: 300px; /* 调整宽度 */
            height: 300px; /* 调整高度 */
            background-color: white;
            border-radius: 16px;
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .selection:hover {
            transform: scale(1.05);
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        }

        /* Image styling */
        .selection-image {
            width: 120px; /* 放大图片尺寸 */
            height: 120px;
            object-fit: cover;
        }

        /* Text styling */
        .selection-name {
            color: black;
            font-size: 22px; /* 放大文字 */
            font-weight: bold;
            margin-top: 20px;
        }
    </style>

    <h2 style="text-align: center;">Select Feedback Type to Rate</h2>

    <!-- Large square wrapping the options -->
    <div class="large-square">
        <!-- Flight selection -->
        <div class="selection" onclick="window.location.href='../../WebPage/FlightFeedbackPage/FlightFeedbackPage.aspx'">
            <img src="../../Images/planelogo.png" alt="Flight" class="selection-image" />
            <p class="selection-name">Flight</p>
        </div>

        <!-- Train selection -->
        <div class="selection" onclick="window.location.href='TrainFeedbackPage.aspx'">
            <img src="../../Images/trainlogo.png" alt="Train" class="selection-image" />
            <p class="selection-name">Train</p>
        </div>
    </div>
</asp:Content>
