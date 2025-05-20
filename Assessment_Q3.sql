SELECT * FROM plans_plan;
SELECT * FROM savings_savingsaccount;
SELECT * FROM users_customuser;
SELECT * FROM withdrawals_withdrawal;

/* Question 3: Account Inactivity Alert
MyTask: i was able to find all active accounts (savings or investment) with no transactions in the last 1 year (365 days). */

SELECT 
    p.id AS plan_id,
    sa.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(sa.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(sa.created_on)) AS inactivity_days
FROM 
    savings_savingsaccount sa
JOIN 
    plans_plan p ON sa.plan_id = p.id
WHERE 
    sa.confirmed_amount > 0
GROUP BY 
    p.id, sa.owner_id
HAVING 
    DATEDIFF(CURDATE(), MAX(sa.created_on)) > 365;

