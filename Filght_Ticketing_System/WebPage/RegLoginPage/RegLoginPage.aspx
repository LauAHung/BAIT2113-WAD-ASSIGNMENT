<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RegLoginPage.aspx.cs" Inherits="Assignemnt_Draft_1.RegLoginPage" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');

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
            background: url('/Images/RegLoginBackground.jpg') no-repeat center center fixed;
            background-size: cover;
            transition: background 1s ease-in-out;
        }

        /* Text Overlay */
        .text-overlay {
            position: absolute;
            top: 50%;
            right: 20%;
            transform: translate(-50%, -50%);
            color: white;
            font-family: 'Poppins', sans-serif;
            font-size: 36px;
            font-weight: 600;
            text-align: center;
            z-index: 1;
            padding: 15px;
            background: rgba(0, 0, 0, 0.5);
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
            line-height: 1.4;
            max-width: 50%;
        }

            .text-overlay h1 {
                font-size: 48px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .text-overlay p {
                font-size: 22px;
                margin-top: 0;
            }

        /* Wrapper */
        .wrapper {
            overflow: hidden;
            max-width: 390px;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 15px 20px rgba(0, 0, 0, 0.1);
            margin-left: 60%;
            margin-top: 50px;
            margin-bottom: 70px;
        }

            .wrapper .title-text {
                display: flex;
                width: 200%;
            }

            .wrapper .title {
                width: 50%;
                font-size: 35px;
                font-weight: 600;
                text-align: center;
                transition: all 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            }

            .wrapper .slide-controls {
                position: relative;
                display: flex;
                height: 50px;
                width: 100%;
                overflow: hidden;
                margin: 30px 0 10px 0;
                justify-content: space-between;
                border: 1px solid lightgrey;
                border-radius: 15px;
            }

        .slide-controls .slide {
            height: 100%;
            width: 100%;
            color: #000;
            font-size: 18px;
            font-weight: 500;
            text-align: center;
            line-height: 48px;
            cursor: pointer;
            z-index: 1;
            transition: all 0.6s ease;
        }

            .slide-controls .slide.active {
                color: #fff;
            }

        #signup:checked ~ label.signup.active,
        #login:checked ~ label.login.active {
            color: #fff;
        }

        .slide-controls .slider-tab {
            position: absolute;
            height: 100%;
            width: 50%;
            left: 0;
            z-index: 0;
            border-radius: 15px;
            background: linear-gradient(90deg, rgba(17,0,36,1) 0%, rgba(76,9,121,1) 35%, rgba(127,6,166,1) 57%, rgba(141,0,255,1) 100%);
            transition: all 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        input[type="radio"] {
            display: none;
        }

        #signup:checked ~ .slider-tab {
            left: 50%;
        }

        #signup:checked ~ label.signup {
            color: #fff;
            cursor: default;
            user-select: none;
        }

        #signup:checked ~ label.login {
            color: #000;
        }

        #login:checked ~ label.signup {
            color: #000;
        }

        #login:checked ~ label.login {
            cursor: default;
            user-select: none;
        }

        .wrapper .form-container {
            width: 100%;
            overflow: hidden;
        }

        .form-container .form-inner {
            display: flex;
            width: 200%;
        }

        .form-inner .login-form,
        .form-inner .signup-form {
            width: 50%;
            transition: all 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        .form-inner .field {
            height: 50px;
            width: 100%;
            margin-top: 20px;
            margin-bottom: 30px;
        }

            .form-inner .field input {
                height: 100%;
                width: 100%;
                outline: none;
                padding-left: 15px;
                border-radius: 15px;
                border: 1px solid lightgrey;
                border-bottom-width: 2px;
                font-size: 17px;
                transition: all 0.3s ease;
            }

                .form-inner .field input:focus {
                    border-color: #1a75ff;
                }

                .form-inner .field input::placeholder {
                    color: #999;
                    transition: all 0.3s ease;
                }

                .form-inner .field input:focus::placeholder {
                    color: #1a75ff;
                }

        .form-inner .pass-link {
            margin-top: 5px;
        }

        .form-inner .signup-link {
            text-align: center;
            margin-top: 30px;
        }

            .form-inner .pass-link a,
            .form-inner .signup-link a {
                color: #1a75ff;
                text-decoration: none;
            }

                .form-inner .pass-link a:hover,
                .form-inner .signup-link a:hover {
                    text-decoration: underline;
                }

        /* Buttons */
        .form-inner .field.btn {
            height: 50px;
            width: 100%;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }

        .field.btn .btn-layer {
            height: 100%;
            width: 300%;
            position: absolute;
            left: -100%;
            background: linear-gradient(90deg, rgba(17,0,36,1) 0%, rgba(76,9,121,1) 35%, rgba(127,6,166,1) 57%, rgba(141,0,255,1) 100%);
            border-radius: 15px;
            transition: all 0.4s ease;
        }

        .field.btn:hover .btn-layer {
            left: 0;
        }

        .field.btn .btn-submit {
            height: 100%;
            width: 100%;
            z-index: 1;
            position: relative;
            background: none;
            border: none;
            color: #fff;
            border-radius: 15px;
            font-size: 20px;
            font-weight: 500;
            cursor: pointer;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
            justify-content: center;
            align-items: center;
        }

        /* Modal content */
        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 80%;
        }

            /* Button */
            .modal-content button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
            }

                .modal-content button:hover {
                    background-color: #0056b3;
                }

        .img_logo {
            text-align: center;
            width: 70%;
            margin-left: 20%;
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

        #ForgotPasswordModal, #VerifyIdentityModal, #VerifyIdentityModal, #ChangePasswordModal, #successModal {
            height: 0px;
        }

        #successModal {
            height: 0px;
            width: 30%;
            display: none;
        }

        #ContentPlaceHolder1_btnHomePage {
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
    </style>
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">
        <div class="wrapper">
            <img class="img_logo" src="../../Images/Travel_Logo.svg" />
            <div class="title-text">
                <div class="title login">Login</div>
                <div class="title signup">Signup Now</div>
            </div>
            <div class="form-container">
                <div class="slide-controls">
                    <asp:HiddenField ID="hfSlideState" runat="server" Value="login" />
                    <label for="login" class="slide login" onclick="switchToLogin()">Login</label>
                    <label for="signup" class="slide signup" onclick="switchToSignup()">Signup</label>
                    <div class="slider-tab" id="sliderTab"></div>
                </div>

                <div class="form-inner">
                    <!-- Login Section -->
                    <div class="login-form">
                        <div class="field">
                            <asp:TextBox ID="txtLoginEmail" runat="server" CssClass="form-control" Placeholder="Email Address"></asp:TextBox>
                            <asp:Label ID="lblLoginEmailError" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="field">
                            <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Password"></asp:TextBox>
                            <asp:Label ID="lblLoginPasswordError" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="pass-link">
                            <asp:ScriptManager ID="ScriptManager1" runat="server" />
                            <a href="#" id="lnkForgotPassword" onclick="showForgotPasswordModal()">Forgot password?</a>
                        </div>
                        <div class="field btn">
                            <div class="btn-layer"></div>
                            <asp:Button ID="btnLogin" runat="server" CssClass="btn-submit" Text="Login" OnClick="btnLogin_Click" />
                        </div>
                        <div class="signup-link">
                            Not a member?
                            <asp:HyperLink ID="lnkSignup" NavigateUrl="#" runat="server">Signup now</asp:HyperLink>
                        </div>
                    </div>

                    <!-- Signup Section -->
                    <div class="signup-form">
                        <div class="field">
                            <asp:TextBox ID="txtSignupUsername" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>
                            <asp:Label ID="lblSignupUsernameError" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="field">
                            <asp:TextBox ID="txtSignupEmail" runat="server" CssClass="form-control" Placeholder="Email Address"></asp:TextBox>
                            <asp:Label ID="lblSignupEmailError" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="field">
                            <asp:TextBox ID="txtSignupPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Password"></asp:TextBox>
                            <asp:Label ID="lblSignupPasswordError" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="field">
                            <asp:TextBox ID="txtSignupConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirm password"></asp:TextBox>
                            <asp:Label ID="lblSignupConfirmPasswordError" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="field btn">
                            <div class="btn-layer"></div>
                            <asp:Button ID="btnSignup" runat="server" CssClass="btn-submit" Text="Signup" OnClick="btnSignup_Click" />
                            <asp:Label ID="lblSignupSuccess" runat="server"></asp:Label>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Text Overlay -->
        <div class="text-overlay" id="background-text">
            <h1>Hallstatt, Austria</h1>
            <p>Visit Hallstatt, Austria, a beautiful village by a clear lake, surrounded by tall mountains...</p>
        </div>

        <div id="successModal" class="modal">
            <div class="modal-content">
                <h2 id="modalTitle">Success</h2>
                <p id="modalMessage">You have successfully logged in/registered.</p>
                <asp:Button ID="btnHomePage" runat="server" Text="Go to Homepage" OnClick="btnHomePage_Click" />
            </div>
        </div>

        <div id="overlay" class="overlay"></div>

        <div id="ForgotPasswordModal" class="modal">

            <div class='popup-message' id='popupMessage'>
                <div class='popup-content'>
                    <img src='../../Images/alert.gif' width='200px'>
                    <h2>Forgot Password</h2>
                    <p>If you wish to change it to a new password, you will need to verify your identity.</p>
                    <br />
                    <label for="lblEmail" class="custom-form-label">Email: </label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" placeholder="Enter Your Email"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Button ID="btnVerifyEmail" runat="server" CssClass='btn_verification' Text="Verify Now" OnClick="btnVerifyIdentity_Click"></asp:Button>
                    <br />
                    <br />
                    <asp:Label ID="lblEmailError" runat="server"></asp:Label>
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
                        <asp:Label ID="lblVerificationError" runat="server"></asp:Label>
                        <asp:Button ID="btnVerify" runat="server" Text="Verify" CssClass="btn_verification" OnClick="btnVerify_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn_verification" OnClick="btnCancel_Click" />
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



        <script>

            function showForgotPasswordModal() {
                document.getElementById('ForgotPasswordModal').classList.add('active');
                document.getElementById('overlay').classList.add('active');
            }

            function showModal(title, message) {
                document.getElementById("modalTitle").innerText = title;
                document.getElementById("modalMessage").innerText = message;
                document.getElementById("successModal").style.display = "flex";
            }


            const sliderTab = document.getElementById('sliderTab');
            const hfSlideState = document.getElementById('<%= hfSlideState.ClientID %>');
            const loginLabel = document.querySelector('.slide.login');
            const signupLabel = document.querySelector('.slide.signup');

            function switchToLogin() {
                hfSlideState.value = 'login';
                sliderTab.style.left = '0%';
                document.querySelector('.login-form').style.marginLeft = '0%';
                document.querySelector('.title-text .login').style.marginLeft = '0%';


                loginLabel.classList.add('active');
                signupLabel.classList.remove('active');
            }

            function switchToSignup() {
                hfSlideState.value = 'signup';
                sliderTab.style.left = '50%';
                document.querySelector('.login-form').style.marginLeft = '-50%';
                document.querySelector('.title-text .login').style.marginLeft = '-50%';


                signupLabel.classList.add('active');
                loginLabel.classList.remove('active');
            }

            document.addEventListener('DOMContentLoaded', () => {
                if (hfSlideState.value === 'signup') {
                    switchToSignup();
                } else {
                    switchToLogin();
                }
            });


            const loginForm = document.querySelector(".login-form");
            const signupForm = document.querySelector(".signup-form");
            const loginBtn = document.querySelector("label.login");
            const signupBtn = document.querySelector("label.signup");
            const signupLink = document.querySelector(".signup-link a");

            signupLink.onclick = (e) => {
                e.preventDefault();
                signupBtn.click();
            };


            const backgrounds = [
                { url: '../../Images/RegLoginBackground1.jpg', title: 'Hallstatt, Austria', text: 'Visit Hallstatt, Austria, a beautiful village by a clear lake, surrounded by tall mountains. Walk through old streets, see ancient salt mines, and enjoy the peaceful views. This tour is perfect for nature lovers and history fans.' },
                { url: '../../Images/RegLoginBackground2.jpg', title: 'A Stunning View', text: 'Discover the beauty of nature and history through our exclusive tours. Explore hidden gems and serene landscapes.' },
                { url: '../../Images/RegLoginBackground3.jpg', title: 'Mountain Escape', text: 'Breathe in the fresh mountain air and witness breathtaking views of the surrounding peaks.' },
                { url: '../../Images/RegLoginBackground4.jpg', title: 'The Quiet Shores', text: 'Find peace on the shores of tranquil lakes, where the sound of nature calms your soul.' }
            ];

            let currentIndex = 0;

            function changeBackground() {
                const currentBackground = backgrounds[currentIndex];
                document.body.style.background = `url('${currentBackground.url}') no-repeat center center fixed`;
                document.body.style.backgroundSize = 'cover';

                const textOverlay = document.getElementById('background-text');
                textOverlay.querySelector('h1').textContent = currentBackground.title;
                textOverlay.querySelector('p').textContent = currentBackground.text;

                currentIndex = (currentIndex + 1) % backgrounds.length;
            }


            setInterval(changeBackground, 5000);

        </script>
    </form>
</asp:Content>
