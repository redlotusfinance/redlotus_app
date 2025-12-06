# RedFin - Flutter Web App Blueprint

## Overview

This document outlines the plan and progress for creating "RedFin," a modern fintech web application. The application will help users find suitable banks for loans based on their financial profile, featuring a responsive Flutter web frontend and a Node.js backend.

## Style, Design, and Features

### Key Features
1.  **Multi-Step User Form:** Completed.
2.  **Bank Matching & Ranking:** Completed.
3.  **Admin Panel:** Completed.
4.  **UI/UX Enhancement:** Completed.
5.  **Admin Authentication:** Adding a login screen to protect the admin panel. (In Progress)
6.  **Responsive Design:** Optimized for desktop and tablet devices.
7.  **Brand Identity:** The "RedFin" brand is used throughout the application.

## Current Plan: Implement Admin Login

1.  **Create Admin Login Screen:**
    *   Develop a new file, `admin_login_screen.dart`, containing a stateful widget.
    *   Build a form with "Username" and "Password" fields and a "Login" button.
    *   Implement validation to ensure fields are not empty.
2.  **Implement Authentication Logic:**
    *   In the `AdminLoginScreen`, create a `_login` method.
    *   This method will check the entered credentials against the hardcoded values (`RedLotusAdmin` / `AdminRedLotus`).
    *   If the login is successful, navigate to the admin dashboard, replacing the login screen in the stack.
    *   If the login fails, display an error message using a `SnackBar`.
3.  **Update Navigation:**
    *   Modify `main.dart` to introduce a new `/admin-dashboard` route for the actual dashboard.
    *   Change the existing `/admin` route to point to the new `AdminLoginScreen`. This ensures that clicking the admin button on the home page leads to the login screen.
4.  **Add Logout Functionality:**
    *   Add a "Logout" icon button to the `AppBar` of the `AdminDashboardScreen`.
    *   When tapped, this button will navigate the user back to the home screen, effectively logging them out.

---
*This blueprint will be updated as the project progresses.*
