<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TngEwalletPaymentPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.TngEwalletPaymentPage.TngEwalletPaymentPage" %>

<asp:Content ContentPlaceHolderID="head" runat="server">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
        }

        .container {
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
            margin-top: 20px;
            width: 100%;
            margin-bottom: 40px;
        }


        .payment_detail {
            flex-grow: 2;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-right: 5px;
            width: 65%;
        }


        .payment_summary {
            flex-grow: 1;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            width: 35%;
            margin-right: 5%;
            text-align: left;
        }

        .subtotal,
        .quantity,
        .total-value {
            float: right;
        }


        h2 {
            font-family: "Ploni", sans-serif;
            width: 100%;
            text-align: left;
            padding-left: 10%;
            font-size: 30px;
        }

        h1.main_title {
            margin-top: 4%;
            font-family: "Ploni", sans-serif;
            width: 100%;
            text-align: left;
            padding-left: 10%;
            padding-bottom: 2%;
            font-size: 40px;
        }

        h3 {
            text-align: center;
        }



        .payment_detail {
            border: 1px solid #ccc;
            padding: 20px;
            margin-left: 10%;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-right: 5%;
        }

        h3 {
            background-color: #f0f0f0;
            padding: 10px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
        }

        button.payment_done {
            background-color: rgb(76, 108, 220);
            color: white;
            font-family: "Ploni", sans-serif;
            font-weight: 550;
            padding: 8px 120px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
        }

            button.payment_done:hover {
                background-color: rgb(38, 0, 255);
                color: white;
                font-family: "Ploni", sans-serif;
                font-weight: 550;
                padding: 8px 120px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                cursor: pointer;
                border-radius: 5px;
                margin-top: 20px;
            }

        .content_container {
            display: flex;
            justify-content: space-between;
        }

        .pic_container > div {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-left: auto;
            margin-right: auto;
            max-width: 200px;
            margin-left: 50px;
        }

        .pic_container img {
            width: 200px;
            height: auto;
            border: 3px solid;
            border-image: linear-gradient(159deg, rgba(124,0,128,1) 7%, rgba(228,3,148,1) 56%, rgba(255,0,0,1) 100%);
            background: linear-gradient(159deg, rgba(124,0,128,1) 7%, rgba(228,3,148,1) 56%, rgba(255,0,0,1) 100%);
            box-shadow: 1px 4px 25px 2px #454545;
            border-radius: 5px;
        }

        .pic_container > div > p {
            text-align: center;
            width: 100%;
            margin-top: 10px;
            font-size: 16px;
            padding-top: 20px;
        }


        .payment_description > h4 {
            font-size: 25px;
            padding-bottom: 20px;
        }


        .payment_description {
            flex-grow: 1;
            padding-left: 40px;
            text-align: left;
            padding-top: 6%;
            line-height: 25px;
        }

            .payment_description h4, .payment_description p {
                margin: 0;
            }

        .safe_text {
            display: flex;
            align-items: center;
            margin-top: 50px;
            padding-left: 10%;
        }

            .safe_text img {
                width: 50px;
                height: auto;
                margin-right: 10px;
            }

            .safe_text p {
                display: inline-block;
                vertical-align: middle;
            }

        .payment_summary span {
            font-weight: bold;
        }

        hr {
            border: none;
            height: 1px;
            background-color: #ccc;
            margin: 10px 0;
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
                padding: 20px;
            }
    </style>
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="main_title">eWallet Payment</h1>
    <h2>Payment Information</h2>
    <div class="container">
        <div class="payment_detail">
            <div class="text-container">
                <h3>Payment Detail</h3>
            </div>
            <div class="content_container">
                <div class="pic_container">
                    <div>
                        <img src="../../Images/ewalletqr.png" alt="eWallet" />
                        <p>QR code will expire in <span id="timer">00:30</span></p>
                    </div>
                </div>
                <div class="payment_description">
                    <h4>Pay with your any eWallet App!</h4>
                    <p>
                        1. Download any eWallet App and register an account.<br>
                        2. Tap on 'Scan' icon<br>
                        3. Scan QR Code here and complete the payment!
                        <button class="payment_done" id="nextButton">Next</button>
                    </p>
                </div>
            </div>
            <div class="safe_text">
                <img src="../../Images/safe_icon.png" alt="safe_icon" style="width: 30px;">
                <p>Your payment will be processed in a safe and secured environment!</p>
            </div>
        </div>

        <div class="payment_summary">
            <div class="text-container">
                <h3>Order Summary</h3>
            </div>
            <div id="userDetails"></div>
            <p>Payment to : <span>TRAVELFREE ACCOUNT</span></p>
            <asp:Label ID="lblTransactionNo" runat="server" CssClass="transaction_no"></asp:Label>
            <asp:Label ID="lblBookingID" runat="server" CssClass="BookingID"></asp:Label>
            <asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
            <hr />
            <div id="summaryDetails" class="summaryDetails"></div>
        </div>
    </div>
    <script> 
        document.addEventListener('DOMContentLoaded', function () {

            // Add event listener to the Next button
            const nextButton = document.getElementById('nextButton');
            nextButton.addEventListener('click', function () {
                displaySuccessfulPaymentPopupAndNavigate();
            });
        });


        function displayUserDetails(currentUser) {
            const userDetailsDiv = document.getElementById('userDetails');
            userDetailsDiv.innerHTML = `<p>Username: ${currentUser.userName}</p><p>Email: ${currentUser.email}</p>`;
        }



        function initializePaymentButtons() {
        }

        function displayShippingDetails() {
        }


        window.onload = function () {
            var timeDisplay = document.getElementById('timer');
            var thirtySeconds = 29;
            startTimer(thirtySeconds, timeDisplay);
        };

        function startTimer(duration, display) {
            var timer = duration, minutes, seconds;
            var countdown = setInterval(function () {
                minutes = parseInt(timer / 60, 10);
                seconds = parseInt(timer % 60, 10);

                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                display.textContent = minutes + ":" + seconds;

                if (--timer < 0) {
                    clearInterval(countdown);
                    displayUnsuccessfulPaymentPopup();
                }
            }, 1000);
        }

        function displayUnsuccessfulPaymentPopup() {
            const blurBackground = document.createElement('div');
            blurBackground.className = 'blur-background';
            document.body.appendChild(blurBackground);

            const popupMessage = document.createElement('div');
            popupMessage.className = 'popup-message';
            popupMessage.innerHTML = `
        <div class="popup-content">
            <img src="../../Images/failed.gif" width="200px">
            <h2>Payment Unsuccessful</h2>
            <p>Your payment could not be processed. Please try again.</p>
            <button class="payment_done" onclick="location.reload()">Refresh</button>
        </div>
    `;
            document.body.appendChild(popupMessage);

        }

        function displaySuccessfulPaymentPopupAndNavigate() {
            const blurBackground = document.createElement('div');
            blurBackground.className = 'blur-background';
            document.body.appendChild(blurBackground);

            const popupMessage = document.createElement('div');
            popupMessage.className = 'popup-message';
            popupMessage.innerHTML = `
        <div class="popup-content">
            <img src="../../Images/success.gif" width="200px">
            <h2>Payment Successful</h2>
            <p>Your payment was successfully processed.</p>
        </div>
    `;
            playSuccessSound();
            document.body.appendChild(popupMessage);

            setTimeout(function () {
                window.location.href = '../UserBookingPage/UserBookingPage.aspx';
            }, 3000);
        }

        function playSuccessSound() {
            const audio = new Audio('../audio/success.mp3');
            audio.play();
        }



    </script>



</asp:Content>
