<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TrainTicket.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.WebForm1" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap');

        .carousel {
            width: 100%;
            height: 450px;
        }

        .suggestions {
            border: 1px solid #ddd;
            max-height: 200px;
            overflow-y: auto;
            position: absolute;
            background-color: #fff;
            z-index: 1000;
            margin-top: 62px;
            border-radius: 5px;
            border-color: black;
        }

        .suggestion-item {
            padding: 10px;
            cursor: pointer;
        }

            .suggestion-item:hover {
                background-color: #f0f0f0;
            }

        .carousel-item {
            width: 100%;
            height: 100%;
        }

            .carousel-item img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                filter: brightness(45%);
            }


        .carousel-text {
            position: absolute;
            top: 30%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 2.5rem;
            font-family: 'Montserrat', sans-serif;
            font-weight: bold;
            text-align: center;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7);
            z-index: 10;
        }

        /*FTrain Search bar*/
        .search-bar {
            position: absolute;
            top: 400px;
            left: 50%;
            transform: translateX(-50%);
            width: 65%;
            background: #ffffff;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            padding: 20px;
            z-index: 5;
        }

        .search-bar-container ul {
            display: flex;
            margin: 0;
            padding: 0;
            list-style-type: none;
            justify-content: space-around;
            background: #f8f8f8;
            border-radius: 5px;
            padding: 10px 0;
            margin-bottom: 20px;
        }

            .search-bar-container ul li button {
                background: transparent;
                border: none;
                font-weight: bold;
                padding: 10px 20px;
                cursor: pointer;
            }

        .search-options {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

            .search-options input,
            .search-options .search-btn {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .search-options .search-btn {
                background: #d32f2f;
                color: #fff;
                font-weight: bold;
                cursor: pointer;
                transition: background 0.3s;
            }

                .search-options .search-btn:hover {
                    background: #b71c1c;
                }


        h1 {
            font-family: "Open Sans", sans-serif;
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 10px;
        }

        .title-underline {
            border: 2px solid #a00000;
            width: 150px;
            margin: 5px 0 20px;
        }

        .passenger-info {
            font-family: "Open Sans", sans-serif;
            font-size: 1rem;
            color: #333;
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .dropdown-arrow {
            cursor: pointer;
        }

        .itinerary-form {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* Four equal columns */
            gap: 15px; /* Add space between the fields */
            margin-bottom: 20px;
        }



        .form-group {
            display: flex;
            flex-direction: column;
            font-family: "Open Sans", sans-serif;
        }


        label {
            font-size: 0.85rem;
            color: #333;
            margin-bottom: 5px;
        }

        .input-wrapper {
            position: relative;
        }

        input[type="text"],
        input[type="date"] {
            width: 90%; /* Full width of the parent */
            padding: 8px; /* Adjusted padding for a compact look */
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 0.9rem;
        }

        .calendar-icon {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            font-size: 1rem;
            color: #a00000;
        }

        .calendar-icon {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            font-size: 1rem;
            color: #a00000;
        }

        .search-button {
            grid-column: span 2;
            padding: 10px 0;
            background-color: #a00000;
            color: white;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 4px;
            width: 200px;
            cursor: pointer;
            text-align: center;
        }

            .search-button:hover {
                background-color: #800000;
            }


        .exchange-icon {
            cursor: pointer;
            font-size: 1.5rem;
            color: #6A5ACD;
            position: absolute;
            margin-left: 230px;
            margin-top: 20px;
        }

            .exchange-icon:hover {
                color: #483D8B;
            }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-toggle {
            background-color: transparent;
            border: none;
            font-size: 1rem;
            cursor: pointer;
            font-family: 'Open Sans', sans-serif;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            background-color: white;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 15px;
            border-radius: 8px;
            z-index: 1000;
            width: 250px;
        }

        .dropdown-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .counter {
            display: flex;
            align-items: center;
            gap: 10px;
        }

            .counter button {
                background-color: #a00000;
                color: white;
                border: none;
                border-radius: 50%;
                width: 30px;
                height: 30px;
                font-size: 1.2rem;
                cursor: pointer;
            }

                .counter button:disabled {
                    background-color: #ccc;
                    cursor: not-allowed;
                }

        .dropdown-toggle:hover + .dropdown-menu,
        .dropdown-menu:hover {
            display: block;
        }

        small {
            font-size: 0.8rem;
            color: gray;
        }

        .steps-section {
            margin-top: 100px;
            text-align: center;
            padding: 40px 20px;
            background-color: #fff;
        }

            .steps-section h2 {
                font-size: 1.8rem;
                font-weight: bold;
                margin-bottom: 30px;
                color: #a00000;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

        /* Steps Container */
        .steps-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        /* Step Card Styles */
        .step-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 300px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }

            .step-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }

            /* Card Image */
            .step-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

        /* Step Content */
        .step-content {
            padding: 20px;
            text-align: center;
            background-color: #a00000;
            color: #fff;
        }

            .step-content h3 {
                font-size: 1.3rem;
                margin-bottom: 10px;
                font-weight: bold;
            }

            .step-content p {
                font-size: 0.9rem;
                line-height: 1.5;
            }

        .card-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 300px;
            position: relative;
            transition: transform 0.3s;
        }

            .card:hover {
                transform: scale(1.05);
            }

        .card-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .price-tag {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #ff4d4f;
            color: white;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .card-content {
            padding: 15px;
        }

            .card-content h3 {
                margin: 0 0 5px;
                font-size: 1.2em;
            }

        .subtitle {
            color: #888;
            font-size: 0.9em;
            margin-bottom: 10px;
        }

        .card-content p {
            margin: 5px 0;
            font-size: 0.9em;
        }

        .location-icon, .time-icon {
            margin-right: 5px;
        }
    </style>
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">


        <div class="carousel">
            <div class="carousel-item active">
                <img src="../../Images/train.jpg" />
                <div class="carousel-text">Train Tickets in Malaysia</div>
            </div>
        </div>


        <!-- Search Bar Section -->

        <div class="search-bar">
            <div class="search-bar-container">
                <h1>Select your itinerary</h1>
                <hr class="title-underline">
                <div class="passenger-info">
                    <div class="dropdown">
                        <button class="dropdown-toggle" id="passengerDropdown">
                            👤 <span id="passengerCount">6 Adult(s) · 7 Child(ren)</span> ▼
       
                       
                        </button>

                        <div class="dropdown-menu">
                            <asp:Button ID="dropdownButton" CssClass="passenger-dropdown-button" runat="server" Text="1 Passenger" OnClick="UpdateDropdownText" />
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

                <div class="itinerary-form">
                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
                    <div class="form-group">
                        <label for="txtFrom">From</label>
                        <asp:TextBox ID="txtFrom" runat="server" CssClass="input-wrapper" Placeholder="Where from?" onkeyup="fetchTrainFrom(this.value)"></asp:TextBox>
                        <div id="fromSuggestions" class="suggestions"></div>
                        <span class="exchange-icon" onclick="swapLocations()">&#8646;</span>
                    </div>

                    <div class="form-group">
                        <label for="txtTo">To</label>
                        <asp:TextBox ID="txtTo" runat="server" CssClass="input-wrapper" Placeholder="Where to?" onkeyup="fetchTrainTo(this.value)"></asp:TextBox>
                        <div id="toSuggestions" class="suggestions"></div>
                    </div>
                    <div class="form-group">
                        <div class="input-wrapper">
                            <label for="txtDepartDate">Departure Date</label>
                            <asp:TextBox ID="txtDepartDate" runat="server" TextMode="Date" />
                        </div>
                        <!--📅-->
                    </div>
                    <div class="form-group">
                        <label for="departure-date">&nbsp;</label>
                        <asp:Button ID="btnSubmit" runat="server" CssClass="search-button" Text="Search" PostBackUrl="~/WebPage/TrainBookingPage/TrainBookingPage.aspx" />
                    </div>
                </div>
            </div>
        </div>

        <section class="steps-section">
            <h2>🔴 Purchase your train tickets in Malaysia in 3 easy steps</h2>
            <div class="steps-container">
                <div class="step-card">

                    <img src="../../Images/Planning_pic.png" />
                    <div class="step-content">
                        <h3>Plan your route</h3>
                        <p>Reserve your train tickets online, to and from major cities in Japan, to fit your itinerary!</p>
                    </div>
                </div>
                <div class="step-card">
                    <img src="../../Images/qr_code.jpg" />
                    <div class="step-content">
                        <h3>Get your QR code</h3>
                        <p>Receive your QR code by e-mail or SMS, which you will use to exchange your train tickets.</p>
                    </div>
                </div>
                <div class="step-card">
                    <img src="../../Images/suria-klcc_wide.jpg" />
                    <div class="step-content">
                        <h3>Explore Malaysia</h3>
                        <p>Ride the ETS to experience the iconic bullet train as well as Japan's express trains, and more!</p>
                    </div>
                </div>

            </div>
        </section>

        <div class="card-container">
            <!-- Card 1 -->
            <div class="card">
                <img src="../../images/shanghai.jpg" alt="Shenzhen to Shanghai" class="card-image">
                <div class="price-tag">$119.60</div>
                <div class="card-content">
                    <h3>Train Tickets from Shenzhen to Shanghai</h3>
                    <p class="subtitle">Train Tickets in China</p>
                    <p><i class="location-icon">📍</i> ShenZhen › ShangHai</p>
                    <p>
                        <i class="time-icon">⏱️</i> 9h43mins
                        <br>
                        06:40 -> 21:24
                    </p>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="card">
                <img src="../../images/busan.jpg" alt="Seoul to Busan" class="card-image">
                <div class="price-tag">$43.43</div>
                <div class="card-content">
                    <h3>Train Tickets from Seoul to Busan</h3>
                    <p class="subtitle">Train Tickets in South Korea</p>
                    <p><i class="location-icon">📍</i> Seoul › Busan</p>
                    <p>
                        <i class="time-icon">⏱️</i> 2h43mins
                        <br>
                        14:28 / 17:11
                    </p>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="card">
                <img src="../../images/berlin.jpg" alt="Munich to Berlin" class="card-image">
                <div class="price-tag">$163.92</div>
                <div class="card-content">
                    <h3>Train Tickets from Munich to Berlin</h3>
                    <p class="subtitle">Train Tickets in Germany</p>
                    <p><i class="location-icon">📍</i> Munich › Berlin</p>
                    <p>
                        <i class="time-icon">⏱️</i> 4h5mins
                        <br>
                        06:52 / 10:57
                    </p>
                </div>
            </div>
        </div>






        <script>
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

            function fetchTrainFrom(query) {
                if (query.length < 2) {
                    document.getElementById("fromSuggestions").innerHTML = "";
                    return;
                }

                $.ajax({
                    url: "TrainTicket.aspx/GetTrains",
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
                    url: "TrainTicket.aspx/GetTrains",
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
        </script>

        <script>
            async function fetchTrainData() {
                // Replace with the actual endpoint to fetch data
                const response = await fetch('http://localhost:5000/api/trainno');
                const trainData = await response.json();

                const container = document.getElementById('train-container');

                trainData.forEach(train => {
                    const trainCard = document.createElement('div');
                    trainCard.classList.add('train-card');

                    trainCard.innerHTML = `
                    <img src="${train.TrainIconPath}" alt="Train Icon">
                    <div class="train-details">
                        <h3>${train.Company}</h3>
                        <p>${new Date(train.departDateTime).toLocaleTimeString()} → ${new Date(train.arriveDateTime).toLocaleTimeString()}</p>
                        <p>${train.Route}</p>
                        <p>${train.duration} minutes, ${train.trainStatus}</p>
                    </div>
                    <div class="price">RM ${train.price.toFixed(2)}</div>
                `;

                    container.appendChild(trainCard);
                });
            }

            fetchTrainData();
    </script>

        <script>
            function swapLocations() {
                const fromInput = document.getElementById('<%= txtFrom.ClientID %>');
                const toInput = document.getElementById('<%= txtTo.ClientID %>');
                const temp = fromInput.value;
                fromInput.value = toInput.value;
                toInput.value = temp;
            }
        </script>
    </form>
</asp:Content>
