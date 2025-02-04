<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FlightPaymentPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.FlightPaymentPage" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        @font-face {
            font-family: 'Trip';
            src: url('../../Font/TripGeom-Regular.ttf');
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            font-family: 'Trip';
            font-weight: 700;
        }


        .container {
            margin-top: 50px;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 50px;
            display: flex;
            justify-content: space-between;
            padding: 20px;
            max-width: 900px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .payment-section {
            flex: 2;
            margin-right: 20px;
        }

        .payment-method, .gift-card {
            margin-bottom: 15px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
        }

        .payment-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
        }

            .payment-row span {
                display: flex;
                align-items: center;
                margin-right: auto;
            }

        .payment-method .card-icons img,
        .payment-method .bank-icons img {
            width: 30px;
            margin-left: 5px;
        }

        .payment-method input[type="radio"] {
            margin-right: 10px;
        }

        .payment-method .card-icons img,
        .payment-method .bank-icons img {
            width: 30px;
            margin-right: 5px;
        }

        .credit-card-form {
            margin-top: 10px;
            padding: 15px;
            border: 2px solid #3164FF;
            border-radius: 8px;
            background-color: #F3F6FF;
            display: none;
        }

            .credit-card-form input {
                display: block;
                width: 100%;
                margin-bottom: 10px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .credit-card-form .expiry-cvv {
                display: flex;
                gap: 10px;
                margin-top: -10px;
                width: auto;
            }

        .discount {
            font-size: 0.9em;
            color: #f90;
            margin-top: 5px;
        }

        .gift-card input[type="checkbox"] {
            margin-right: 10px;
        }

        .booking-info {
            flex: 1;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f1f1f1;
        }

            .booking-info h3 {
                margin-top: 0;
            }

        .button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* Input Box Styles */
        .input-box {
            position: relative;
            margin: 10px 0;
        }

        .input-box-container {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

            .input-box-container .input-box {
                flex: 1;
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

        #ContentPlaceHolder1_CVV {
            width: 300px;
        }

        .wallet-icons img {
            width: 30px;
            margin-left: 5px;
        }

        .bank-icons {
            display: flex;
            margin-left: auto;
        }

            .bank-icons img {
                height: 30px;
                margin-left: 5px;
            }
    </style>
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="container">
            <div class="payment-section">
                <h2>Select a Payment Method</h2>
                <div class="payment-method">
                    <label>
                        <div class="payment-row">
                            <asp:Button ID="btnCreditCardOption" runat="server" OnClick="btnCreditCardOption_Click" />
                            <span class="credit_text">Credit/Debit Card</span>
                            <div class="card-icons">
                                <img src="../../Images/visa_icon.png" alt="Visa" />
                                <img src="../../Images/mastercard_icon.png" alt="MasterCard" />
                                <img src="../../Images/unionpay_icon.png" alt="Amex" />
                            </div>
                        </div>

                    </label>
                    <div class="credit-card-form" id="creditCardForm">
                        <div class="input-box">
                            <label class="input-label">Bank Card Number</label>
                            <asp:TextBox runat="server" ID="BankCardNo" CssClass="input-1" />
                        </div>
                        <div class="input-box">
                            <label class="input-label">Cardholder Name</label>
                            <asp:TextBox runat="server" ID="CardHolderName" CssClass="input-1" />
                        </div>
                        <div class="expiry-cvv">
                            <div class="input-box">
                                <label class="input-label">Expiry date</label>
                                <asp:TextBox runat="server" ID="ExpiryDate" CssClass="input-1" />
                            </div>
                            <div class="input-box">
                                <label class="input-label">CVV/CVC</label>
                                <asp:TextBox runat="server" ID="CVV" CssClass="input-1" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="payment-method">
                    <label>
                        <div class="payment-row">
                            <asp:Button ID="TngOption" runat="server" OnClick="TngOption_Click"  />
                            <span class="tng_text">Touch 'n Go eWallet</span>
                            <div class="wallet-icons">
                                <img src="../../Images/tng_icon.png" alt="Touch 'n Go eWallet" />
                            </div>
                        </div>
                    </label>
                </div>

                
            </div>
            <div class="booking-info">
                <asp:Label ID="lblBookingInfo" runat="server"></asp:Label>
                <asp:Button ID="Payment" runat="server" Text="Select and Pay" CssClass="button"  />
            </div>
        </div>
        </div>
    </div>
    <script>
        const creditCardOption = document.getElementById("creditCardOption");
        const creditCardForm = document.getElementById("creditCardForm");

        const paymentOptions = document.querySelectorAll('input[name="payment"]');
        paymentOptions.forEach((option) => {
            option.addEventListener("change", function () {
                if (creditCardOption.checked) {
                    creditCardForm.style.display = "block";
                } else {
                    creditCardForm.style.display = "none";
                }
            });
        });

        //TextField
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
