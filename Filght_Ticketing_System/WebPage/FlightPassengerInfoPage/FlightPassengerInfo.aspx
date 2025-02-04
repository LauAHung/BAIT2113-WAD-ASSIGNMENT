<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FlightPassengerInfo.aspx.cs" Inherits="Assignemnt_Draft_1.FlightPassengerInfo" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="FlightPassengerInfo.css">
    <style>
        
.suggestions {
    border: 1px solid #dadcdf;
    background: #fff;
    max-height: 150px;
    overflow-y: auto;
    position: absolute;
    width: 100%;
    z-index: 1000;
    border-radius: 5px;
}

.suggestion-item {
    padding: 8px 10px;
    cursor: pointer;
}

    .suggestion-item:hover {
        background: #f0f0f0;
    }

.suggestions {
    width: 100%;
}

    </style>
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="form-container">
            <div class="left-section">
                <div class="box">
                    <div class="trip-container">
                        <div class="trip-header">
                            <h1>Trip to Kuala Lumpur</h1>
                            <asp:Button ID="ChangeFlightButton" runat="server" CssClass="change-flight" Text="Change Flight" OnClick="ChangeFlightButton_Click" />
                        </div>
                        <!-- Depart Section -->
                        <div class="flight-section">
                            <div class="flight-type-container">
                                <div class="flight-type depart">Depart</div>
                                <asp:Label ID="DepartDateDuration" runat="server" CssClass="date-duration"></asp:Label>
                            </div>

                            <div class="flight-time">
                                <div class="time-and-icon">
                                    <asp:Label ID="DepartTimeStart" runat="server" CssClass="time"></asp:Label>
                                    <asp:Image ID="DepartAirplaneIcon" runat="server" CssClass="airplane-icon" />
                                    <asp:Label ID="DepartTimeEnd" runat="server" CssClass="time"></asp:Label>
                                </div>
                                <div class="separator"></div>
                                <div class="flight-details">
                                    <asp:Label ID="DepartLocationStart" runat="server" CssClass="location"></asp:Label>
                                    <p class="flight-info">
                                        <asp:Label ID="DepartAirline" runat="server" CssClass="airline"></asp:Label>
                                        <asp:Label ID="DepartFlightNumber" runat="server" CssClass="flight-number"></asp:Label>
                                        <asp:Label ID="DepartPlane" runat="server" CssClass="plane"></asp:Label>
                                        <asp:Label ID="DepartClass" runat="server" CssClass="class"></asp:Label>
                                    </p>
                                    <asp:Label ID="DepartLocationEnd" runat="server" CssClass="location"></asp:Label>
                                </div>
                            </div>
                        </div>

                        <!-- Return Section -->
                        <div class="flight-section">
                            <div class="flight-type-container">
                                <div class="flight-type return">Return</div>
                                <asp:Label ID="ReturnDateDuration" runat="server" CssClass="date-duration"></asp:Label>
                            </div>

                            <div class="flight-time">
                                <div class="time-and-icon">
                                    <asp:Label ID="ReturnTimeStart" runat="server" CssClass="time"></asp:Label>
                                    <asp:Image ID="ReturnAirplaneIcon" runat="server" CssClass="airplane-icon" />
                                    <asp:Label ID="ReturnTimeEnd" runat="server" CssClass="time"></asp:Label>
                                </div>
                                <div class="separator"></div>
                                <div class="flight-details">
                                    <asp:Label ID="ReturnLocationStart" runat="server" CssClass="location"></asp:Label>
                                    <p class="flight-info">
                                        <asp:Label ID="ReturnAirline" runat="server" CssClass="airline"></asp:Label>
                                        <asp:Label ID="ReturnFlightNumber" runat="server" CssClass="flight-number"></asp:Label>
                                        <asp:Label ID="ReturnPlane" runat="server" CssClass="plane"></asp:Label>
                                        <asp:Label ID="ReturnClass" runat="server" CssClass="class"></asp:Label>
                                    </p>
                                    <asp:Label ID="ReturnLocationEnd" runat="server" CssClass="location"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Passenger Information -->

                <asp:PlaceHolder ID="PassengerPlaceholder" runat="server"></asp:PlaceHolder>


                <!-- Contact Information -->
                <div class="box">
                    <h2>Contact Information</h2>
                    <p>Enter your email and phone number to receive booking confirmation and trip updates.</p>
                    <div class="input-box">
                        <label class="input-label">Email</label>
                        <asp:TextBox ID="EmailTextBox" runat="server" CssClass="input-1" TextMode="Email"></asp:TextBox>
                    </div>

                    <div class="input-box">
                        <label class="input-label">Confirm Email</label>
                        <asp:TextBox ID="ConfirmEmailTextBox" runat="server" CssClass="input-1" TextMode="Email"></asp:TextBox>
                    </div>

                    <div class="input-box">
                        <div class="input-group">
                            <asp:TextBox ID="txtCountry" runat="server" CssClass="input-1" Placeholder="Country" onkeyup="fetchSuggestions(this.value)" />
                            <div id="suggestionsFrom" class="suggestions"></div>
                        </div>
                    </div>

                    <div class="input-box">
                        <label class="input-label">Phone Number</label>
                        <asp:TextBox ID="PhoneNumberTextBox" runat="server" CssClass="input-1" TextMode="Phone"></asp:TextBox>
                    </div>
                </div>

                <div class="box">
                    <div class="baggage-section">
                        <h3>Checked baggage</h3>
                        <div class="baggage-options">
                            <asp:Button ID="btnNone" runat="server" CssClass="option-btn" Text="None" OnClick="BaggageSelection_Click" />
                            <asp:Button ID="btn15kg" runat="server" CssClass="option-btn" Text="15 kg&#10;MYR 64.80" OnClick="BaggageSelection_Click" />
                            <asp:Button ID="btn20kg" runat="server" CssClass="option-btn" Text="20 kg&#10;MYR 86.40" OnClick="BaggageSelection_Click" />
                            <asp:Button ID="btn25kg" runat="server" CssClass="option-btn" Text="25 kg&#10;MYR 101.52" OnClick="BaggageSelection_Click" />
                            <asp:Button ID="btn30kg" runat="server" CssClass="option-btn" Text="30 kg&#10;MYR 122.04" OnClick="BaggageSelection_Click" />
                            <asp:Button ID="btn40kg" runat="server" CssClass="option-btn" Text="40 kg&#10;MYR 186.84" OnClick="BaggageSelection_Click" />
                            <asp:Button ID="btn50kg" runat="server" CssClass="option-btn" Text="50 kg&#10;MYR 245.16" OnClick="BaggageSelection_Click" />
                            <asp:Button ID="btn60kg" runat="server" CssClass="option-btn" Text="60 kg&#10;MYR 324.00" OnClick="BaggageSelection_Click" />
                        </div>
                    </div>
                </div>


                <div class="seat-box">
                    <div class="seat-info">
                        <img class="seat-icon" src="../../Images/flight_seat_icon.png" alt="Seat Icon" />
                        <div>
                            <h2>Pick a seat</h2>
                            <p>Choose your seat or we’ll assign one to you at random</p>
                        </div>
                    </div>

                    <asp:Button ID="PickSeatButton" runat="server" CssClass="seat-button" Text="Pick a seat" OnClientClick="return false;" />
                    <!-- Modal (pop-up) for seating layout -->
                    <div id="seat-modal" class="seat-modal">
                        <div class="modal-content">
                            <div class="seating-layout" id="seating-layout">
                                <!-- Seating layout will be generated dynamically here -->
                            </div>

                            <div class="selected-seat-box" id="selected-seat-box">
                                <h3>Selected Seat</h3>
                                <p id="selected-seat">None</p>
                            </div>
                            <button id="close-modal" class="close-modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Section -->
            <div class="right-section">
                <div class="box">
                    <div class="price-details">
                        <h2>Price Details</h2>

                        <!-- Tickets Section -->
                        <div class="price-row">
                            <div class="price-label">Tickets (Total)</div>
                            <asp:Label ID="TicketsPriceLabel" runat="server" CssClass="price-value"></asp:Label>
                        </div>

                        <div class="price-row">
                            <div class="price-label">Adult(s)</div>
                            <asp:Label ID="AdultsPriceLabel" runat="server" CssClass="price-value"></asp:Label>
                        </div>

                        <div class="price-row">
                            <div class="price-label">Child(ren)</div>
                            <asp:Label ID="ChildrenPriceLabel" runat="server" CssClass="price-value"></asp:Label>
                        </div>
                        <div class="price-subrow">
                            <div class="price-label">Fare</div>
                            <asp:Label ID="FareLabel" runat="server" CssClass="price-value"></asp:Label>
                        </div>
                        <div class="price-subrow">
                            <div class="price-label">Taxes & Fees</div>
                            <asp:Label ID="TaxesLabel" runat="server" CssClass="price-value"></asp:Label>
                        </div>

                        <!-- Baggage Section -->
                        <div class="price-row">
                            <div class="price-label">
                                <br />
                                <b>Baggage</b>
                            </div>
                        </div>
                        <div class="price-subrow">
                            <div class="price-label">Personal item</div>
                            <asp:Label ID="PersonalItemLabel" runat="server" CssClass="price-value" Text="Free"></asp:Label>
                        </div>
                        <div class="price-subrow">
                            <div class="price-label">Carry-on baggage</div>
                            <asp:Label ID="CarryOnBaggageLabel" runat="server" CssClass="price-value" Text="Free"></asp:Label>
                        </div>
                        <div class="price-row">
                            <div class="price-label">Checked Baggage</div>
                            <asp:Label ID="BaggageStatusLabel" runat="server" CssClass="price-value">Not Included</asp:Label>
                        </div>


                        <!-- Total Section -->
                        <div class="total-row">
                            <div class="total-label">Total</div>
                            <asp:Label ID="TotalLabel" runat="server" CssClass="total-value"></asp:Label>
                        </div>

                        <asp:Button ID="btnPayment" runat="server" Text="Proceed to Payment" CssClass="btnPayment" OnClick="btnPayment_Click" />

                        <br />
                        <asp:Label ID="ErrorMessageLabel" runat="server"></asp:Label>

                    </div>
                </div>
            </div>
        </div>

        <script>
            function fetchSuggestions(query) {
                if (query.length < 2) {
                    document.getElementById('suggestionsFrom').innerHTML = '';
                    return;
                }

                const xhr = new XMLHttpRequest();
                xhr.open("POST", "FlightPassengerInfo.aspx/GetSuggestions", true);
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

            // Show the seat modal when the button is clicked
            document.querySelector(".seat-button").addEventListener("click", function () {
                document.getElementById("seat-modal").style.display = "flex";
                generateSeats();
            });

            // Close the seat modal when the close button is clicked
            document.getElementById("close-modal").addEventListener("click", function () {
                document.getElementById("seat-modal").style.display = "none";
            });

            // Function to generate seats dynamically
            function generateSeats() {
                const seatingLayout = document.getElementById("seating-layout");
                seatingLayout.innerHTML = ""; // Clear existing seats

                const rows = ['A', 'B', 'C', 'D', 'E', 'F']; // Define row labels
                const columns = 6; // Number of columns (1 to 6)

                for (let row = 0; row < 10; row++) { // Loop through rows (10 rows)
                    const rowDiv = document.createElement("div");
                    rowDiv.classList.add("seat-row");

                    for (let col = 1; col <= columns; col++) { // Loop through columns (1 to 6)
                        const seat = document.createElement("div");
                        seat.classList.add("seat");
                        seat.textContent = `${rows[col - 1]}${row + 1}`; // Assign seat as A1, B1, etc.
                        seat.addEventListener("click", function () {
                            selectSeat(seat);
                        });
                        rowDiv.appendChild(seat);
                    }
                    seatingLayout.appendChild(rowDiv);
                }
            }

            function selectSeat(seat) {
                const selectedSeatLabel = document.getElementById("selected-seat");

                const selectedSeats = document.querySelectorAll(".seat.selected");
                selectedSeats.forEach(function (s) {
                    s.classList.remove("selected");
                });

                seat.classList.add("selected");

                // Update the selected seat text
                selectedSeatLabel.textContent = seat.textContent;
            }





        </script>
    </form>
</asp:Content>

