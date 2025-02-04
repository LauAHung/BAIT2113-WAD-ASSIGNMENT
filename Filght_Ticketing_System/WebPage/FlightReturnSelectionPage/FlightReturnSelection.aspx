<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FlightReturnSelection.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.FlightReturnSelection" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="FlightReturnSelectionPage.css">
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">
        <div class="curved-header">
        </div>

        <div class="search-bar">
            <div class="input-row">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
                <div class="input-group">
                    <label for="txtFrom">Depart Location</label>
                    <asp:TextBox ID="txtFrom" runat="server" CssClass="input" Placeholder="Where from?"  ReadOnly="true"/>
                    <div id="suggestionsFrom" class="suggestions"></div>
                </div>
                <span class="exchange-icon" onclick="swapLocations()">&#8646;</span>

                <div class="input-group">
                    <label for="txtTo">To Location</label>
                    <asp:TextBox ID="txtTo" runat="server" CssClass="input" Placeholder="Where to?" onkeyup="fetchAirportsTo(this.value)" />
                    <div id="suggestionsTo" class="suggestions"></div>
                </div>

                <div class="input-group" id="return-dates">
                    <label for="txtDepartureDate">Departure Date</label>
                    <asp:TextBox ID="txtDepartureDate" runat="server" CssClass="input" TextMode="Date" ReadOnly="true"/>
                </div>

                <div class="input-group hidden" id="one-way-date">
                    <label for="txtOneWayDate">Return Date</label>
                    <asp:TextBox ID="txtOneWayDate" runat="server" CssClass="input" TextMode="Date" />
                </div>

                <div class="passenger-class-group">
                    <asp:Label runat="server" Text="Passengers"></asp:Label>
                    <div class="passenger-dropdown">
                        <asp:Button ID="dropdownButton" CssClass="passenger-dropdown-button" runat="server" Text="1 Passenger" OnClick="UpdateDropdownText" Enabled="false" />
                        <div class="passenger-dropdown-content">
                            <div class="passenger-dropdown-item">
                                <asp:Label runat="server" Text="Adults (12+)"></asp:Label>
                                <div class="passenger-counter">
                                    <asp:Button ID="adultDecrement" CssClass="passenger-counter-btn" runat="server" Text="-" OnClick="DecrementAdult" />
                                    <asp:Label ID="adultCounter" CssClass="passenger-counter-value" runat="server" Text="1"></asp:Label>
                                    <asp:Button ID="adultIncrement" CssClass="passenger-counter-btn" runat="server" Text="+" OnClick="IncrementAdult" />
                                </div>
                            </div>
                            <div class="passenger-dropdown-item">
                                <asp:Label runat="server" Text="Children (2-11)"></asp:Label>
                                <div class="passenger-counter">
                                    <asp:Button ID="childDecrement" CssClass="passenger-counter-btn" runat="server" Text="-" OnClick="DecrementChild" />
                                    <asp:Label ID="childCounter" CssClass="passenger-counter-value" runat="server" Text="0"></asp:Label>
                                    <asp:Button ID="childIncrement" CssClass="passenger-counter-btn" runat="server" Text="+" OnClick="IncrementChild" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
        </div>



        <div class="main">


            <div class="container">
                <div class="filter-container">
                    <h2>Filters</h2>
                    <br />

                    <!-- Number of layovers -->
                    <div class="filter-section">
                        <h4>Number of Layovers</h4>
                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="direct" runat="server" Text=" Direct" />
                        </div>

                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="oneStop" runat="server" Text=" 1 Stop" />
                        </div>

                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="twoStops" runat="server" Text=" 2 Stops" />
                        </div>
                    </div>


                    <!-- Cabin class -->
                    <div class="filter-section">
                        <h4>Cabin Class</h4>

                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="economy" runat="server" Text=" Economy" />
                        </div>

                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="business" runat="server" Text=" Business" />
                        </div>

                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="firstClass" runat="server" Text=" First Class" />
                        </div>
                    </div>

                    <!-- Departure Time -->
                    <div class="filter-section">
                        <h4>Departure Time</h4>

                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="EarlyFlight" runat="server" Text=" Early Flight (00:00 - 06:00)" />
                        </div>

                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="MorningFlight" runat="server" Text=" Morning Flight (06:00 - 12:00)" />
                        </div>

                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="AfternoonFlight" runat="server" Text=" Afternoon Flight (12:00 - 18:00)" />
                        </div>

                        <div class="checkbox-wrapper-47">
                            <asp:CheckBox ID="NightFlight" runat="server" Text=" Night Flight (18:00 - 00:00)" />
                        </div>

                        <asp:Button
                            ID="btnFilterSubmit"
                            runat="server"
                            CssClass="filter-submit-button"
                            Text="Filter Now"
                            OnClick="btnFilterSubmit_Click" />
                    </div>
                </div>
                <div class="right-side">
                    <div class="header_Title">
                        <h2>Returning Flight</h2>
                        <p class="price-alert">*Last updated: <span id="lastUpdatedTime"></span></p>
                    </div>

                    <asp:Label ID="lblNoFlightsFound" runat="server" CssClass="no-flights-alert" Text="No flights found for the selected criteria. Try again for others criteria." Visible="false" />

                    <asp:Repeater ID="rptReturnFlights" runat="server">
                        <ItemTemplate>
                            <div class="flight">
                                <!-- Left Section: Logo and Name -->
                                <div class="flight-left">
                                    <img src='<%# ResolveUrl("~/ImageHandler.ashx?airplaneID=" + Eval("AirplaneID")) %>' alt='<%# Eval("AirlineName") %> Logo' />
                                    <h4><%# Eval("AirlineName") %></h4>
                                </div>

                                <!-- Middle Section: Time Duration -->
                                <div class="flight-middle">
                                    <p>
                                        <%# Eval("FlightTime") %> ------------- <%# Eval("ArrivalTime") %>
                                    </p>
                                    <span>(<%# Eval("Duration") %> hours, Direct)</span>
                                </div>

                                <!-- Right Section: Price and Select Button -->
                                <div class="flight-right">
                                    <span class="flight-price">RM <%# Eval("Price") %></span>
                                    <asp:Button ID="btnSelectFlight" runat="server" Text="Select" CssClass="select-button" CommandArgument='<%# Eval("FlightID") %>' OnCommand="SelectFlight_Command" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>





                </div>
            </div>
        </div>

        <asp:SqlDataSource ID="sqlDataSourceFlights" runat="server"
            ConnectionString="<%$ ConnectionStrings:FlightSystemDatabase %>"></asp:SqlDataSource>

        <script>
            function getCurrentTime() {
                const now = new Date();
                const hours = String(now.getHours()).padStart(2, '0');
                const minutes = String(now.getMinutes()).padStart(2, '0');
                const seconds = String(now.getSeconds()).padStart(2, '0');
                return `${hours}:${minutes}:${seconds}`;
            }

            // Update the time on page load
            document.getElementById('lastUpdatedTime').textContent = getCurrentTime();

            function fetchAirportsFrom(query) {
                if (query.length < 2) {
                    document.getElementById("suggestionsFrom").innerHTML = "";
                    return;
                }

                $.ajax({
                    url: "FlightReturnSelection.aspx/GetAirports",
                    method: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ searchTerm: query }),
                    dataType: "json",
                    success: function (response) {
                        let airports = response.d;
                        let suggestionsHTML = "";

                        airports.forEach(function (airport) {
                            suggestionsHTML += `<div class='suggestion-item' onclick="selectAirportFrom('${airport.AirportName}')">
             ${airport.AirportName} (${airport.IATACode}) - ${airport.City}
         </div>`;
                        });

                        document.getElementById("suggestionsFrom").innerHTML = suggestionsHTML;
                    },
                    error: function (error) {
                        console.error("Error in AJAX request:", error.responseText);
                    }
                });
            }

            function selectAirportFrom(name) {
                var txtFrom = document.getElementById('<%= txtFrom.ClientID %>');
                txtFrom.value = name;
                document.getElementById("suggestionsFrom").innerHTML = "";
            }

            function fetchAirportsTo(query) {
                if (query.length < 2) {
                    document.getElementById("suggestionsTo").innerHTML = "";
                    return;
                }

                $.ajax({
                    url: "FlightReturnSelection.aspx/GetAirports",
                    method: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ searchTerm: query }),
                    dataType: "json",
                    success: function (response) {
                        let airports = response.d;
                        let suggestionsHTML = "";

                        airports.forEach(function (airport) {
                            suggestionsHTML += `<div class='suggestion-item' onclick="selectAirportTo('${airport.AirportName}')">
             ${airport.AirportName} (${airport.IATACode}) - ${airport.City}
         </div>`;
                        });

                        document.getElementById("suggestionsTo").innerHTML = suggestionsHTML;
                    },
                    error: function (error) {
                        console.error("Error in AJAX request:", error.responseText);
                    }
                });
            }


            function selectAirportTo(name) {
                var txtFrom = document.getElementById('<%= txtTo.ClientID %>');
                txtFrom.value = name;
                document.getElementById("suggestionsTo").innerHTML = "";
            }
        </script>
    </form>
</asp:Content>
