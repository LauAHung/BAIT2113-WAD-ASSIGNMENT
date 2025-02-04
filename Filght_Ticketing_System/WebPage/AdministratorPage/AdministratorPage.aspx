<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdministratorPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.AdministratorPage" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        /* Container for the flight management page */
        .flight-management-wrapper {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        /* Header section */
        .flight-management-header {
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        /* Flight form section */
        .flight-management-form-section {
            margin-bottom: 30px;
        }

            .flight-management-form-section h2 {
                font-size: 20px;
                margin-bottom: 10px;
            }

            .flight-management-form-section input,
            .flight-management-form-section select {
                display: block;
                width: 100%;
                padding: 8px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

        /* Add/update button styling */
        .flight-management-action-button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

            .flight-management-action-button:hover {
                background-color: #45a049;
            }

        /* Table styling */
        .flight-management-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

            .flight-management-table th,
            .flight-management-table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }

            .flight-management-table th {
                background-color: #f2f2f2;
            }

            .flight-management-table tr:hover {
                background-color: #f1f1f1;
            }

        /* Container for train management page */
        .train-management-wrapper {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        /* Header section */
        .train-management-header {
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        /* Form sections */
        .train-management-form-section {
            margin-bottom: 30px;
        }

            .train-management-form-section h2 {
                font-size: 20px;
                margin-bottom: 10px;
            }

            .train-management-form-section input,
            .train-management-form-section select {
                display: block;
                width: 100%;
                padding: 8px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

        /* Action buttons */
        .train-management-action-button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

            .train-management-action-button:hover {
                background-color: #45a049;
            }

        /* Table styling */
        .train-management-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

            .train-management-table th,
            .train-management-table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }

            .train-management-table th {
                background-color: #f2f2f2;
            }

            .train-management-table tr:hover {
                background-color: #f1f1f1;
            }

        /* Container for user management */
        .user-management-wrapper {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        /* Header section */
        .user-management-header {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        /* Form sections */
        .user-management-form-section {
            margin-bottom: 30px;
        }

            .user-management-form-section h2 {
                font-size: 20px;
                margin-bottom: 10px;
            }

            .user-management-form-section input,
            .user-management-form-section select {
                display: block;
                width: 100%;
                padding: 8px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

        /* Action buttons */
        .user-management-action-button {
            padding: 10px 15px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

            .user-management-action-button:hover {
                background-color: #0056b3;
            }

        /* Table styling */
        .user-management-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

            .user-management-table th,
            .user-management-table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }

            .user-management-table th {
                background-color: #f2f2f2;
            }

            .user-management-table tr:hover {
                background-color: #f1f1f1;
            }

        .input-box {
            position: relative;
            margin: 10px 0;
        }

            .input-box .input-label {
                position: absolute;
                color: #80868b;
                font-size: 16px;
                font-weight: 400;
                left: 8px;
                top: 13px;
                padding: 0 8px;
                transition: 250ms;
                user-select: none;
                pointer-events: none;
            }

            .input-box .input-1 {
                box-sizing: border-box;
                height: 50px;
                width: 100%;
                border-radius: 4px;
                color: #202124;
                border: 1px solid #dadce0;
                padding: 13px 15px;
                transition: 250ms;
            }

                .input-box .input-1:focus {
                    outline: none;
                    border: 2px solid #1a73e8;
                    transition: 250ms;
                }

            .input-box.focus .input-label {
                color: #1a73e8;
                top: -8px;
                background: #fff;
                font-size: 11px;
            }

        .dashboard {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .card {
            width: 200px;
            padding: 20px;
            border-radius: 8px;
            color: white;
            text-align: center;
            font-family: Arial, sans-serif;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

            .card.blue {
                background-color: #007BFF;
            }

            .card.green {
                background-color: #28A745;
            }

            .card.orange {
                background-color: #FFC107;
            }

            .card.red {
                background-color: #DC3545;
            }

        .count {
            font-size: 2em;
            margin-bottom: 10px;
        }

        .more-info {
            color: white;
            text-decoration: underline;
            font-size: 0.9em;
        }

        .chart-container {
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            align-items: flex-start;
            gap: 20px;
        }


            .chart-container > div {
                flex: 1;
                text-align: center;
            }

        canvas {
            max-width: 100%;
            height: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 16px;
            text-align: left;
            background-color: #ffffff;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

            .table th {
                background-color: #007BFF;
                color: white;
                font-weight: bold;
                padding: 12px;
                text-align: center;
            }

            .table td {
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }

            .table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .table tr:hover {
                background-color: #f1f1f1;
                cursor: pointer;
            }

            .table button {
                background-color: #007BFF;
                color: white;
                border: none;
                padding: 5px 10px;
                font-size: 14px;
                border-radius: 3px;
                cursor: pointer;
            }

                .table button:hover {
                    background-color: #0056b3;
                }

            .table select {
                padding: 5px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 3px;
            }

            .table .edited-row {
                background-color: #ffffcc;
            }

            .table tfoot {
                background-color: #f1f1f1;
                font-weight: bold;
            }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="container">
            <div class="sidebar">

                <div class="menu-item selected" id="menuDashBoard" onclick="showContent('DashBoardContent')">
                    DashBoard
                </div>

                <div class="menu-item" id="menuFlight" onclick="showContent('flightContent')">
                    Flight
                </div>

                <div class="menu-item" id="menuTrain" onclick="showContent('trainContent')">
                    Train
                </div>

                <div class="menu-item" id="userManagement" onclick="showContent('UsersContent')">
                    Users Management
                </div>

            </div>



            <div class="content">
                <div id="DashBoardContent" class="tab-content active">
                    <h1>Data DashBoard</h1>
                    <div class="dashboard">
                        <div class="card blue">
                            <div class="count" id="totalUsers">0</div>
                            Total Users Registered
                           
                            <br />

                        </div>
                        <div class="card green">
                            <div class="count" id="totalAdmins">0</div>
                            Total Admins
                           
                            <br />

                        </div>
                        <div class="card orange">
                            <div class="count" id="totalFlights">0</div>
                            Total Flights
                           
                            <br />

                        </div>
                        <div class="card red">
                            <div class="count" id="totalTrains">0</div>
                            Total Booking Made
                           
                            <br />

                        </div>


                    </div>
                    <br />
                    <br />
                    <br />
                    <div class="chart-container">
                        <div>
                            <h2>Gender</h2>
                            <canvas id="genderChart"></canvas>
                        </div>

                        <div>
                            <h2>Age</h2>
                            <canvas id="ageChart"></canvas>
                        </div>

                        <div>
                            <h2>Monthly Sales</h2>
                            <canvas id="monthlySalesChart"></canvas>
                        </div>

                    </div>
                </div>


                <div class="content">

                    <div id="UsersContent" class="tab-content active">
                        <h1>User Management</h1>
                        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
                            CssClass="table"
                            DataKeyNames="userID"
                            OnRowEditing="gvUsers_RowEditing"
                            OnRowUpdating="gvUsers_RowUpdating"
                            OnRowCancelingEdit="gvUsers_RowCancelingEdit">
                            <Columns>

                                <asp:BoundField DataField="userID" HeaderText="User ID" ReadOnly="True" />
                                <asp:BoundField DataField="userName" HeaderText="Username" ReadOnly="True" />
                                <asp:BoundField DataField="userEmail" HeaderText="Email" ReadOnly="True" />
                                <asp:BoundField DataField="userStatus" HeaderText="Status" />


                                <asp:TemplateField HeaderText="Edit Status">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlStatus" runat="server">
                                            <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                            <asp:ListItem Text="Lock" Value="Lock"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("userStatus") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Edit Type">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlType" runat="server">
                                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                                            <asp:ListItem Text="User" Value="User"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblType" runat="server" Text='<%# Bind("userType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:CommandField ShowEditButton="True" ButtonType="Button" />
                            </Columns>
                        </asp:GridView>
                    </div>
                    <asp:Label ID="lblError" runat="server"></asp:Label>

                </div>




                <div id="flightContent" class="tab-content active">
                    <h1>Flight Management</h1>
                    <div class="flight-management-wrapper">
                        <div class="flight-management-header">Manage Flights</div>

                        <div class="flight-management-form-section">
                            <h2>Flight Information</h2>
                            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
                            <div class="input-box">
                                <label class="input-label" for="txtFlightID">Flight ID</label>
                                <asp:TextBox ID="txtFlightID" runat="server" CssClass="input-1" />
                            </div>

                            <div class="input-box">
                                <label class="input-label" for="txtDepartDateTime">Departure Date & Time</label>
                                <asp:TextBox ID="txtDepartDateTime" runat="server" CssClass="input-1" TextMode="DateTime" />
                            </div>

                            <div class="input-box">
                                <label class="input-label" for="txtArriveDateTime">Arrival Date & Time</label>
                                <asp:TextBox ID="txtArriveDateTime" runat="server" CssClass="input-1" TextMode="DateTime" />
                            </div>

                            <div class="input-box">
                                <label class="input-label" for="txtDepartCity">Departure City</label>
                                <asp:TextBox ID="txtDepartCity" runat="server" CssClass="input-1" />
                            </div>

                            <div class="input-box">
                                <label class="input-label" for="txtArriveCity">Arrival City</label>
                                <asp:TextBox ID="txtArriveCity" runat="server" CssClass="input-1" />
                            </div>

                            <asp:DropDownList ID="ddlFlightStatus" runat="server">
                                <asp:ListItem Text="Scheduled" Value="Scheduled"></asp:ListItem>
                                <asp:ListItem Text="Delayed" Value="Delayed"></asp:ListItem>
                                <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                            </asp:DropDownList>
                            <div class="input-box">
                                <label class="input-label" for="txtAirplaneID">Airplane ID</label>
                                <asp:TextBox ID="txtAirplaneID" runat="server" CssClass="input-1" />
                            </div>
                            <asp:Button ID="btnAddFlight" runat="server" Text="Add/Update Flight" CssClass="flight-management-action-button" OnClick="btnAddFlight_Click" />
                        </div>

                        <!-- Flight Data Grid -->
                        <div>
                            <h2>Flight List</h2>
                            <asp:GridView ID="gvFlights" runat="server" AutoGenerateColumns="False" CssClass="flight-management-table" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource2" DataKeyNames="flightID">
                                <Columns>
                                    <asp:BoundField DataField="flightID" HeaderText="flightID" ReadOnly="True" SortExpression="flightID" />
                                    <asp:BoundField DataField="departDateTime" HeaderText="departDateTime" SortExpression="departDateTime" />
                                    <asp:BoundField DataField="arriveDateTime" HeaderText="arriveDateTime" SortExpression="arriveDateTime" />
                                    <asp:BoundField DataField="departCity" HeaderText="departCity" SortExpression="departCity" />
                                    <asp:BoundField DataField="arriveCity" HeaderText="arriveCity" SortExpression="arriveCity" />
                                    <asp:BoundField DataField="flightStatus" HeaderText="flightStatus" SortExpression="flightStatus" />
                                    <asp:BoundField DataField="airplaneID" HeaderText="airplaneID" SortExpression="airplaneID" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                                ConnectionString="<%$ ConnectionStrings:FlightSystemDatabase %>"
                                SelectCommand="SELECT * FROM [Flight]"></asp:SqlDataSource>
                        </div>

                        <!-- Add/Edit Airport Form -->
                        <div class="flight-management-form-section">
                            <h2>Airport Information</h2>
                            <asp:Label ID="lblAirportMessage" runat="server"></asp:Label>

                            <div class="input-box">
                                <label class="input-label" for="txtAirportID">Airport ID</label>
                                <asp:TextBox ID="txtAirportID" runat="server" CssClass="input-1" />
                            </div>

                            <div class="input-box">
                                <label class="input-label" for="txtAirportName">Airport Name</label>
                                <asp:TextBox ID="txtAirportName" runat="server" CssClass="input-1" />
                            </div>

                            <div class="input-box">
                                <label class="input-label" for="txtCity">Airport City</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="input-1" />
                            </div>

                            <div class="input-box">
                                <label class="input-label" for="txtIATACode">IATA Code</label>
                                <asp:TextBox ID="txtIATACode" runat="server" CssClass="input-1" />
                            </div>

                            <asp:Button ID="btnAddAirport" runat="server" Text="Add/Update Airport" CssClass="flight-management-action-button" OnClick="btnAddAirport_Click" />
                        </div>

                        <!-- Airport Data Grid -->
                        <div>
                            <h2>Airport List</h2>

                            <asp:GridView ID="gvAirport" runat="server" DataSourceID="SqlDataSource3" CssClass="flight-management-table" AutoGenerateColumns="False" DataKeyNames="airportID">
                                <Columns>
                                    <asp:BoundField DataField="airportID" HeaderText="airportID" ReadOnly="True" SortExpression="airportID" />
                                    <asp:BoundField DataField="airportName" HeaderText="airportName" SortExpression="airportName" />
                                    <asp:BoundField DataField="city" HeaderText="city" SortExpression="city" />
                                    <asp:BoundField DataField="IATA_Code" HeaderText="IATA_Code" SortExpression="IATA_Code" />
                                </Columns>
                            </asp:GridView>

                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:FlightSystemDatabase %>" SelectCommand="SELECT * FROM [Airport]"></asp:SqlDataSource>


                            <div class="flight-management-form-section">
                                <h2>Airplane Information</h2>
                                <asp:Label ID="lblAirplaneMessage" runat="server"></asp:Label>

                                <div class="input-box">
                                    <label class="input-label" for="txtAirplaneID1">Airplane ID</label>
                                    <asp:TextBox ID="txtAirplaneID1" runat="server" CssClass="input-1" />
                                </div>

                                <div class="input-box">
                                    <label class="input-label" for="txtAirplaneName">Airplane Name</label>
                                    <asp:TextBox ID="txtAirplaneName" runat="server" CssClass="input-1" />
                                </div>

                                <div class="input-box">
                                    <label class="input-label" for="txtAirplaneStatus">Airplane Status</label>
                                    <asp:TextBox ID="txtAirplaneStatus" runat="server" CssClass="input-1" />
                                </div>

                                <div class="input-box">
                                    <label class="input-label" for="txtCapacity1">Airplane Capacity</label>
                                    <asp:TextBox ID="txtCapacity1" runat="server" CssClass="input-1" />
                                </div>

                                <asp:FileUpload ID="fileUpload" runat="server" />
                                <asp:Button ID="btnUpload" runat="server" Text="Upload Image" OnClick="UploadImage" CssClass="flight-management-action-button" />
                                <asp:Label ID="lblUploadMessage" runat="server" CssClass="upload-message-label"></asp:Label>



                                <div class="input-box">
                                    <label class="input-label" for="txtAirportID1">Airport ID</label>
                                    <asp:TextBox ID="txtAirportID1" runat="server" CssClass="input-1" />
                                </div>

                                <asp:Button ID="Button1" runat="server" Text="Add/Update Airport" CssClass="flight-management-action-button" OnClick="btnAddAirplane_Click" />
                            </div>

                            <asp:GridView ID="gvAirplane" runat="server" AutoGenerateColumns="False" CssClass="flight-management-table" DataSourceID="SqlDataSource1" DataKeyNames="airplaneID">
                                <Columns>
                                    <asp:BoundField DataField="airplaneID" HeaderText="Airplane ID" ReadOnly="True" SortExpression="airplaneID" />
                                    <asp:BoundField DataField="airplaneName" HeaderText="Airplane Name" SortExpression="airplaneName" />
                                    <asp:BoundField DataField="airplaneStatus" HeaderText="Airplane Status" SortExpression="airplaneStatus" />
                                    <asp:BoundField DataField="capacity" HeaderText="Capacity" SortExpression="capacity" />
                                    <asp:BoundField DataField="airportID" HeaderText="Airport ID" SortExpression="airportID" />

                                    <asp:TemplateField HeaderText="Image">
                                        <ItemTemplate>
                                            <asp:Image ID="imgAirplane" runat="server" Height="100px" Width="100px"
                                                ImageUrl='<%# "~/ImageHandler.ashx?airplaneID=" + Eval("airplaneID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FlightSystemDatabase %>" SelectCommand="SELECT * FROM [Airplane]"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>

                <div id="trainContent" class="tab-content">
                    <div class="train-management-wrapper">
                        <div class="train-management-header">Manage Trains</div>

                        <!-- Train Information Form -->
                        <div class="train-management-form-section">
                            <h2>Train Information</h2>
                            <asp:TextBox ID="txtTrainID" runat="server" Placeholder="Train ID"></asp:TextBox>
                            <asp:TextBox ID="txtTrainName" runat="server" Placeholder="Train Name"></asp:TextBox>
                            <asp:DropDownList ID="ddlTrainStatus" runat="server">
                                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtCapacity" runat="server" Placeholder="Capacity"></asp:TextBox>
                            <asp:TextBox ID="txtTrainDepotID" runat="server" Placeholder="Train Depot ID"></asp:TextBox>
                            <asp:Button ID="btnAddTrain" runat="server" Text="Add/Update Train" CssClass="train-management-action-button" />
                        </div>

                        <!-- Train List -->
                        <div>
                            <h2>Train List</h2>
                            <asp:GridView ID="gvTrains" runat="server" AutoGenerateColumns="False" CssClass="train-management-table">
                                <Columns>
                                    <asp:BoundField DataField="TrainID" HeaderText="Train ID" />
                                    <asp:BoundField DataField="TrainName" HeaderText="Train Name" />
                                    <asp:BoundField DataField="TrainStatus" HeaderText="Status" />
                                    <asp:BoundField DataField="Capacity" HeaderText="Capacity" />
                                    <asp:BoundField DataField="TrainDepotID" HeaderText="Depot ID" />
                                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                                </Columns>
                            </asp:GridView>
                        </div>

                        <!-- Train Number Information Form -->
                        <div class="train-management-form-section">
                            <h2>Train Number Information</h2>
                            <asp:TextBox ID="txtTrainNoID" runat="server" Placeholder="Train Number ID"></asp:TextBox>
                            <asp:TextBox ID="txtTrainNo" runat="server" Placeholder="Train Number"></asp:TextBox>
                            <asp:TextBox ID="txtTrainDepartDateTime" runat="server" TextMode="DateTime" Placeholder="Departure Date & Time"></asp:TextBox>
                            <asp:TextBox ID="txtTrainArriveDateTime" runat="server" TextMode="DateTime" Placeholder="Arrival Date & Time"></asp:TextBox>
                            <asp:TextBox ID="txtTrainDepartCity" runat="server" Placeholder="Departure City"></asp:TextBox>
                            <asp:TextBox ID="txtTrainArriveCity" runat="server" Placeholder="Arrival City"></asp:TextBox>
                            <asp:TextBox ID="txtLinkedTrainID" runat="server" Placeholder="Linked Train ID"></asp:TextBox>
                            <asp:Button ID="btnAddTrainNo" runat="server" Text="Add/Update Train Number" CssClass="train-management-action-button" />
                        </div>

                        <!-- Train Number List -->
                        <div>
                            <h2>Train Number List</h2>
                            <asp:GridView ID="gvTrainNumbers" runat="server" AutoGenerateColumns="False" CssClass="train-management-table">
                                <Columns>
                                    <asp:BoundField DataField="TrainNoID" HeaderText="Train Number ID" />
                                    <asp:BoundField DataField="TrainNo" HeaderText="Train Number" />
                                    <asp:BoundField DataField="DepartDateTime" HeaderText="Departure Date & Time" />
                                    <asp:BoundField DataField="ArriveDateTime" HeaderText="Arrival Date & Time" />
                                    <asp:BoundField DataField="DepartCity" HeaderText="Departure City" />
                                    <asp:BoundField DataField="ArriveCity" HeaderText="Arrival City" />
                                    <asp:BoundField DataField="TrainID" HeaderText="Train ID" />
                                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                                </Columns>
                            </asp:GridView>
                        </div>


                        <!-- Train Ticket List -->
                        <div>
                            <h2>Train Ticket List</h2>
                            <asp:GridView ID="gvTrainTickets" runat="server" AutoGenerateColumns="False" CssClass="train-management-table">
                                <Columns>
                                    <asp:BoundField DataField="TrainTicketID" HeaderText="Ticket ID" />
                                    <asp:BoundField DataField="SeatNo" HeaderText="Seat No" />
                                    <asp:BoundField DataField="Price" HeaderText="Price" />
                                    <asp:BoundField DataField="TicketType" HeaderText="Type" />
                                    <asp:BoundField DataField="PassengerName" HeaderText="Passenger Name" />
                                    <asp:BoundField DataField="PassengerAge" HeaderText="Age" />
                                    <asp:BoundField DataField="PassengerGender" HeaderText="Gender" />
                                    <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
                                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>

                <div id="UserContent" class="tab-content">
                    <div class="user-management-wrapper">
                        <div class="user-management-header">Manage Users</div>

                        <!-- User Information Form -->
                        <div class="user-management-form-section">
                            <h2>User Information</h2>
                            <asp:TextBox ID="txtUserID" runat="server" Placeholder="User ID"></asp:TextBox>
                            <asp:TextBox ID="txtUserFirstName" runat="server" Placeholder="First Name"></asp:TextBox>
                            <asp:TextBox ID="txtUserLastName" runat="server" Placeholder="Last Name"></asp:TextBox>
                            <asp:TextBox ID="txtUserContactNo" runat="server" Placeholder="Contact Number"></asp:TextBox>
                            <asp:TextBox ID="txtUserAddress" runat="server" Placeholder="Address"></asp:TextBox>
                            <asp:TextBox ID="txtUserEmail" runat="server" Placeholder="Email"></asp:TextBox>
                            <asp:TextBox ID="txtUserPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
                            <asp:TextBox ID="txtUserDateOfBirth" runat="server" TextMode="Date" Placeholder="Date of Birth"></asp:TextBox>
                            <asp:DropDownList ID="ddlUserGender" runat="server">
                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlUserType" runat="server">
                                <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                                <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtCreatedDate" runat="server" TextMode="Date" Placeholder="Created Date"></asp:TextBox>
                            <asp:Button ID="btnAddUser" runat="server" Text="Add/Update User" CssClass="user-management-action-button" />
                        </div>

                        <!-- User List -->

                    </div>
                </div>
            </div>
        </div>


        <script>
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "AdministratorPage.aspx/GetMonthlySalesData",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        const data = JSON.parse(response.d);
                        const labels = data.slice(1).map(item => item.Month); // Skip header row
                        const sales = data.slice(1).map(item => item.TotalSales);

                        const ctx = document.getElementById('monthlySalesChart').getContext('2d');
                        new Chart(ctx, {
                            type: 'bar', // or 'line'
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: 'Monthly Sales',
                                    data: sales,
                                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                    borderColor: 'rgba(75, 192, 192, 1)',
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true
                                    }
                                }
                            }
                        });
                    },
                    error: function (error) {
                        console.log("Error loading data:", error);
                    }
                });
            });

            $.ajax({
                type: "POST",
                url: "AdministratorPage.aspx/GetDashboardData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var data = response.d;
                    console.log("Total Users:", data.TotalUsers);
                    console.log("Total Admins:", data.TotalAdmins);
                    console.log("Total Flights:", data.TotalFlights);
                    console.log("Total Trains:", data.TotalTrains);

                    // Update dashboard UI here
                    $("#totalUsers").text(data.TotalUsers);
                    $("#totalAdmins").text(data.TotalAdmins);
                    $("#totalFlights").text(data.TotalFlights);
                    $("#totalTrains").text(data.TotalTrains);
                },
                error: function (error) {
                    console.error("Error fetching dashboard data:", error);
                }
            });

            document.getElementById("totalUsers").innerText = 100; // Replace with total user count
            document.getElementById("totalAdmins").innerText = 10; // Replace with admin count
            document.getElementById("totalFlights").innerText = 200; // Replace with total flights
            document.getElementById("totalTrains").innerText = 50; // Replace with total trains


            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "AdministratorPage.aspx/GetChartData",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        const data = response.d;

                        const genderLabels = data.GenderData.map(item => item.Gender);
                        const genderCounts = data.GenderData.map(item => item.Count);
                        new Chart(document.getElementById('genderChart'), {
                            type: 'pie',
                            data: {
                                labels: genderLabels,
                                datasets: [{
                                    data: genderCounts,
                                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56']
                                }]
                            }
                        });

                        const geographyLabels = data.GeographyData.map(item => item.Address);
                        const geographyCounts = data.GeographyData.map(item => item.Count);
                        new Chart(document.getElementById('geographyChart'), {
                            type: 'bar',
                            data: {
                                labels: geographyLabels,
                                datasets: [{
                                    data: geographyCounts,
                                    backgroundColor: '#36A2EB'
                                }]
                            }
                        });

                        const ageLabels = data.AgeData.map(item => item.AgeGroup);
                        const ageCounts = data.AgeData.map(item => item.Count);
                        new Chart(document.getElementById('ageChart'), {
                            type: 'bar',
                            data: {
                                labels: ageLabels,
                                datasets: [{
                                    data: ageCounts,
                                    backgroundColor: '#FFCE56'
                                }]
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        console.error("Error fetching chart data:", error);
                    }
                });
            });

            function showContent(contentId) {
                // Hide all content sections
                document.querySelectorAll('.tab-content').forEach(function (content) {
                    content.style.display = 'none';
                });

                // Remove "selected" class from all menu items
                document.querySelectorAll('.menu-item').forEach(function (menuItem) {
                    menuItem.classList.remove('selected');
                });

                // Show the selected content
                document.getElementById(contentId).style.display = 'block';

                // Highlight the selected menu item
                event.currentTarget.classList.add('selected');
            }

            // Initialize by showing the flight content
            document.getElementById('flightContent').style.display = 'block';

            function setFocus(on) {
                const element = document.activeElement;
                if (on) {
                    setTimeout(() => {
                        element.parentNode.classList.add("focus");
                    }, 0);
                } else {
                    document.querySelectorAll(".input-1").forEach((input) => {
                        const parent = input.parentNode;
                        if (input.value.trim()) {
                            parent.classList.add("focus");
                        } else {
                            parent.classList.remove("focus");
                        }
                    });
                }
            }

            document.querySelectorAll(".input-1").forEach((input) => {
                input.addEventListener("focus", () => setFocus(true));
                input.addEventListener("blur", () => setFocus(false));
            });

            window.addEventListener("DOMContentLoaded", () => {
                document.querySelectorAll(".input-1").forEach((input) => {
                    if (input.value.trim()) {
                        input.parentNode.classList.add("focus");
                    }
                });
            });



        </script>

    </form>
</asp:Content>
