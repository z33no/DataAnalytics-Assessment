SELECT * FROM plans_plan;
SELECT * FROM savings_savingsaccount;
SELECT * FROM users_customuser;
SELECT * FROM withdrawals_withdrawal;

/* Question 2: Transaction Frequency Analysis
MyTask: Solution to this question will help to calculate 
the average number of transactions per customer per month,
and Categorize each customer: */

SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 2) AS avg_transactions_per_month
FROM (
    SELECT 
        u.id AS customer_id,
        COUNT(sa.id) AS total_transactions,
        IFNULL(TIMESTAMPDIFF(MONTH, MIN(sa.created_on), MAX(sa.created_on)) + 1, 1) AS tenure_months,
        COUNT(sa.id) / IFNULL(TIMESTAMPDIFF(MONTH, MIN(sa.created_on), MAX(sa.created_on)) + 1, 1) AS avg_txn_per_month,
        CASE
            WHEN COUNT(sa.id) / IFNULL(TIMESTAMPDIFF(MONTH, MIN(sa.created_on), MAX(sa.created_on)) + 1, 1) >= 10 THEN 'High Frequency'
            WHEN COUNT(sa.id) / IFNULL(TIMESTAMPDIFF(MONTH, MIN(sa.created_on), MAX(sa.created_on)) + 1, 1) >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        users_customuser u
    LEFT JOIN 
        savings_savingsaccount sa ON u.id = sa.owner_id
    GROUP BY 
        u.id
) AS categorized
GROUP BY 
    frequency_category;