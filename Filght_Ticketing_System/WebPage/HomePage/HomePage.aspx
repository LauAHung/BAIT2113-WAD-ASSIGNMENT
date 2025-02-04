<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.HomePage2" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="HomePage.css">
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <main>

            <section>
                <div class="custom-animation customAnimatedFadeInUp customFadeInUp">
                    <h1 class="maintext">Search & Book Flights</h1>
                    <p class="mainp">Book and Flight Now !</p>
                </div>

                <div class="config-select round">
                    <div class="fieldset md-whiteframe-z1">
                        <asp:RadioButton ID="RadioButton1" runat="server" GroupName="config_a" CssClass="radio-option" Checked="true" onclick="handleFlightTypeChange()" />
                        <label for="<%= RadioButton1.ClientID %>">Return</label>

                        <asp:RadioButton ID="RadioButton2" runat="server" GroupName="config_a" CssClass="radio-option" onclick="handleFlightTypeChange()" />
                        <label for="<%= RadioButton2.ClientID %>">One Way</label>

                        <span class="switch md-whiteframe-z1"></span>
                    </div>
                </div>


                <div class="search-bar">
                    <div class="input-row">
                        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
                        <div class="input-group">
                            <label for="txtFrom">Depart Location</label>
                            <asp:TextBox ID="txtFrom" runat="server" CssClass="input" Placeholder="Where from?" onkeyup="fetchAirportsFrom(this.value)" />
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
                            <asp:TextBox ID="txtDepartureDate" runat="server" CssClass="input" TextMode="Date" />
                        </div>

                        <div class="input-group hidden" id="one-way-date">
                            <label for="txtOneWayDate">Return Date</label>
                            <asp:TextBox ID="txtOneWayDate" runat="server" CssClass="input" TextMode="Date" />
                        </div>

                        <div class="passenger-class-group">
                            <asp:Label runat="server" Text="Passengers "></asp:Label>
                            <div class="passenger-dropdown">
                                <asp:Button ID="dropdownButton" CssClass="passenger-dropdown-button" runat="server" Text="1 Passenger, Economy" OnClick="UpdateDropdownText" />
                                <div class="passenger-dropdown-content">
                                    <div class="passenger-dropdown-item">
                                        <asp:Label runat="server" Text="Adults (12+)"></asp:Label>
                                        <div class="passenger-counter">
                                            <asp:Button ID="adultDecrement" CssClass="passenger-counter-btn" runat="server" Text="-" OnClick="DecrementAdult" CausesValidation="false" />
                                            <asp:Label ID="adultCounter" CssClass="passenger-counter-value" runat="server" Text="1"></asp:Label>
                                            <asp:Button ID="adultIncrement" CssClass="passenger-counter-btn" runat="server" Text="+" OnClick="IncrementAdult" CausesValidation="false" />
                                        </div>
                                    </div>
                                    <div class="passenger-dropdown-item">
                                        <asp:Label runat="server" Text="Children (2-11)"></asp:Label>
                                        <div class="passenger-counter">
                                            <asp:Button ID="childDecrement" CssClass="passenger-counter-btn" runat="server" Text="-" OnClick="DecrementChild" CausesValidation="false" />
                                            <asp:Label ID="childCounter" CssClass="passenger-counter-value" runat="server" Text="0"></asp:Label>
                                            <asp:Button ID="childIncrement" CssClass="passenger-counter-btn" runat="server" Text="+" OnClick="IncrementChild" CausesValidation="false" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" CausesValidation="false" />

                </div>
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error-message" Font-Underline="False" Font-Bold="True" BackColor="Maroon"></asp:Label>


                <aside>
                    <video autoplay="autoplay" muted="muted" loop="loop">
                        <source src="../../Images/HomePageVideo.mp4" />
                    </video>
                </aside>


            </section>


            <section>
                <div class="slider">
                    <!-- list Items -->
                    <div class="list">
                        <div class="item active">
                            <img src="../../Images/Penang_Hill.jpg" />
                            <div class="content">
                                <p>Penang, Malaysia</p>
                                <h2>The Enchanted Heights of Penang</h2>
                                <p>
                                    Perched amidst lush rainforest and offering breathtaking vistas of the island, Penang Hill is a serene retreat where nature, heritage, and tranquility converge.
                                </p>
                            </div>
                        </div>
                        <div class="item">
                            <img src="../../Images/Singapore.jpeg" />
                            <div class="content">
                                <p>Singapore</p>
                                <h2>The Radiant Jewel of Asia</h2>
                                <p>
                                    A harmonious blend of futuristic skyscrapers, verdant gardens, and rich cultural heritage, Singapore is a vibrant city-state where innovation meets timeless tradition.
                                </p>
                            </div>
                        </div>
                        <div class="item">
                            <img src="../../Images/Thailand.jpeg" />
                            <div class="content">
                                <p>BANGKOK, Thailand</p>
                                <h2>The Land of Smiles and Splendor</h2>
                                <p>
                                    Thailand enchants with its golden temples, pristine beaches, and warm hospitality, offering a perfect harmony of cultural richness and natural beauty.
                                </p>
                            </div>
                        </div>
                        <div class="item">
                            <img src="../../Images/china.jpg" />
                            <div class="content">
                                <p>YUNNAN, China</p>
                                <h2>The Timeless Heart of Asia</h2>
                                <p>
                                    A vast land of ancient wonders, dynamic cities, and diverse landscapes, China is a living tapestry of history, culture, and modern marvels.
                                </p>
                            </div>
                        </div>
                        <div class="item">
                            <img src="../../Images/japan.jpg" />
                            <div class="content">
                                <p>Osaka, Japan</p>
                                <h2>The Eternal Land of the Rising Sun</h2>
                                <p>
                                    Japan captivates with its seamless blend of ancient traditions, cutting-edge innovation, and breathtaking natural landscapes, creating an unparalleled cultural journey.
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- button arrows -->
                    <div class="arrows">
                        <button id="prev"><</button>
                        <button id="next">></button>
                    </div>
                    <!-- thumbnail -->
                    <div class="thumbnail">
                        <div class="item active">
                            <img src="../../Images/Penang_Hill.jpg" />
                            <div class="content">
                            </div>
                        </div>
                        <div class="item">
                            <img src="../../Images/Singapore.jpeg" />
                            <div class="content">
                            </div>
                        </div>
                        <div class="item">
                            <img src="../../Images/Thailand.jpeg" />
                            <div class="content">
                            </div>
                        </div>
                        <div class="item">
                            <img src="../../Images/china.jpg" />
                            <div class="content">
                            </div>
                        </div>
                        <div class="item">
                            <img src="../../Images/japan.jpg" />
                            <div class="content">
                            </div>
                        </div>
                    </div>
                </div>
            </section>


            <section>
                <div class="subscription-container">
                    <div class="subscription-content">
                        <h2>Never miss an offer</h2>
                        <p>Subscribe and be the first to receive our exclusive offers.</p>


                        <!-- Email TextBox -->
                        <asp:TextBox ID="txtEmail" CssClass="form-input" placeholder="Email address" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="error-msg" runat="server"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmail" ControlToValidate="txtEmail"
                            ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$" ErrorMessage="Invalid email format." CssClass="error-msg" runat="server"></asp:RegularExpressionValidator>

                        <!-- City TextBox -->
                        <asp:TextBox ID="txtCity" CssClass="form-input" placeholder="Preferred city of departure" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCity" ControlToValidate="txtCity" ErrorMessage="City is required." CssClass="error-msg" runat="server"></asp:RequiredFieldValidator>

                        <div class="checkbox-container">
                            <!-- Checkbox -->
                            <div class="checkbox-container">
                                <asp:CheckBox ID="chkConsent" runat="server" />
                                <label for="chkConsent">
                                    I would like to get offers and news from TRAVEL FREE.
                                </label>
                                <asp:CustomValidator ID="cvConsent" runat="server"
                                    ErrorMessage="You must agree to receive offers and news."
                                    OnServerValidate="cvConsent_ServerValidate"
                                    Display="Dynamic" />
                            </div>
                        </div>
                        <asp:Button ID="btnSubscribe" CssClass="btn-subscribe" Text="Subscribe" OnClick="btnSubscribe_Click" runat="server" />
                    </div>
                </div>
            </section>
        </main>

        <script>

            $(document).ready(function () {
                function updateSwitchPosition() {
                    const $radios = $('input[type=radio]');
                    const $labels = $('.fieldset label');
                    const $switch = $('.switch');

                    $radios.each(function (index) {
                        if ($(this).is(':checked')) {
                            const offset = index * 90;
                            $switch.css('transform', `translateX(${offset}px)`);

                            $labels.removeClass('selected');
                            $labels.eq(index).addClass('selected');
                        }
                    });
                }

                $('input[type=radio]').on('change', updateSwitchPosition);
                updateSwitchPosition();
            });

            function fetchAirportsFrom(query) {
                if (query.length < 2) {
                    document.getElementById("suggestionsFrom").innerHTML = "";
                    return;
                }

                $.ajax({
                    url: "HomePage.aspx/GetAirports",
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
                    url: "HomePage.aspx/GetAirports",
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


            const body = document.body;
            const header = document.querySelector('header');
            const links = header.querySelectorAll('a');
            const main = document.querySelector('main');
            const sections = main.querySelectorAll('section');
            const video = sections[0].querySelector('video');


            let ticking = false;
            let stickyHeight = header.offsetHeight + 'px';

            function handleScroll() {
                if (!ticking) {
                    requestAnimationFrame(() => {
                        const isVideoVisible = body.scrollTop < video.offsetTop + video.offsetHeight;
                        isVideoVisible ? video.play() : video.pause();

                        const isSticking = body.scrollTop > header.offsetHeight;
                        header.classList.toggle('sticking', isSticking);

                        ticking = false;
                    });
                    ticking = true;
                }
            }

            body.addEventListener('scroll', handleScroll);

            const navAnimate = document.querySelector('.nav-animate');

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

            sections.forEach(section => {
                section.style.paddingTop = `calc(${stickyHeight} + 1em)`;
            });

            function toggleDateFields(option) {
                const returnDates = document.getElementById('return-dates');
                const oneWayDate = document.getElementById('one-way-date');

                if (option === 'return') {
                    returnDates.classList.remove('hidden');
                    oneWayDate.classList.add('hidden');
                } else {
                    returnDates.classList.add('hidden');
                    oneWayDate.classList.remove('hidden');
                }
            }


            function toggleDateFields(option) {
                var buttons = document.querySelectorAll('.options .option');
                buttons.forEach(function (button) {
                    button.classList.remove('active');
                });

                var selectedButton = document.getElementById('btn' + option.charAt(0).toUpperCase() + option.slice(1));
                selectedButton.classList.add('active');
            }

            let items = document.querySelectorAll('.slider .list .item');
            let next = document.getElementById('next');
            let prev = document.getElementById('prev');
            let thumbnails = document.querySelectorAll('.thumbnail .item');

            let countItem = items.length;
            let itemActive = 0;
            next.onclick = function () {
                itemActive = itemActive + 1;
                if (itemActive >= countItem) {
                    itemActive = 0;
                }
                showSlider();
            }
            prev.onclick = function () {
                itemActive = itemActive - 1;
                if (itemActive < 0) {
                    itemActive = countItem - 1;
                }
                showSlider();
            }

            function showSlider() {
                let itemActiveOld = document.querySelector('.slider .list .item.active');
                let thumbnailActiveOld = document.querySelector('.thumbnail .item.active');
                itemActiveOld.classList.remove('active');
                thumbnailActiveOld.classList.remove('active');

                items[itemActive].classList.add('active');
                thumbnails[itemActive].classList.add('active');

            }

            thumbnails.forEach((thumbnail, index) => {
                thumbnail.addEventListener('click', () => {
                    itemActive = index;
                    showSlider();
                })
            })

            function swapLocations() {
                const fromInput = document.getElementById('<%= txtFrom.ClientID %>');
                const toInput = document.getElementById('<%= txtTo.ClientID %>');
                const temp = fromInput.value;
                fromInput.value = toInput.value;
                toInput.value = temp;
            }

            function handleFlightTypeChange() {
                const isOneWay = document.getElementById('<%= RadioButton2.ClientID %>').checked;
                const returnDateInput = document.getElementById('<%= txtOneWayDate.ClientID %>');

                if (isOneWay) {
                    returnDateInput.setAttribute('readonly', 'readonly');
                    returnDateInput.style.backgroundColor = '#d3d3d3';
                    returnDateInput.value = '';
                } else {
                    returnDateInput.removeAttribute('readonly');
                    returnDateInput.style.backgroundColor = '';
                }
            }

            document.addEventListener('DOMContentLoaded', handleFlightTypeChange);

            function validateDates() {
                const departDateInput = document.getElementById('<%= txtDepartureDate.ClientID %>');
                const returnDateInput = document.getElementById('<%= txtOneWayDate.ClientID %>');
                const today = new Date().toISOString().split('T')[0];

                departDateInput.setAttribute('min', today);

                departDateInput.addEventListener('change', function () {
                    const departDate = departDateInput.value;
                    returnDateInput.setAttribute('min', departDate);
                });
            }

            document.addEventListener('DOMContentLoaded', function () {
                handleFlightTypeChange();
                validateDates();
            });

            function displayUnsuccessfulSubscribePopup() {
                const blurBackground = document.createElement('div');
                blurBackground.className = 'blur-background';
                document.body.appendChild(blurBackground);

                const popupMessage = document.createElement('div');
                popupMessage.className = 'popup-message';
                popupMessage.innerHTML = `
    <div class="popup-content">
        <img src="../../Images/failed.gif" width="200px">
        <h2>Subscribe Unsuccessful</h2>
        <p>Your subscription could not be processed. Please try again.</p>
        <button class="payment_done" onclick="location.reload()">Refresh</button>
    </div>
`;
                document.body.appendChild(popupMessage);
            }

            function displaySuccessfulSubscribePopup() {
                const blurBackground = document.createElement('div');
                blurBackground.className = 'blur-background';
                document.body.appendChild(blurBackground);

                const popupMessage = document.createElement('div');
                popupMessage.className = 'popup-message';
                popupMessage.innerHTML = `
    <div class="popup-content">
        <img src="../../Images/success.gif" width="200px">
        <h2>Subscribe Successful</h2>
        <p>You will receive the email soon.</p>
    </div>
`;
                playSuccessSound();
                document.body.appendChild(popupMessage);


                setTimeout(function () {
                    document.body.removeChild(blurBackground);
                    document.body.removeChild(popupMessage);
                }, 3000);
            }

            function playSuccessSound() {
                var audio = new Audio("../../Sounds/success.mp3");
                audio.play();
            }

            function validateCheckbox(sender, args) {
                var chkConsent = document.getElementById('<%= chkConsent.ClientID %>');
                args.IsValid = chkConsent.checked;
            }

        </script>
    </form>
</asp:Content>
