# Flight Ticketing System

A web-based flight booking application built with ASP.NET Web Forms. This system allows users to search for flights, book tickets, and manage their user accounts, while administrators can manage flight schedules and system settings.

## 📋 Requirements

Before you begin, ensure you have the following installed:

*   **Visual Studio 2019 or 2022** (with "ASP.NET and web development" workload)
*   **.NET Framework 4.8**
*   **SQL Server Express LocalDB** (usually included with Visual Studio)

## 🚀 Installation & Setup

1.  **Clone or Download**:
    Download the project files to your local machine.

2.  **Open the Solution**:
    Navigate to the project directory and open the `.sln` file (e.g., `Assignemnt_Draft_1.sln`) with Visual Studio.

3.  **Restore Packages**:
    In Visual Studio, right-click on the **Solution** in the Solution Explorer and select **Restore NuGet Packages**.

4.  **Database Setup**:
    The application uses a local MDF file (`Database.mdf`) located in the `App_Data` folder. Ensure LocalDB is running. No complex SQL script execution is typically required as the file is attached dynamically via the connection string in `web.config`.

5.  **Build and Run**:
    *   Press `Ctrl + Shift + B` to build the solution.
    *   Press `F5` or click the **IIS Express** (Play) button to run the application in your browser.

---

## 📖 Step-by-Step Usage Guide

### 1. Register Account
To access the booking features, create a new user account.

*   **Navigate**: Click on **Register / Login** in the navigation bar.
*   **Action**: Select the "Register" tab or link.
*   **Test Credentials**:
    *   **Username**: `USER123`
    *   **Email Address**: `user@gmail.com`
    *   **Password**: `855sR6U!n7`
    *   **Confirm Password**: `855sR6U!n7`

### 2. Login Account
Access your account to book flights.

*   **Navigate**: Click on **Register / Login**.
*   **Action**: Enter your credentials.
*   **Test Credentials**:
    *   **Email Address**: `user@gmail.com`
    *   **Password**: `855sR6U!n7`

### 3. Admin Access
To view the admin dashboard (schedule management, reports, etc.).

*   **Navigate**: Log out if currently logged in. Go to the Login page.
*   **Test Credentials**:
    *   **Email Address**: `axinzenlhng@gmail.com`
    *   **Password**: `RedmiK30Pro!`

### 4. Search Flight
Once logged in as a user, you can search for available flights.

#### Scenario A: Return Flight (Round Trip)
*   **Depart Location**: `KL International Airport T1`
*   **Return Location**: `Penang International Airport`
*   **Depart Date**: `6/6/2026`
*   **Return Date**: `6/6/2026`
*   **Passenger**: `1`
*   **Action**: Click **Search** to view results.

#### Scenario B: One Way Flight
*   **Depart Location**: `KL International Airport T1`
*   **Return Location**: `Penang International Airport`
*   **Depart Date**: `6/6/2026`
*   **Passenger**: `1`
*   **Action**: Select "One Way" toggle/checkbox and click **Search**.

## 🛠 Troubleshooting

*   **Database Error**: If you see a database connection error, verify that "SQL Server Express LocalDB" is installed and that the `DataDirectory` substitution string in `web.config` matches your project structure.
*   **Build Errors**: Ensure all NuGet packages are fully restored and that you are targeting .NET Framework 4.8.
