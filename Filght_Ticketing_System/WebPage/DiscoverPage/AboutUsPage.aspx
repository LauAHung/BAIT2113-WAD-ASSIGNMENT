<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AboutUsPage.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.DiscoverPage.AboutUsPage" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        @import url("https://fonts.cdnfonts.com/css/gotham");

        /*Nav*/
        html,
        body {
            width: 100%;
            height: 100%;
            font-family: "Gotham", sans-serif;
        }


        /*Body*/
        body {
            height: 100%;
            margin: 0;
            background-size: cover;
            color: black;
        }

            /*Article*/
            .pright,
            .pleft {
                text-align: justify;
                box-sizing: border-box;
                margin: 5%;
                margin-top: 0%;
                margin-bottom: 7%;
                font-size: 20px;
            }

                pright > p > strong > i,
                pleft > p > strong > i {
                    font-size: 24px;
                }

                .pright > p > i,
                .pleft > p > i {
                    color: rgba(234, 58, 58, 0.9);
                }

        /*heading*/
        h1 {
            text-align: center;
            font-size: 48px;
            margin: 5%;
            margin-bottom: 8%;
            text-decoration: underline 5px rgba(255, 235, 59, 0.8);
        }

        h2 {
            font-size: 30px;
        }

        .hleft{
            margin-left: 5%;
        }

        /*img*/
        .picture_left {
            width: 40%;
            margin: 5%;
            margin-top: 10%;
            float: left;
            box-sizing: border-box;
        }

        .picture_right {
            width: 40%;
            margin: 5%;
            margin-top: 10%;
            float: right !important;
            box-sizing: border-box;
        }

        /*Location*/
        body > div > div.location,
        body > div > div.contact {
            box-sizing: border-box;
            margin: 5%;
        }

            body > div > div.location > h1,
            body > div > div.contact > h1 {
                margin-bottom: 5%;
            }

            body > div > div.location > p {
                text-align: left;
                margin-left: 55%;
                margin-top: 5%;
                font-size: 36px;
                text-decoration: underline 3px rgba(234, 58, 58, 0.9);
            }

            body > div > div.location > article {
                margin-left: 55%;
                margin-top: 0%;
                font-size: 20px;
                text-align: justify;
            }

            body > div > div.location > div.button {
                margin-left: 58%;
                background-color: black;
                margin-top: 4%;
                border-radius: 50px;
                margin-left: 70%;
                margin-right: 15%;
                text-align: center;
            }

                body > div > div.location > div.button:hover {
                    background-color: red;
                    transition: 0.3s;
                    box-shadow: black;
                    box-shadow: 2px 5px 8px rgba(0, 0, 0, 0.7);
                }

                body > div > div.location > div.button > div > a {
                    font-size: 36px;
                    font-weight: bold;
                    font-style: italic;
                    color: white;
                    text-decoration: none;
                }

            /*iframe*/
            body > div > div.location > iframe {
                float: left;
            }

        /*contact*/
        @media only screen and (min-width: 641px) {
            body > div > div.contact > p {
                -moz-column-count: 2;
                -webkit-column-count: 2;
                column-count: 2;
                -moz-column-gap: 20px;
                -webkit-column-gap: 20px;
                column-gap: 100px;
                -moz-column-rule: 3px solid black;
                -webkit-column-rule: 3px solid black;
                column-rule: 3px solid black;
            }
        }

        body > div > div.contact > p > a {
            color: blue;
            text-decoration: underline;
        }

            body > div > div.contact > p > a:hover {
                color: red;
                text-decoration: underline;
            }

        body > div > div.contact > hr {
            border: none;
            border-top: 5px black solid;
        }

        /*faq*/
        body > div > div.faq > div.question {
            border: none;
            margin-left: 10%;
            margin-right: 10%;
            border-radius: 10px;
            box-shadow: 2px 5px 8px rgba(0, 0, 0, 0.7);
            align-items: center;
            cursor: pointer;
            color: rgb(153, 151, 151);
        }

            body > div > div.faq > div.question > button.arrow-btn {
                color: rgb(64,64,64);
                border: none;
                background: none;
                font-size: 20px;
                margin-right: 10px;
                cursor: pointer;
                transition: transform 0.3s ease; /* Add transition for smooth rotation */
            }

        /* Rotate arrow when answer is displayed */
        .open .arrow-btn {
            transform: rotate(90deg);
        }

        .answer {
            overflow: hidden; /* Hide overflowing content */
            max-height: 0; /* Initially hidden */
            transition: max-height 0.5s ease; /* Add transition for smooth height change */
        }

            .answer.open {
                max-height: 500px; /* Adjust the max-height to fit the content */
            }

        body > div > div.faq > div.question > button {
            margin-left: 5%;
        }

        body > div > div.faq > div.question > p {
            padding: 5px;
            display: inline-block;
            font-size: 20px;
        }

        body > div > div.faq > div.answer {
            margin-left: 17.8%;
            margin-right: 15%;
            border: inherit;
            border-radius: 10px;
            font-variant: small-caps;
            font-size: 24px;
            font-family: "Sedan SC", serif;
            font-weight: 400;
            font-style: normal;
        }

            body > div > div.faq > div.answer > p > strong {
                background-color: rgba(255, 255, 0, 0.5);
            }

            .whoweare{
                text-align:center;
            }
    </style>
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <article>
        <h1>About Us</h1>
        <div class="picture_left">
            <img src="../../Images/Travel_Logo.svg" alt="Logo " />
        </div>
        <h2 class="whoweare">Who We Are?</h2>
        <div class="pright">
            <p>
                TRAVERFREE, founded in 2020, is an innovative flight ticket booking website designed with a user-friendly interface to provide a seamless experience for travelers. The platform offers a simple and efficient way to search, compare, and book flight tickets to destinations worldwide. 
        <br />
                <br />
                TRAVERFREE prioritizes user security by implementing advanced encryption techniques to protect sensitive user information, ensuring a safe and trustworthy booking experience for every traveler. With its modern design and commitment to security, TRAVERFREE has quickly become a trusted choice for booking flights online.
        <br />
                <br />
                Additionally, we prioritize <i>excellent customer service</i> to establish strong relationships with our
        clientele, understand their needs, and offer personalized recommendations.
            </p>
        </div>

        <div class="picture_right">
            <img src="../../Images/target.png" />
        </div>
        <div class="hleft">
            <h2>Mission</h2>
        </div>
        <div class="pleft">
            <p>
                At the core of our organization lies a commitment to serving individuals seeking to purchase a car. Our goal is
        to match each customer with the <i>most suitable vehicle</i>, ensuring their satisfaction with their purchase.
            </p>
            <br />
            <br />
            <div class="hleft">
                <h2>Vision</h2>
            </div>
            <p>
                Moreover, our product offerings extend beyond cars to include a range of car accessories, further <i>enhancing
          the lives</i> of our customers and communities worldwide. Maintaining unwavering dedication to customer
        satisfaction remains our long-term objective.
            </p>
            <br />
            <br />
            <div class="hleft">
                <h2>Achievements</h2>
            </div>
            <p>
                <strong><i>TRAVELFREE</i></strong> has successfully sold numerous types of cars, including Tesla, Xiaomi, Toyota
        and Honda. In 2022, our annual sales reached around <i>800 cars</i>, accompanied by an influx of <i>positive
          reviews and feedback</i> from satisfied customers. These achievements validate our commitment to delivering
        exceptional products and services.
            </p>
        </div>

        <div class="picture_left">
            <img src="../../Images/stakeholder.png" />
        </div>
        <h2 style="margin-left: 60%;">Stakeholder</h2>
        <div class="pright" style="margin-left: 60%;">
            <p>
                Our organization's stakeholders primarily consist of <i>customers</i> and <i>suppliers</i>.
        <strong><i>Customers</i></strong>, whether individuals or businesses, play a pivotal role in our operations, as
        they purchase vehicles and influence industry demand. We prioritize meeting their expectations regarding car
        quality, pricing, and service. Similarly, <strong><i>suppliers</i></strong> are integral to our business,
        providing essential parts, accessories, and services to ensure the smooth operation of our dealership.
            </p>
        </div>

        <h2 style="margin-left: 60%;">Future plans</h2>
        <div class="pright" style="margin-left: 60%;">
            <p>
                Looking ahead, <strong><i>CarVista</i></strong> aims to expand its product offerings beyond the current
        selection of Tesla, Xiaomi, and Toyota vehicles. By enhancing our customer service to be more <i>personalized
          and empathetic</i>, we anticipate attracting a broader customer base seeking the <i>best car-buying
          experience</i>. Our future endeavors are rooted in our commitment to continuous improvement and providing
        unparalleled service in the <strong><i>automotive industry</i></strong>.
            </p>
        </div>
    </article>

    <script>
        function toggleAnswer(button) {
            var answer = button.parentNode.nextElementSibling;
            var isOpen = answer.classList.contains('open');
            if (isOpen) {
                answer.classList.remove('open');
                setTimeout(function () {
                    answer.style.display = 'none';
                }, 500);
                // Adjust the timing to match the CSS transition duration
            }

            else {
                answer.style.display = 'block';
                setTimeout(function () {
                    answer.classList.add('open');
                }, 10);
                // Delay to ensure display is set before sliding down
            }

            button.parentNode.classList.toggle('open'); // Toggle 'open' class on parent
        }
    </script>
</asp:Content>
