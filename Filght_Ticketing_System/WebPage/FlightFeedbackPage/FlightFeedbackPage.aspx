  <%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FlightFeedbackPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.FeedBack.FeedbackPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Outer container for centering the large square */
        .outer-container {
            display: flex;
            justify-content: center; /* Centers horizontally */
            align-items: center; /* Centers vertically */
            min-height: 80vh; /* Adjust height as needed */
            margin: 0 10px; /* Margin on left and right of the large square */
            margin-bottom: 50px;
        }

        /* Large square wrapping the grid */
        .large-square {
            background-color: white; /* Background color for large square */
            border-radius: 16px; /* Rounded corners */
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2); /* Shadow for large square */
            padding: 40px; /* Space inside the large square */
            width: 100%; /* Ensures responsiveness */
            max-width: 800px; /* Limit maximum width of the square */
        }

        /* Grid layout for flight companies */
        .flight-companies {
            display: grid; /* Using grid for layout */
            grid-template-columns: repeat(3, 1fr); /* 3 companies per row */
            row-gap: 30px; /* Increased space between rows */
            column-gap: 20px; /* Space between columns */
        }

        /* Style for each company block */
        .company {
            cursor: pointer;
            width: 200px; /* Fixed width for company block */
            height: 200px; /* Fixed height for company block */
            background-color: white; /* Background color for small squares */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            margin: auto; /* Centers the small squares inside the grid cell */
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition on hover */
        }

        /* Hover effect for company blocks */
        .company:hover {
            transform: scale(1.05); /* Slightly enlarges the block */
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2); /* Increases shadow on hover */
        }

        /* Image styling */
        .company-image {
            width: 100px; /* Adjust image size */
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }

        /* Text styling */
        .company-name {
            color: black;
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>

    <h2 style="text-align: center;">Choose a Flight Company</h2>

    <!-- Outer container for centering -->
    <div class="outer-container">
        <!-- Large square wrapping the grid -->
        <div class="large-square">
            <div class="flight-companies">
                <asp:Repeater ID="rptAirplaneFeedback" runat="server">
                    <ItemTemplate>
                        <!-- Dynamically generated company block -->
                        <div class="company" id="company_<%# Eval("airplaneID") %>" 
                             onclick="window.location.href='../../WebPage/FlightFeedbackRate/FlightFeedbackRate.aspx?company=<%# Eval("airplaneID") %>'">
                            <!-- Dynamically bind image and name -->
                            <asp:Image ID="imgAirplaneFeedback" runat="server" class="company-image" 
                                       ImageUrl='<%# "~/ImageHandler.ashx?airplaneID=" + Eval("airplaneID") %>' 
                                       alt='<%# Eval("airplaneName") %>' />
                            <p class="company-name"><%# Eval("airplaneName") %></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>

