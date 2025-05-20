# DataAnalytics-Assessment
SQL Assessment for Data Analyst Role

This repository contains my solutions for a SQL technical assessment. 
Each SQL query corresponds to a business scenario that tests relational data handling and analytical thinking.

---

## Questions & Approaches

### **Question 1 – High-Value Customers with Multiple Products**
**Scenario:** Identify customers with both savings and investment plans.  
**Approach:**  
- Join `users_customuser`, `plans_plan`, and `savings_savingsaccount`
- Filter for `is_regular_savings = 1` and `is_a_fund = 1`
- Group by customer and count savings & investment plans
- Sum deposits and order by total deposit

---

### **Question 2 – Transaction Frequency Analysis**
**Scenario:** Categorize customers by average transaction frequency per month.  
**Approach:**  
- Join `users_customuser` and `savings_savingsaccount`
- Compute total transactions and transaction months per customer
- Calculate average monthly transactions and assign frequency category using `CASE`

---

### **Question 3 – Account Inactivity Alert**
**Scenario:** Flag savings or investment accounts with no inflow in over 1 year.  
**Approach:**  
- Select active `plans_plan` records
- Join with `savings_savingsaccount` by plan ID
- Use `MAX(transaction_date)` per plan to calculate inactivity days

---

### **Question 4 – Customer Lifetime Value (CLV) Estimation**
**Scenario:** Estimate CLV based on tenure and transactions.  
**Approach:**  
- Join `users_customuser` and `savings_savingsaccount`
- Compute account tenure in months
- Calculate total confirmed inflows and average profit (0.1%)
- Apply formula: `(total_transactions / tenure) * 12 * avg_profit_per_transaction`

---
## Data Preparation & Setup
Before solving the questions, I extracted the necessary tables from the provided SQL script file using the following process:

- Loaded the `.sql` dump file in MySQL Workbench
- Identified and isolated key tables: `users_customuser`, `savings_savingsaccount`, `plans_plan`, and `withdrawals_withdrawal`
- Executed the script to create tables and populate with sample data
- Verified table structures and relationships
- Explored column types and constraints to understand the data model

This initial setup ensured a clean environment to test and optimize my queries efficiently.

---

## Challenges & Resolutions

- **Date calculations**: Ensured use of `DATEDIFF` and `TIMESTAMPDIFF` where needed.
- **Monetary values in Kobo**: Converted all kobo values to Naira by dividing by 100.
- **Categorizing values**: Used SQL `CASE` for segmenting transaction frequency.

---

## Notes
- Queries were tested on sample data provided
- All logic is optimized for readability and business understanding

---

Thank you for reviewing this submission.
