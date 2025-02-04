<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FlightTicketDisplay.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.FlightTicketDisplay" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        @import url("https://fonts.googleapis.com/css?family=Libre+Barcode+39");
        @import url("https://fonts.googleapis.com/css?family=Open+Sans");
        @import url("https://fonts.googleapis.com/css?family=Merienda");

        body,
        html {
            background: #bbbbbb;
            display: grid;
        }

        .ticket {
            margin-top: 50px !important;
            height: 20vw;
            width: 60vw;
            margin: auto;
            border-radius: 2vw;
            position: relative;
            background: white;
        }

        #banner {
            height: 20vw;
            border-radius: 2vw;
            border-top: 4vw solid #ff0000;
            font-family: "Merienda";
            color: white;
        }

        #mainbanner {
            position: absolute;
            top: -0.4vw;
            left: 4.5vw;
            font-size: 3vw;
        }

            #mainbanner img {
                vertical-align: middle;
                height: 4vw;
                width: 4vw;
            }

        #tearoffbanner {
            position: absolute;
            top: 1vw;
            left: 46.7vw;
            font-size: 1.2vw;
        }

            #tearoffbanner img {
                vertical-align: middle;
                height: 2vw;
                width: 2vw;
            }

        #barcode {
            overflow: hidden;
            height: 3vw;
            width: 13vw;
            position: absolute;
            top: 10vw;
            left: -2vw;
            font-size: 4em;
            font-family: "Libre Barcode 39";
            transform: rotate(-90deg) scale(1, 2.5);
        }

        #holes {
            height: 100%;
            position: absolute;
            top: -1.8vw;
            left: 44vw;
        }

            #holes div {
                width: 1.8vw;
                height: 1.8vw;
                border-radius: 100%;
                background: #bbbbbb;
                margin-top: 0.5vw;
            }

        #data {
            text-transform: uppercase;
            font-size: 0.8vw;
            font-family: "Open Sans";
        }

        #maindata {
            margin: 0.5vw;
            position: absolute;
            width: 35vw;
            height: 16vw;
            top: 4vw;
            left: 9vw;
        }

        #data .box {
            width: 17vw;
            display: inline-block;
        }

            #data .box .header {
                display: block;
            }

            #data .box .body {
                font-size: 1.7vw;
            }

            #data .box.boarding {
                width: 17vw;
                bottom: 3vw;
                left: 9.3vw;
                position: absolute;
                text-align: center;
                border: 2px solid black;
                margin-top: 0.3vw;
                margin-left: 6vw;
            }

                #data .box.boarding .header {
                    font-size: 1.8vw;
                }

                #data .box.boarding .body {
                    font-size: 1.5vw;
                }

        #tearoffdata {
            position: absolute;
            width: 13vw;
            height: 16vw;
            top: 0vw;
            left: 37vw;
            font-size: 0.8vw;
        }

            #tearoffdata .box {
                width: 13vw;
                display: block;
            }

                #tearoffdata .box .header {
                    text-decoration: none;
                }

                #tearoffdata .box .body {
                    margin-left: 1vw;
                    font-size: 1.2vw;
                }

                #tearoffdata .box.seat {
                    margin-top: 0vw;
                }

                    #tearoffdata .box.seat .body {
                        font-size: 2vw;
                    }

        .btnPrint {
            background: white;
            color: #001f3f;
            border: 1px solid #001f3f;
            border-radius: 20px;
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            align-items: center;
            text-align: center;
            margin-top: 50px;
            margin-left: 45%;
        }

        .btnBack {
            background: white;
            color: #001f3f;
            border: 1px solid #001f3f;
            border-radius: 20px;
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            align-items: center;
            text-align: center;
            margin-top: 50px;
            margin-bottom: 100px;
        }

            .btnBack:hover, .btnPrint:hover {
                background: #001f3f;
                color: white;
            }

        .body-to {
            font-size: 15px !important;
            margin-top: -50px !important;
            padding-top: -50px !important;
        }
    </style>
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div>
            <div class="ticket">
                <div id="banner">
                    <div id="topbanner"></div>
                    <span id="mainbanner">
                        <asp:Image ID="ImageLogo" runat="server" CssClass="logo" />
                        <asp:Label ID="lblAirlineName" runat="server" CssClass="body" />
                    </span>
                    <span id="tearoffbanner">
                        <asp:Image ID="ImageLogoTearoff" runat="server" ImageUrl="~/Images/Airasia_Logo.png" />
                        <asp:Label ID="lblAirlineNameTearoff" runat="server" CssClass="body" />
                    </span>
                </div>
                <div id="barcode">
                    LAUHNG
                </div>
                <div id="data">
                    <div id="maindata">
                        <div class="box">
                            <span class="header">Passenger Name</span>
                            <asp:Label ID="lblPassengerName" runat="server" CssClass="body" />
                        </div>
                        <div class="box">
                            <span class="header">Flight Number</span>
                            <asp:Label ID="lblFlightNumber" runat="server" CssClass="body" />
                        </div>
                        <div class="box">
                            <span class="header">From</span>
                            <asp:Label ID="lblFrom" runat="server" CssClass="body" />
                            <span class="header">To</span>
                            <asp:Label ID="lblTo" runat="server" CssClass="body-to" />
                        </div>


                        <div class="box boarding">
                            <span class="header">Boarding Time</span>
                            <asp:Label ID="lblBoardingTime" runat="server" CssClass="body" />
                        </div>

                        <div id="tearoffdata">
                            <div class="box">
                                <span class="header">Passenger Name</span>
                                <asp:Label ID="lblTearoffPassengerName" runat="server" CssClass="body" />
                            </div>
                            <div class="box">
                                <span class="header">Flight Number</span>
                                <asp:Label ID="lblTearoffFlightNumber" runat="server" CssClass="body" />
                            </div>
                            <div class="box">
                                <span class="header">Date</span>
                                <asp:Label ID="lblTearoffDate" runat="server" CssClass="body" />
                            </div>
                        </div>
                    </div>

                    <div id="holes">
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                    </div>
                </div>
            </div>
        </div>

        <asp:Button ID="btnPrint" runat="server" CssClass="btnPrint" Text="Print Ticket" OnClientClick="printTicket(); return false;" />
        <asp:Button ID="btnBack" runat="server" CssClass="btnBack" Text="Back" PostBackUrl="~/WebPage/UserBookingPage/UserBookingPage.aspx" />

        <script>
            function printTicket() {
                window.print();
            }
        </script>
    </form>
</asp:Content>
