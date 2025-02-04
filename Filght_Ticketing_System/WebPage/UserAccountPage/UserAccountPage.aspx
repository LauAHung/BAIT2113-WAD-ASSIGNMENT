<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserAccountPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.UserAccountPage" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');
        /* General Styles */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        html, body {
            display: grid;
            height: 100%;
            width: 100%;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        /* Section Styles */
        .section {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

            .section h2 {
                margin-top: 0;
                font-size: 18px;
                color: #333;
                margin-bottom: 15px;
            }

            .section p {
                margin: 5px 0;
                color: #666;
                font-size: 14px;
            }

        .row {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            flex-wrap: wrap;
        }

        .column {
            flex: 1;
            margin: 5px;
            min-width: 180px;
        }

        .full-width {
            flex: 1 1 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Button Styles */
        a {
            text-decoration: none;
            font-size: 14px;
            color: #fff;
            border-radius: 5px;
            padding: 8px 15px;
            display: inline-block;
            text-align: center;
            cursor: pointer;
        }

        .update-btn {
            background-color: #007bff;
        }

        .link-btn {
            background-color: #007bff;
        }

        .set-btn {
            background-color: #6c63ff;
        }

        .edit-btn {
            background-color: #007bff;
        }

        /* Hover Effects */
        a:hover {
            opacity: 0.9;
        }


        h2 {
            margin: 0 0 20px;
            font-size: 18px;
            color: #333;
        }

        .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .box {
            flex: 1;
            background-color: #f8f9fa;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-right: 10px;
        }

            .box:last-child {
                margin-right: 0;
            }

        .full-width {
            width: 100%;
            margin-right: 0;
        }

        .content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }

        .label {
            display: flex;
            flex-direction: column;
        }

            .label span {
                color: #555;
                font-size: 14px;
            }

        .email {
            color: #000;
            font-weight: bold;
        }


        .update-link,
        .action-link {
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

            .update-link:hover,
            .action-link:hover {
                background-color: #275dbe;
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

        .suggestions {
            border: 1px solid #ccc;
            background: #fff;
            max-height: 150px;
            overflow-y: auto;
            position: absolute;
            width: 100%;
            z-index: 1000;
        }

        .suggestion-item {
            padding: 8px 10px;
            cursor: pointer;
        }

            .suggestion-item:hover {
                background: #f0f0f0;
            }

        .suggestions {
            width: 165px;
            margin-left: 150px;
        }


        #ContentPlaceHolder1_txtPhone, #ContentPlaceHolder1_TextBox2 {
            border-radius: 5px;
            height: 30px;
        }

        #ContentPlaceHolder1_TextBox2 {
            margin-top: 20px;
        }

        /* Modal Styling */
        .custom-modal-content {
            width: 500px;
            margin: auto;
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        /* Form Layout */
        .custom-form-layout {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .custom-form-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }

        .custom-form-label {
            font-weight: bold;
            flex: 1;
            text-align: right;
        }

        .custom-form-input,
        .custom-dropdown,
        .custom-calendar {
            flex: 2;
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }


        /* Button Styling */
        .custom-btn-verification {
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

            .custom-btn-verification:hover {
                background-color: #0056b3;
            }

        /* Background Styling */
        .custom-blur-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        .custom-popup-content {
            position: relative;
            z-index: 2;
        }

        /* Container for Avatar and Upload Section */
        .avatar-container {
            display: flex;
            align-items: center;
            padding-bottom: 20px;
            gap: 20px; /* Space between avatar and upload section */
        }

        /* Avatar Image */
        .user-avatar {
            width: 200px;
            height: 200px;
            object-fit: cover;
            margin-top: 20px;
        }

        /* Upload Section */
        .avatar-upload {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        /* File Upload and Button */
        .avatar-file-upload, .user-account-action-button {
            margin-top: 10px;
            padding: 5px 10px;
        }

        /* Smaller Button */
        .user-account-action-button {
            font-size: 14px;
            padding: 5px 10px;
            width: auto;
        }

        /* Additional styling for label */
        .upload-message-label {
            display: block;
            margin-top: 10px;
            font-size: 14px;
            color: #555;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="container">

            <asp:Image ID="imgAvatar" runat="server" CssClass="user-avatar" />
            <asp:FileUpload ID="fileUploadAvatar" Style="margin-left: 20px; margin-bottom: 10px; font-size: 14px" runat="server" />
            <asp:Button ID="btnUploadAvatar" Style="margin-left: 20px; margin-bottom: 10px; color: white; background-color: blue;" runat="server" Text="Upload Avatar" OnClick="UploadAvatar" CssClass="user-account-action-button" />
            <asp:Label ID="lblAvatarUploadMessage" runat="server" CssClass="upload-message-label"></asp:Label>


            <div class="section">
                <h2>Account Security</h2>
                <div class="row">
                    <div class="box">
                        <div class="content">
                            <div class="label">
                                <span><i class="material-icons">&#xe158;</i> Link Email</span>
                                <span class="email">
                                    <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                </span>
                            </div>
                            <asp:Button ID="btnUpdateEmail" runat="server" CssClass="update-link" Text="Update" OnClick="btnUpdateEmail_Click" />
                        </div>
                    </div>


                    <div class="box">
                        <div class="content">
                            <div class="label">
                                <span><i style="font-size: 24px" class="fa">&#xf095;</i> Add Phone Number</span>
                                <span class="phoneno">
                                    <asp:Label ID="Phone_No" runat="server"></asp:Label>
                                </span>
                            </div>
                            <asp:Button ID="btnUpdatePhone" runat="server" CssClass="update-link" Text="Add" OnClick="btnLinkPhone_Click" />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="box">
                        <div class="content">
                            <div class="label">
                                <span><i class="material-icons">&#xe897;</i> Password</span>
                                <span>Set a password to protect your account</span>
                            </div>
                            <asp:Button ID="btnSetPassword" runat="server" CssClass="action-link" Text="Set" OnClick="btnSetPassword_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Personal Info Section -->
            <div class="section">
                <h2>Personal Info</h2>
                <div class="row">
                    <div class="box">
                        <div class="column">
                            <p><i class="material-icons">&#xe7fb;</i> Gender</p>
                            <asp:Label ID="lblGender" runat="server" Text="-"></asp:Label>
                        </div>
                    </div>

                    <div class="box">
                        <div class="column">
                            <p><i class="material-icons">&#xe916;</i> Date Of Birth</p>
                            <asp:Label ID="lblDisplayDateOfBirth" runat="server" Text="-"></asp:Label>
                        </div>

                    </div>
                </div>
                <div class="row">
                    <div class="box">
                        <div class="column">
                            <p><i class="material-icons">&#xe254;</i> First Name</p>
                            <asp:Label ID="lblDisplayFirstName" runat="server" Text="-"></asp:Label>
                        </div>

                    </div>

                    <div class="box">
                        <div class="column">
                            <p><i class="material-icons">&#xe254;</i> Last Name</p>
                            <asp:Label ID="lblDisplayLastName" runat="server" Text="-"></asp:Label>
                        </div>

                    </div>
                </div>
                <asp:Button ID="btnEditPersonalInfo" runat="server" CssClass="action-link" Text="Edit" OnClick="btnEditPersonalInfo_Click" />
            </div>

            <!-- Overlay -->

            <div id="overlay" class="overlay"></div>


            <asp:HiddenField ID="hfModalState" runat="server" />
            <div id="PersonalInformationModal" class="modal">

                <div class="modal-content">
                    <div class="blur-background" id="blurBackground7"></div>
                    <div class="popup-message" id="popupMessage7">
                        <div class="popup-content">
                            <img src="../../Images/editProfile.gif" width="200px" alt="Alert">
                            <h2>Edit Your Personal Information Now</h2>

                            <!-- Form Layout -->
                            <div class="custom-form-layout">
                                <div class="custom-form-row">
                                    <label for="DropDownList1" class="custom-form-label">Gender:</label>
                                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="custom-dropdown">
                                        <asp:ListItem>Male</asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                        <asp:ListItem>Rather Don't Say</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="custom-form-row">
                                    <label for="Calendar1" class="custom-form-label">Date Of Birth:</label>
                                    <asp:DropDownList ID="ddlDay" runat="server" CssClass="dropdown"></asp:DropDownList>
                                    <asp:DropDownList ID="ddlMonth" runat="server" CssClass="dropdown"></asp:DropDownList>
                                    <asp:DropDownList ID="ddlYear" runat="server" CssClass="dropdown"></asp:DropDownList>

                                </div>

                                <div class="custom-form-row">
                                    <label for="txtFirstName" class="custom-form-label">First Name:</label>
                                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="custom-form-input" placeholder="Enter First Name"></asp:TextBox>
                                </div>

                                <div class="custom-form-row">
                                    <label for="txtLastName" class="custom-form-label">Last Name:</label>
                                    <asp:TextBox ID="txtLastName" runat="server" CssClass="custom-form-input" placeholder="Enter Last Name"></asp:TextBox>
                                </div>
                            </div>

                            <asp:Button ID="btnEditInfo" runat="server" CssClass="custom-btn-verification" Text="Submit" OnClick="btnEditInfo_Click"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>


            <div id="ChangePasswordModal" class="modal">
                <div class="modal-content">
                    <div class='blur-background' id='blurBackground5'></div>
                    <div class='popup-message' id='popupMessage5'>
                        <div class='popup-content'>
                            <img src='../../Images/email_check.gif' width='200px'>
                            <h2>Update New Password</h2>
                            <p>Please enter the your new password below:</p>
                            <asp:TextBox ID="txtPasswordSet" runat="server" CssClass="country_input" placeholder="Enter New Password" TextMode="Password"></asp:TextBox>
                            <asp:TextBox ID="txtRepeatPasswordSet" runat="server" CssClass="country_input" placeholder="Repeat Password" TextMode="Password"></asp:TextBox>
                            <br />
                            <asp:Label ID="lblErrorPassword" runat="server"></asp:Label>
                            <asp:Button ID="btnPasswordSet" runat="server" Text="Submit" CssClass="btn_verification" OnClick="btnSetPassword_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div id="ChangeEmailModal" class="modal">
                <div class="modal-content">
                    <div class='blur-background' id='blurBackground2'></div>
                    <div class='popup-message' id='popupMessage2'>
                        <div class='popup-content'>
                            <img src='../../Images/email_check.gif' width='200px'>
                            <h2>Enter New Email Address</h2>
                            <p>Please enter the your new email address below:</p>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="country_input" placeholder="Enter New Email"></asp:TextBox>
                            <asp:Button ID="btnEmailUpdate" runat="server" Text="Submit" CssClass="btn_verification" OnClick="btnEmailNew_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div id="SuccessfulModal" class="modal">
                <div class="modal-content">
                    <div class='blur-background' id='blurBackground3'></div>
                    <div class='popup-message' id='popupMessage3'>
                        <div class="popup-content">
                            <img src="../../Images/success.gif" width="200px">
                            <h2>Email Chnaged Successful</h2>
                            <p>You will receive the email soon.</p>
                        </div>
                    </div>
                </div>
            </div>

            <div id="VerifyIdentityModal" class="modal">
                <div class="modal-content">
                    <div class='blur-background' id='blurBackground1'></div>
                    <div class='popup-message' id='popupMessage1'>
                        <div class='popup-content'>
                            <img src='../../Images/alert.gif' width='200px'>
                            <h2>Verify Identity</h2>
                            <p>A verification code has been sent to <strong><%: Session["UserEmail"] %></strong></p>
                            <p>Please enter the 6-digit verification code below:</p>
                            <asp:TextBox ID="txtVerificationCode" runat="server" MaxLength="6" CssClass="verification-input" placeholder="Enter code"></asp:TextBox>
                            <asp:Button ID="btnVerify" runat="server" Text="Verify" CssClass="btn_verification" OnClick="btnVerify_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn_verification" OnClick="btnCancel_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div id="LinkPhoneNoModal" class="modal">
                <div class="modal-content">
                    <div class='blur-background' id='blurBackground4'></div>
                    <div class='popup-message' id='popupMessage4'>
                        <div class='popup-content'>
                            <img src='../../Images/alert.gif' width='200px'>
                            <h2>Link Your Phone Number Now</h2>
                            <p>Enter / Add Your phone number now</p>

                            <div class="input-group">
                                <label for="CountrySelection">Counrty</label>
                                <asp:TextBox ID="txtCountry" runat="server" CssClass="input" Placeholder="Country" onkeyup="fetchSuggestions(this.value)" />
                                <div id="suggestionsFrom" class="suggestions"></div>
                            </div>

                            <asp:TextBox ID="TextBox2" runat="server" MaxLength="11" CssClass="phoneno-input" placeholder="Enter Phone Number"></asp:TextBox>
                            <asp:Button ID="Button1" runat="server" CssClass='btn_verification' Text="Add Now" OnClick="btnAddPhone_Click"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="UpdateEmailModal" class="modal">
                <div class="modal-content">
                    <div class='blur-background' id='blurBackground'></div>
                    <div class='popup-message' id='popupMessage'>
                        <div class='popup-content'>
                            <img src='../../Images/alert.gif' width='200px'>
                            <h2>Change Linked Email</h2>
                            <p>Your account is currently linked with: <strong><%: Session["UserEmail"] %></strong></p>
                            <p>If you wish to change it to a new email address, you will need to verify your identity.</p>
                            <asp:Button ID="btnVeriguIdentity" runat="server" CssClass='btn_verification' Text="Verify Identity" OnClick="btnVerifyIdentity_Click"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="loginPromptModal" class="modal">
                <div class="modal-content">
                    <h2>Please log in</h2>
                    <p>You must log in to access your account page.</p>
                    <asp:Button ID="btnNavigateToLogin" runat="server" CssClass="action-link" Text="Log in" OnClick="btnNavigateToLogin_Click" />
                </div>

            </div>

            <asp:Button ID="btnLogOut" runat="server" CssClass="action-link" Text="Log Out" OnClick="btnLogOut_Click" />


        </div>


        <script>
            function fetchSuggestions(query) {
                if (query.length < 2) {
                    document.getElementById('suggestionsFrom').innerHTML = '';
                    return;
                }

                const xhr = new XMLHttpRequest();
                xhr.open("POST", "UserAccountPage.aspx/GetSuggestions", true);
                xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        const results = JSON.parse(xhr.responseText).d;
                        const suggestionsDiv = document.getElementById('suggestionsFrom');
                        suggestionsDiv.innerHTML = '';
                        results.forEach(result => {
                            const div = document.createElement('div');
                            div.className = 'suggestion-item';
                            div.textContent = result.CountryName + " (" + result.callingCodes + ")";
                            div.onclick = function () {
                                document.getElementById('<%= txtCountry.ClientID %>').value = result.callingCodes;
                                suggestionsDiv.innerHTML = '';
                            };
                            suggestionsDiv.appendChild(div);
                        });
                    }
                };
                xhr.send(JSON.stringify({ query: query }));
            }

            function startEmailUpdate() {
                document.getElementById('popupMessage').remove();
                document.getElementById('blurBackground').remove();

                __doPostBack('btnVerifyIdentity', '');
            }

            function verifyCode() {
                var enteredCode = document.getElementById('verificationCode').value;
                var sessionCode = '<%= Session["VerificationCode"] %>';

                if (enteredCode === sessionCode) {
                    alert('Verification successful');
                    closePopup();
                } else {
                    alert('Invalid code. Please try again.');
                }
            }

            function closePopup() {
                document.getElementById('VerifyIdentityModal').classList.remove('active');
                document.getElementById('overlay').classList.remove('active');
            }

        </script>
    </form>
</asp:Content>
