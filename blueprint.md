# FinCare - Flutter Web App Blueprint

## Overview

This document outlines the plan and progress for creating "FinCare," a modern fintech web application. The application will help users find suitable banks for loans based on their financial profile, featuring a responsive Flutter web frontend and a Node.js backend.

## Style, Design, and Features

### Key Features

1.  **Multi-Step User Form:** A 4-step process to collect user financial data. (Completed)
2.  **Bank Matching & Ranking:** A results page displaying matched banks, ranked by approval rates and eligibility. (In Progress)
3.  **Admin Panel:** A secure area for managing bank data and viewing user submissions.
4.  **Responsive Design:** Optimized for desktop and tablet devices.
5.  **Brand Identity:** The "FinCare" logo is prominently displayed.

## Current Plan: Implement Bank Matching & Ranking

1.  **Backend Development (Node.js):**
    *   **Define Bank Model:** Create a Mongoose schema (`bank.js`) to store bank profiles, including supported loan types, minimum income, interest rates, and approval rates.
    *   **Create Admin Endpoint for Banks:** Implement a basic `POST /api/admin/banks` route to add/manage bank data for testing purposes.
    *   **Implement Matching Algorithm:**
        *   Create a `GET /api/banks/match` endpoint.
        *   The endpoint will receive user financial data (loan purpose, income, etc.).
        *   It will filter banks based on matching criteria (e.g., loan type supported, income requirements).
        *   It will rank the filtered results based on: 1. Highest approval rate, 2. Eligibility match, 3. Interest rates.
2.  **Frontend Development (Flutter):**
    *   **Create Bank Results Screen:** Build a new screen (`bank_results_screen.dart`) to display the matched banks.
    *   **Develop Bank Card Widget:** Create a reusable widget to display individual bank details.
    *   **Integrate API Service:** Create a service to fetch matched banks from the backend.
    *   **Update Navigation:** Connect the `SubmissionSuccessScreen` to the new results screen.

---
*This blueprint will be updated as the project progresses.*
