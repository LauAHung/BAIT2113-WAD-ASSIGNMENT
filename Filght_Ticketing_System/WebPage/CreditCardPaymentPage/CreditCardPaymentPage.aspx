<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CreditCardPaymentPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.CreditCardPaymentPage.CreditCardPaymentPage" %>

<asp:Content ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        .container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            max-width: 1200px;
            margin: auto;
        }

        .payment-section,
        .booking-summary {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 48%;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 1.5em;
            color: #333333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555555;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn-submit {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

            .btn-submit:hover {
                background-color: #0056b3;
            }

        .booking-summary p {
            margin: 10px 0;
            font-size: 14px;
            color: #555555;
        }

            .booking-summary p strong {
                color: #333333;
            }
    </style>
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="container">
            <div class="payment-section">
                <h2>Payment Information</h2>
                <div class="form-group">
                    <label for="txtCardNumber">Card Number</label>
                    <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" MaxLength="16"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtCardHolderName">Cardholder Name</label>
                    <asp:TextBox ID="txtCardHolderName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtCardExpire">Expiry Date (MM/YY)</label>
                    <asp:TextBox ID="txtCardExpire" runat="server" CssClass="form-control" MaxLength="5"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtCardCVV">CVV</label>
                    <asp:TextBox ID="txtCardCVV" runat="server" CssClass="form-control" MaxLength="3"></asp:TextBox>
                </div>
                <asp:Button ID="btnSubmit" runat="server" Text="Make Payment" CssClass="btn-submit" OnClick="btnSubmit_Click" />
            </div>

            <div class="booking-summary">
                <h2>Booking Summary</h2>
                <p>
                    <strong>From:</strong>
                    <asp:Label ID="lblFromLocation" runat="server"></asp:Label>
                </p>
                <p>
                    <strong>To:</strong>
                    <asp:Label ID="lblToLocation" runat="server"></asp:Label>
                </p>
                <p>
                    <strong>Depart Date:</strong>
                    <asp:Label ID="lblDepartDate" runat="server"></asp:Label>
                </p>
                <p>
                    <strong>Return Date:</strong>
                    <asp:Label ID="lblReturnDate" runat="server"></asp:Label>
                </p>
                <p>
                    <strong>Total Price:</strong>
                    <asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                </p>
            </div>
        </div>
    </form>
</asp:Content>
