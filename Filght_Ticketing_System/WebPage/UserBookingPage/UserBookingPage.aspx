<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserBookingPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.UserBookingPage" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        /* Overall layout */
        .container {
            display: flex;
            font-family: Arial, sans-serif;
        }

        /* Sidebar */
        .sidebar {
            width: 200px;
            background-color: #f5f5f5;
            padding: 20px 0;
            border-right: 1px solid #ddd;
        }

        .menu-item {
            padding: 15px 20px;
            font-size: 16px;
            color: #333;
            cursor: pointer;
            display: flex;
            align-items: center;
        }

            .menu-item:hover,
            .menu-item.selected {
                background-color: #e3f2fd;
                color: #007bff;
            }

            .menu-item .icon-flight:before,
            .menu-item .icon-hotel:before {
                font-family: FontAwesome;
                margin-right: 10px;
            }

            .menu-item .icon-flight:before {
                content: "\f072"; /* FontAwesome airplane icon */
            }

            .menu-item .icon-hotel:before {
                content: "\f236"; /* FontAwesome bed icon */
            }

        /* Content Area */
        .content {
            flex: 1;
            padding: 30px;
        }

            .content h1 {
                font-size: 24px;
                margin-bottom: 10px;
            }

        .tabs {
            margin-bottom: 20px;
        }

        .tab-button {
            background-color: #f5f5f5;
            border: none;
            padding: 10px 20px;
            margin-right: 10px;
            cursor: pointer;
            border-radius: 20px;
            color: #333;
            font-size: 14px;
        }

            .tab-button.active {
                background-color: #4caf50;
                color: #fff;
            }

            .tab-button:hover {
                background-color: #e0e0e0;
            }

        /* Search bar */
        .search-bar {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px 0 0 5px;
            outline: none;
        }

        .search-button {
            background-color: #f5f5f5;
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }

            .search-button i {
                font-family: FontAwesome;
                content: "\f002"; /* FontAwesome search icon */
            }

        /* Table styling */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

            .data-table th,
            .data-table td {
                border: 1px solid #ddd;
                text-align: left;
                padding: 10px;
            }

            .data-table th {
                background-color: #f5f5f5;
                font-weight: bold;
            }

            .data-table tbody tr:hover {
                background-color: #f1f1f1;
            }


            
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
            padding: 20px;
            z-index: 1000;
            width: 90%;
            max-width: 400px;
        }

            .modal.active {
                display: block;
            }

        .modal-content h2 {
            margin: 0 0 10px;
            font-size: 18px;
            color: #333;
        }

        .modal-content p {
            margin: 0 0 20px;
            color: #666;
            font-size: 14px;
        }

        .modal-content .action-link {
            display: inline-block;
            background-color: #377dff;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s;
        }

            .modal-content .action-link:hover {
                background-color: #275dbe;
            }

        /* Overlay */
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

            .overlay.active {
                display: block;
            }


        /* POP OUT */

        .blur-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
            z-index: 999;
        }

        .popup-message {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            z-index: 1000;
        }

        .popup-content {
            text-align: center;
            width: 400px;
        }

            .popup-content p {
                margin-top: 20px;
                color: black;
            }

            .popup-content h2 {
                margin-top: 20px;
                padding: 20px;
                color: black;
            }

        .btn_verification {
            background-color: #377dff;
            color: white;
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            text-align: center;
            transition: background-color 0.3s;
        }

            .btn_verification:hover {
                background-color: #5630ff;
                color: white;
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 5px;
                font-size: 14px;
                font-weight: bold;
                text-align: center;
                transition: background-color 0.3s;
                cursor: pointer;
            }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="container">
            <div class="sidebar">
                <div class="menu-item selected" id="menuFlight" onclick="showContent('flightContent')">
                    Flight
                </div>
                <div class="menu-item" id="menuTrain" onclick="showContent('trainContent')">
                    Train
                </div>
            </div>

            <div class="content">
                <div id="flightContent" class="tab-content active">
                    <h1>Flight Booking</h1>
                    <p>Your upcoming Flight reservations.</p>
                    <asp:Repeater ID="repeaterBooking" runat="server">
                        <HeaderTemplate>
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>BookingID</th>
                                        <th>Date</th>
                                        <th>Depart</th>
                                        <th>Origin</th>
                                        <th>Arrive</th>
                                        <th>Destination</th>
                                        <th>Print Ticket</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("BookingID") %></td>
                                <td><%# Eval("BookingDate") %></td>
                                <td><%# Eval("DepartDateTime") %></td>
                                <td><%# Eval("DepartCity") %></td>
                                <td><%# Eval("ArriveDateTime") %></td>
                                <td><%# Eval("ArriveCity") %></td>
                                <td>
                                    <asp:HyperLink ID="hlPrintTicket" runat="server"
                                        NavigateUrl='<%# "~/WebPage/FlightTicketDisplayPage/FlightTicketDisplay.aspx?bookingID=" + Eval("BookingID") %>'>
                               Print
                                    </asp:HyperLink>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
        </table>
                        </FooterTemplate>
                    </asp:Repeater>

                </div>

                <div id="trainContent" class="tab-content">
                    <h1>Train Booking</h1>
                    <p>Your upcoming Train reservations.</p>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Depart</th>
                                <th>Origin</th>
                                <th>Arrive</th>
                                <th>Destination</th>
                                <th>Booking Number</th>
                                <th>Status</th>
                                <th>Print Ticket</th>
                            </tr>

                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

         <div id="overlay" class="overlay"></div>

        <div id="loginPromptModal" class="modal">
            <div class="modal-content">
                <h2>Please log in</h2>
                <p>You must log in to access your booking page.</p>
                <asp:Button ID="btnNavigateToLogin" runat="server" CssClass="action-link" Text="Log in" OnClick="btnNavigateToLogin_Click" />
            </div>

        </div>

        <script>
            function showContent(contentId) {

                document.querySelectorAll('.tab-content').forEach(function (content) {
                    content.style.display = 'none';
                });

                document.querySelectorAll('.menu-item').forEach(function (menuItem) {
                    menuItem.classList.remove('selected');
                });

                document.getElementById(contentId).style.display = 'block';

                event.currentTarget.classList.add('selected');
            }

            document.getElementById('flightContent').style.display = 'block';
        </script>

    </form>
</asp:Content>
