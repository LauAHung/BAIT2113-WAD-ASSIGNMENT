<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TrainBookingPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.TrainBookingPage.TrainBookingPage" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="TrainBookingPage.css">
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">

        <div class="carousel">
            <div class="carousel-item active">
                <img src="../../Images/train.jpg" />
            </div>
        </div>

        <div class="carousel2">
            <div class="carousel-item active">
            </div>
        </div>

        <!-- Search Bar Section -->
        <div class="search-bar">
            <div class="search-bar-container">
                <!-- Dropdown Section -->
                <div class="dropdown">
                    <!-- Booking Bar -->
                    <div class="booking-bar">
                        <!-- Trip Type Dropdown -->
                        <div class="separator"></div>
                    </div>

                    <!-- Search Options -->
                    <div class="search-options">
                        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
                        <!-- From and To Input -->
                        <div class="form-group">
                            <label for="txtFrom">Depart Location</label>
                            <asp:TextBox ID="txtFrom" runat="server" CssClass="input-wrapper" Placeholder="Where from?" onkeyup="fetchTrainFrom(this.value)"></asp:TextBox>
                            <div id="fromSuggestions" class="suggestions"></div>
                        </div>

                        <div class="form-group">
                            <label>&nbsp;</label>
                            <div class="input-wrapper">
                                <span class="exchange-icon" id="exchange-icon" onclick="swapLocations()">&#8646;</span>
                            </div>
                        </div>
                        <!-- From and To Input -->
                        <div class="form-group">
                            <label for="txtTo">Arrive Location</label>
                            <asp:TextBox ID="txtTo" runat="server" CssClass="input-wrapper" Placeholder="Where to?" onkeyup="fetchTrainTo(this.value)"></asp:TextBox>
                            <div id="toSuggestions" class="suggestions"></div>
                        </div>

                        <!-- Date Inputs -->
                        <div class="form-group">
                            <label for="txtDepartDate">&nbsp;Departure Date</label>
                            <div class="input-wrapper">
                                <input type="date" id="txtDepartureDate" name="txtDepartureDate" onchange="validateDates()">
                            </div>
                        </div>

                        <!-- Search Button -->
                        <div class="form-group">
                            <label for="lblReturnDate">&nbsp;</label>
                            <div class="input-wrapper">
                                <button id="btnSearch" class="search-btn">Search</button>
                            </div>
                        </div>

                        <button class="dropdown-toggle" id="passengerDropdown">
                            👤 <span id="passengerCount">13 passengers</span>
                        </button>

                    </div>
                </div>
            </div>
        </div>

        <asp:Repeater ID="rptTrain" runat="server">
            <HeaderTemplate>
                <div class="trainlist">
                    <div class="showlist">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="ticket">
                    <div class="header">
                        <img src="../../Images/train.png" alt="Train Logo" />
                        <span class="price">RM <%# Eval("price") %></span>
                    </div>
                    <div class="details">
                        <div class="time">
                            <%# Eval("departDateTime", "{0:HH:mm}") %> → <%# Eval("arriveDateTime", "{0:HH:mm}") %>
                        </div>
                        <div class="stations">
                            <%# Eval("departCity") %> → <%# Eval("arriveCity") %>
                        </div>
                        <div class="duration">
                            <%# Eval("duration") %> hours
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
        </div>
            </FooterTemplate>
        </asp:Repeater>

        <asp:Label ID="lblMessage" runat="server" ></asp:Label>



        <script>
            function fetchTrainFrom(query) {
                if (query.length < 2) {
                    document.getElementById("fromSuggestions").innerHTML = "";
                    return;
                }

                $.ajax({
                    url: "TrainBookingPage.aspx/GetTrains",
                    method: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ searchTerm: query }),
                    dataType: "json",
                    success: function (response) {
                        let depots = response.d;
                        let suggestionsHTML = "";

                        depots.forEach(function (depot) {
                            suggestionsHTML += `<div class='suggestion-item' onclick="selectTrainFrom('${depot.City}')">
                    ${depot.City} - ${depot.TrainDepotName}
                </div>`;
                        });

                        document.getElementById("fromSuggestions").innerHTML = suggestionsHTML;
                    },
                    error: function (error) {
                        console.error("Error in AJAX request:", error.responseText);
                    }
                });
            }

            function selectTrainFrom(city) {
                var txtFrom = document.getElementById('<%= txtFrom.ClientID %>');
                txtFrom.value = city;
                document.getElementById("fromSuggestions").innerHTML = "";
            }

            function fetchTrainTo(query) {
                if (query.length < 2) {
                    document.getElementById("toSuggestions").innerHTML = "";
                    return;
                }

                $.ajax({
                    url: "TrainBookingPage.aspx/GetTrains",
                    method: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ searchTerm: query }),
                    dataType: "json",
                    success: function (response) {
                        let depots = response.d;
                        let suggestionsHTML = "";

                        depots.forEach(function (depot) {
                            suggestionsHTML += `<div class='suggestion-item' onclick="selectTrainTo('${depot.City}')">
        ${depot.City} - ${depot.TrainDepotName}
    </div>`;
                        });

                        document.getElementById("toSuggestions").innerHTML = suggestionsHTML;
                    },
                    error: function (error) {
                        console.error("Error in AJAX request:", error.responseText);
                    }
                });
            }

            function selectTrainTo(city) {
                var txtTo = document.getElementById('<%= txtTo.ClientID %>');
                txtTo.value = city;
                document.getElementById("toSuggestions").innerHTML = "";
            }

            const body = document.body;
            const header = document.querySelector('header');
            const links = header.querySelectorAll('a');
            const navAnimate = document.querySelector('.nav-animate');

            let ticking = false;
            function handleScroll() {
                if (!ticking) {
                    requestAnimationFrame(() => {
                        const isSticking = window.scrollY > header.offsetHeight;
                        header.classList.toggle('sticking', isSticking);
                        ticking = false;
                    });
                    ticking = true;
                }
            }

            window.addEventListener('scroll', handleScroll);

            // Nav hover animation
            function handleLinkMouseOver(event) {
                const target = event.target;
                navAnimate.style.opacity = '1';
                navAnimate.style.top = `${target.offsetTop}px`;
                navAnimate.style.left = `${target.offsetLeft}px`;
                navAnimate.style.width = `${target.offsetWidth}px`;
                navAnimate.style.height = `${target.offsetHeight}px`;
            }

            function handleLinkMouseLeave() {
                navAnimate.style.opacity = '0';
            }

            links.forEach(link => {
                link.addEventListener('mouseover', handleLinkMouseOver);
                link.addEventListener('mouseleave', handleLinkMouseLeave);
            });

            const sections = document.querySelectorAll('section');
            const stickyHeight = header.offsetHeight + 'px';
            sections.forEach(section => {
                section.style.paddingTop = `calc(${stickyHeight} + 1em)`;
            });


            //passenger
            const adultCount = document.getElementById('adultCount');
            const childCount = document.getElementById('childCount');
            const passengerCount = document.getElementById('passengerCount');

            function updateCount(type, change) {
                const count = type === 'adults' ? adultCount : childCount;
                let currentValue = parseInt(count.innerText);
                currentValue += change;
                if (currentValue < 0) return; // Prevent negative numbers
                count.innerText = currentValue;
                updatePassengerCount();
            }

            function updatePassengerCount() {
                const adults = parseInt(adultCount.innerText);
                const children = parseInt(childCount.innerText);
                passengerCount.innerText = `${adults} Adult(s) · ${children} Child(ren)`;
            }

            function swapLocations() {
                const fromInput = document.getElementById('<%= txtFrom.ClientID %>');
                const toInput = document.getElementById('<%= txtTo.ClientID %>');
                const temp = fromInput.value;
                fromInput.value = toInput.value;
                toInput.value = temp;
            }


            document.addEventListener("DOMContentLoaded", () => {
                const tickets = [
                    {
                        popupId: "popup1",
                        containerId: "seats1",
                        movieId: "movie1",
                        countId: "count1",
                        totalId: "total1",
                        submitBtnId: "submit1",
                    },
                    {
                        popupId: "popup2",
                        containerId: "seats2",
                        movieId: "movie2",
                        countId: "count2",
                        totalId: "total2",
                        submitBtnId: "submit2",
                    },
                    {
                        popupId: "popup3",
                        containerId: "seats3",
                        movieId: "movie3",
                        countId: "count3",
                        totalId: "total3",
                        submitBtnId: "submit3",
                    },
                    {
                        popupId: "popup4",
                        containerId: "seats4",
                        movieId: "movie4",
                        countId: "count4",
                        totalId: "total4",
                        submitBtnId: "submit4",
                    },
                    {
                        popupId: "popup5",
                        containerId: "seats5",
                        movieId: "movie5",
                        countId: "count5",
                        totalId: "total5",
                        submitBtnId: "submit5",
                    },
                ];

                tickets.forEach(({ popupId, containerId, movieId, countId, totalId, submitBtnId }) => {
                    const popup = document.getElementById(popupId);
                    const overlay = popup.querySelector(".overlay");
                    const closeBtn = popup.querySelector(".close-btn");
                    const container = document.getElementById(containerId);
                    const movie = document.getElementById(movieId);
                    const count = document.getElementById(countId);
                    const total = document.getElementById(totalId);
                    const submitButton = document.getElementById(submitBtnId);

                    let selectedSeats = [];

                    // Open popup
                    document.getElementById(`open-${popupId}`).addEventListener("click", () => {
                        popup.classList.add("active");
                    });

                    // Close popup
                    popup.querySelector(".close-btn").addEventListener("click", () => {
                        popup.classList.remove("active");
                    });


                    // Handle seat selection
                    container.addEventListener("click", (e) => {
                        const seat = e.target;
                        if (seat.classList.contains("seat") && !seat.classList.contains("sold")) {
                            seat.classList.toggle("selected");

                            const seatId = seat.getAttribute("data-id");
                            if (seat.classList.contains("selected")) {
                                selectedSeats.push(seatId);
                            } else {
                                selectedSeats = selectedSeats.filter((id) => id !== seatId);
                            }

                            updateCountAndTotal();
                        }
                    });

                    // Update count and total price
                    function updateCountAndTotal() {
                        const selectedSeatsCount = selectedSeats.length;
                        const ticketPrice = movie.value;

                        count.innerText = selectedSeatsCount;
                        total.innerText = (selectedSeatsCount * ticketPrice).toFixed(2);
                    }

                    // Handle submit button
                    submitButton.addEventListener("click", () => {
                        if (selectedSeats.length === 0) {
                            alert("Please select at least one seat.");
                            return;
                        }

                        selectedSeats.forEach((seatId) => {
                            const seat = document.querySelector(`#${containerId} .seat[data-id="${seatId}"]`);
                            seat.classList.remove("selected");
                            seat.classList.add("sold");
                        });

                        selectedSeats = [];
                        updateCountAndTotal();
                        alert("Your seats have been reserved!");
                    });
                });
            });




            function validateDates() {
                const departureDate = document.getElementById("txtDepartureDate").value;
                const returnDate = document.getElementById("txtReturnDate");

                if (departureDate) {
                    // Convert departure date to a Date object
                    const departureDateObj = new Date(departureDate);

                    // Add one day to the departure date
                    const nextDay = new Date(departureDateObj);
                    nextDay.setDate(departureDateObj.getDate() + 1);

                    // Format the next day as YYYY-MM-DD
                    const nextDayFormatted = nextDay.toISOString().split("T")[0];

                    // Set the minimum return date to the next day
                    returnDate.min = nextDayFormatted;
                }
            }

        </script>

    </form>
</asp:Content>
