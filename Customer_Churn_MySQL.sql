USE customer_churn;
SELECT DATABASE();

SELECT *
FROM customer
LIMIT 5;
-- Q1 Total Customers
SELECT  COUNT(*) AS total_customers
FROM customer;

-- Churn Rate
SELECT ROUND(100 * SUM(CASE WHEN churn_label='Yes' THEN 1 ELSE 0 END)/COUNT(*),
2) AS churn_rate
FROM customer;

-- Contract Type Wise Churn %
SELECT contract , ROUND(100 * SUM(CASE WHEN churn_label='Yes' THEN 1 ELSE 0 END)/COUNT(*),
2) AS churn_percentage
FROM customer
GROUP BY contract
ORDER BY churn_percentage;

-- Payment Method With Highest Churn
SELECT
payment_method,
COUNT(*) AS churn_count
FROM customer
WHERE churn_label='Yes'
GROUP BY payment_method
ORDER BY churn_count ;

-- Churn By Internet Service
SELECT
internet_service,
COUNT(*) AS churn_customers
FROM customer
WHERE churn_label='Yes'
GROUP BY internet_service;

-- Average Monthly Charges (Churn vs Non-Churn)
SELECT
churn_label,
ROUND(AVG(monthly_charges),2)
FROM customer
GROUP BY churn_label;

-- Tenure Group Analysis
SELECT
tenure_group,
COUNT(*) customers,
ROUND(AVG(monthly_charges),2) avg_monthly_charge
FROM customer
GROUP BY tenure_group;

-- Top 10 Cities With Highest Churn
SELECT
city,
COUNT(*) churn_count
FROM customer
WHERE churn_label='Yes'
GROUP BY city
ORDER BY churn_count DESC
LIMIT 10;

-- Senior Citizen Churn Analysis
SELECT
senior_citizen,
COUNT(*) churn_count
FROM customer
WHERE churn_label='Yes'
GROUP BY senior_citizen;

-- Churn Reason Analysis
SELECT
churn_reason,
COUNT(*) total_customers
FROM customer
WHERE churn_label='Yes'
GROUP BY churn_reason
ORDER BY total_customers DESC;

-- High Risk Customer Segment
SELECT
contract,
internet_service,
payment_method,
COUNT(*) churn_count
FROM customer
WHERE churn_label='Yes'
GROUP BY contract,internet_service,payment_method
ORDER BY churn_count DESC
LIMIT 10;


--  Tech Support Impact On Churn
SELECT
tech_support,
ROUND(
100 * SUM(CASE WHEN churn_label='Yes' THEN 1 ELSE 0 END)/COUNT(*),
2
) churn_rate
FROM customer
GROUP BY tech_support;


--  Online Security Impact
SELECT
online_security,
ROUND(
100 * SUM(CASE WHEN churn_label='Yes' THEN 1 ELSE 0 END)/COUNT(*),
2
) churn_rate
FROM customer
GROUP BY online_security;


--  Top 5 States Losing Customers
SELECT
state,
COUNT(*) churn_count
FROM customer
WHERE churn_label='Yes'
GROUP BY state
ORDER BY churn_count DESC
LIMIT 5;


--  Which Monthly Charge Segment Has Highest Churn
SELECT
monthly_charges_segment,
COUNT(*) churn_count
FROM customer
WHERE churn_label='Yes'
GROUP BY monthly_charges_segment
ORDER BY churn_count DESC;

-- Customers More Likely To Churn Than Average
SELECT
    customerid,
    churn_score,
    monthly_charges,
    contract
FROM customer
WHERE churn_score >
(
    SELECT AVG(churn_score)
    FROM customer
)
ORDER BY churn_score DESC;