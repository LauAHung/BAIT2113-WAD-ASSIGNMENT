<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FlightFeedbackRate.aspx.cs" Inherits="Assignemnt_Draft_1.WebPage.FeedBack.FeedbackRate" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet' />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: rgb(255, 255, 255); /* Light background */
            color: #333; /* Dark text color for readability */
        }

        /* Container for the form */
        .feedback-container {
            max-width: 800px; /* Widened the form */
            margin: 50px auto; /* Added space between the top and bottom */
            background-color: rgba(255, 255, 255, 0.9); /* Slight white background for the form */
            padding: 2rem;
            border-radius: .75rem;
            box-shadow: 8px 8px 30px rgba(0, 0, 0, .1); /* Light shadow for a soft look */
            display: block;
        }

        p {
            text-align: left;
            color: black; /* Change to a dark color for better readability */
            font-size: 1.5rem; /* Increase font size */
            font-family: 'Arial', sans-serif; /* New font family for a cleaner look */
            font-weight : bold ;
        }

        .feedback-container h3 {
            font-size: 2rem; /* Made the title bigger */
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: #333; /* Dark text */
            font-family: 'Courier New', Courier;
            text-align: center;
            }
            /* Container for the feedback item */
    /* Container for the feedback item */
 
/* Feedback container layout */
.feedback-item {
    display: flex;
    justify-content: space-between;
    padding: 1.8rem;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: .5rem;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    width: 75%;
    margin: 1.5rem auto;
}

/* Avatar and Name Section (on the left) */
.feedback-header {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    width: 20%;
}

/* Avatar size and alignment */
.feedback-header .avatar {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 1rem;
}

/* Username styling under the avatar */
.feedback-header .username {
    font-weight: bold;
    margin-top: 0.5rem;
    font-size: 1.2rem;
    text-align: center;
}

/* Rating and Feedback Section (on the right) */
.feedback-rating {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
    margin-left: 2rem;
    paddinf-top : 2rem;

    width: 75%;
}


.feedback-rating span {
    font-size: 1.4rem;
    font-weight: bold;
    color: black; /* Set rating value text color to black */
}

/* Ensure feedback text wraps and doesn't exceed the container */
.feedback-text {
    font-size: 1.1rem;
    color: #555;
    line-height: 1.5;
    font-style: italic;
    width: 100%;
    text-align: left;
    margin-top: 0.5rem;
    word-wrap: break-word; /* Ensure the text wraps correctly */
    overflow-wrap: break-word; /* Ensures long words break if necessary */
}

/* Rating stars styling */
.feedback-rating img {
    width: 25px;
    height: 25px;
    margin-right: 0.5rem;
}


        /* Align image and name horizontally */
        .company-header {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .company-image {
            width: 160px; /* Increased the logo size */
            height: 80px; /* Increased the height */
            object-fit: contain; /* Keep the aspect ratio */
            margin-right: 1rem; /* Space between the image and the name */
        }

        .company-name {
            font-size: 2rem; /* Increased the font size of the name */
            color: #333; /* Dark text color for the company name */
            text-align: left;
            line-height: 80px; /* Match the height of the logo */
        }

        /* Rating stars */
        .rating {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1rem; /* Increased space between stars */
            font-size: 2rem; /* Increased star size */
            color: rgb(228, 176, 52); /* Yellow color for stars */
            margin-bottom: 2rem;
        }

            .rating .star {
                cursor: pointer;
                transition: transform 0.2s ease-in-out;
            }

                .rating .star:hover {
                    transform: scale(1.2); /* Slightly bigger on hover */
                }

                .rating .star.active {
                    animation: animate 0.5s ease-in-out forwards;
                    transform: scale(1.2); /* Slightly bigger active star */
                }

        textarea {
            width: 100%;
            background-color: rgba(0, 0, 0, 0.05); /* Light background for textarea */
            padding: 1rem;
            border: 1px solid #ccc; /* Light border */
            outline: none;
            resize: none;
            margin-bottom: .5rem;
            color: #333; /* Dark text */
            font-size: larger;
        }

        .btn-group {
            display: flex;
            gap: .5rem;
            justify-content: center;
        }

            .btn-group .btn {
                margin-top: 10px;
                padding: .8rem 2.5rem;
                border-radius: .5rem;
                border: none;
                cursor: pointer;
                font-size: .875rem;
                font-weight: 500;
            }

                .btn-group .btn.submit {
                    background: #007bff; /* Blue background */
                    color: white;
                }

                    .btn-group .btn.submit:hover {
                        background: #0056b3; /* Darker blue on hover */
                    }

                .btn-group .btn.cancel {
                    background: #f1f1f1; /* Light background */
                    color: #333;
                }

                    .btn-group .btn.cancel:hover {
                        background: #ccc; /* Slight darker background on hover */
                    }

        /* Modal and Overlay Styling */
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


        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 998;
        }

            .overlay.active {
                display: block;
            }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="feedback-container">
            <h3>Rate us!</h3>

            <!-- Company logo and name in a horizontal layout -->
            <div class="company-header">
                <img id="companyImage" class="company-image" src="<%: CompanyImageUrl %>" alt="<%: CompanyName %>" />
                <h4 class="company-name"><%: CompanyName %></h4>
            </div>

            <div class="rating" id="rating1">
                <input type="number" name="rating1" hidden>
                <i class='bx bx-star star' data-index="0"></i>
                <i class='bx bx-star star' data-index="1"></i>
                <i class='bx bx-star star' data-index="2"></i>
                <i class='bx bx-star star' data-index="3"></i>
                <i class='bx bx-star star' data-index="4"></i>
            </div>
            <p style="font-family: 'Courier New', Courier;">
                Rating: <span id="selected-rating">-</span> / 5
            </p>

            <textarea id="opinion" name="opinion" cols="30" rows="10" placeholder="Your opinion..."></textarea>
            <div class="btn-group">
                <asp:Button ID="submitBtn" runat="server" CssClass="btn submit" Text="Submit" OnClick="SubmitFeedback_Click" />
                <button type="button" class="btn cancel" id="cancelBtn">Cancel</button>
            </div>
        </div>
       
    <div style="display: flex; justify-content: space-between; align-items: center; margin-left: 220px;">
    <h3 style="margin: 0;">Feedback for this Company</h3>

    <div style="display: flex; gap: 20px;">
        <asp:Label 
            ID="lblTotalFeedback" 
            runat="server" 
            Text="Total Feedback: 0" 
            style="font-size: 16px; color: #333; font-weight: bold;" />

        <asp:Label 
            ID="lblAverageRating" 
            runat="server" 
            Text="Average Rating: 0" 
            style="font-size: 16px; color: #333; font-weight: bold; margin-right : 220px;" />
    </div>
</div>



        <asp:Repeater ID="rptFeedback" runat="server" OnItemCommand="rptFeedback_ItemCommand">

      


    <ItemTemplate>
        <div class="feedback-item">
            <!-- Avatar and Name Section (Left side) -->
            <div class="feedback-header">
               <img src='<%# ResolveUrl("~/AvatarHandler.ashx?userID=" + Eval("UserID")) %>' class="avatar" alt='<%# Eval("UserName") %>' />
                <div class="username"><%# Eval("UserName") %></div>
            </div>

            <!-- Rating and Feedback Section (Right side) -->
            <div  class="feedback-rating">
                <!-- Yellow star image and rating value -->
                <div class="rating" style="padding-top :25px;">
                    <img src="../../Images/staryellow.png" alt="Star" />
                    <span><%# Eval("RatingValue") %></span>
                </div>
                <!-- Feedback text -->
                <p class="feedback-text"><i>"<%# Eval("FeedbackText") %>"</i></p>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>


        <!-- Login Prompt Modal -->
        <div id="loginPromptModal" class="modal">
            <div class="modal-content">
                <h2>Please log in</h2>
                <p>You must log in to submit feedback.</p>
                <asp:Button ID="btnNavigateToLogin" runat="server" CssClass="action-link" Text="Log in" OnClick="btnNavigateToLogin_Click" />
            </div>
        </div>

        <div id="overlay" class="overlay"></div>

       <script>
           document.addEventListener('DOMContentLoaded', function () {
               const allStar = document.querySelectorAll('.rating .star');
               const ratingValue = document.querySelector('.rating input');
               const selectedRatingElement = document.getElementById('selected-rating');
               const opinionInput = document.getElementById('opinion');
               const submitBtn = document.getElementById('submitBtn');

               // 初始化星级评分功能
               handleStarClick(allStar, ratingValue, selectedRatingElement);

               // 点击提交按钮时执行验证
               submitBtn.addEventListener('click', function (e) {
                   e.preventDefault();
                   const isValid = validateForm(ratingValue, opinionInput);

                   if (isValid) {
                       checkLogin();
                   }
               });
           });

           function handleStarClick(stars, ratingValue, selectedRatingElement) {
               stars.forEach((item, idx) => {
                   item.addEventListener('click', function () {
                       ratingValue.value = idx + 1;
                       selectedRatingElement.textContent = ratingValue.value;

                       // 更新星级状态
                       stars.forEach(i => {
                           i.classList.remove('bxs-star', 'active');
                           i.classList.add('bx-star');
                       });
                       stars.forEach((i, index) => {
                           if (index <= idx) {
                               i.classList.replace('bx-star', 'bxs-star');
                               i.classList.add('active');
                           }
                       });
                   });
               });
           }

           function validateForm(ratingValue, opinionInput) {
               if (!ratingValue.value || ratingValue.value < 1 || ratingValue.value > 5) {
                   alert('请评分 (1-5)！');
                   return false;
               }
               if (!opinionInput.value.trim()) {
                   alert('请输入您的反馈！');
                   return false;
               }
               return true;
           }

           function checkLogin() {
               const isLoggedIn = '<%= Session["IsLoggedIn"] %>';
               if (isLoggedIn !== "true") {
                   document.getElementById('loginPromptModal').classList.add('active');
                   document.getElementById('overlay').classList.add('active');
               } else {
                   submitFeedback();
               }
           }

           function submitFeedback() {
               const rating = document.querySelector('.rating input').value;
               const feedbackText = document.getElementById('opinion').value;
               const companyID = '<%= Request.QueryString["company"] %>';
        const userID = '<%= Session["UserID"] %>';

               if (rating && feedbackText && companyID && userID) {
                   const formData = new FormData();
                   formData.append('rating', rating);
                   formData.append('feedbackText', feedbackText);
                   formData.append('companyID', companyID);
                   formData.append('userID', userID);

                   fetch('FeedbackSubmit.aspx', {
                       method: 'POST',
                       body: formData
                   })
                       .then(response => response.json())
                       .then(data => {
                           if (data.success) {
                               alert('反馈提交成功！');
                               location.reload(); // 重新加载页面
                           } else {
                               alert('提交反馈时出错。');
                           }
                       })
                       .catch(error => {
                           alert('网络请求失败，请稍后再试。');
                           console.error(error);
                       });
               }
           }
       </script>

    </form>
</asp:Content>
