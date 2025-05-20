SELECT * FROM plans_plan;
SELECT * FROM savings_savingsaccount;
SELECT * FROM users_customuser;
SELECT * FROM withdrawals_withdrawal;

/* Question 4: Customer Lifetime Value (CLV) Estimation
MyTask: Based on assumption given for each customer, 
using the profit_per_transaction as 0.1% of the transaction value, i calculated:
Account tenure (months since signup)
With total transactions and
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Ordered by estimated CLV from highest to lowest */

SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    IFNULL(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 1) AS tenure_months,
    COUNT(sa.id) AS total_transactions,
    ROUND(
        (COUNT(sa.id) / IFNULL(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 1)) 
        * 12 
        * AVG(sa.confirmed_amount * 0.001),
        2
    ) AS estimated_clv
FROM 
    users_customuser u
LEFT JOIN 
    savings_savingsaccount sa ON u.id = sa.owner_id
GROUP BY 
    u.id
ORDER BY 
    estimated_clv DESC;
