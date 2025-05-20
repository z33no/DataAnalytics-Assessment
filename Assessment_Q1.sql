SELECT * FROM plans_plan;
SELECT * FROM savings_savingsaccount;
SELECT * FROM users_customuser;
SELECT * FROM withdrawals_withdrawal;

/*Question 1: High-Value Customers with Multiple Products
MyTask: This questions helps to find customers with at least
 one funded savings plan and one funded investment plan, 
 sorted by total deposits. */

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS customer_name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN sa.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN sa.id END) AS investment_count,
    ROUND(SUM(sa.confirmed_amount),2) AS total_deposits
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount sa ON u.id = sa.owner_id
JOIN 
    plans_plan p ON sa.plan_id = p.id
WHERE 
    sa.confirmed_amount > 0
GROUP BY 
    u.id, customer_name
HAVING 
    savings_count >= 1 AND investment_count >= 1
ORDER BY 
    total_deposits DESC;
