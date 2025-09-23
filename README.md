# 🛍️ Payment Tracking in Banking 
## Problem 

Banks often face challenges in tracking loan payments, EMIs, and overdue recoveries. Currently, much of the process is:

✅ Manual (spreadsheets, phone calls, reminders).

❌ Error-prone (missed follow-ups, wrong tracking).

❌ Lacking visibility (managers can’t see consolidated repayment data).

This leads to delayed recoveries, poor customer experience, and inefficiency.
## Solution

Designed and implemented a Payment Tracking System in Salesforce that automates loan repayment workflows:

🔹 Loan Object → Stores loan details (Principal, Interest, Status).

🔹 Payment Object → Tracks EMI/repayments linked to Loans.

🔹 Recovery Object → Assigns overdue loans to Recovery Agents.

🔹 Role Hierarchy → Manager → Loan Officer / Recovery Agent.

 Documentation link : https://docs.google.com/document/d/1KgsjA_pe5jMjzUCmkOOnjrR0GbOaIm_J6FFsb85qRKA/edit?usp=sharing

🔹 Permission Sets & Sharing Rules → Ensure secure, role-based access.

🔹 Automation → Status changes, overdue detection, recovery assignment.

🔹 Reports & Dashboards → For overdue loans, payment collections, recovery performance.
