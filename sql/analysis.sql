SELECT * FROM banking.clean;


# Total Applications

CREATE VIEW view_total_applications AS
SELECT COUNT(*) AS total_applications
FROM clean;

# Total Approved & Rejected Loans

CREATE VIEW view_loan_status_summary AS
SELECT
  Loan_Status,
  COUNT(*) AS total_count
FROM clean
GROUP BY Loan_Status;


# Approval Rate (%)

CREATE VIEW view_approval_rate AS
SELECT 
  ROUND(
    100 * SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) / COUNT(*), 2
  ) AS approval_rate_percentage
FROM clean;


# Average Annual Income & Loan Amount

CREATE VIEW view_avg_income_loan AS
SELECT 
  ROUND(AVG(Annual_Income), 2) AS avg_annual_income,
  ROUND(AVG(Loan_Amount), 2) AS avg_loan_amount
FROM clean;


# 5. Average Credit Score

CREATE VIEW view_avg_credit_score AS
SELECT 
  ROUND(AVG(Credit_Score), 2) AS avg_credit_score
FROM clean;


# 6. Loan Status by Employment Type

CREATE VIEW view_status_by_employment AS
SELECT 
  Employment_Type,
  Loan_Status,
  COUNT(*) AS count
FROM clean
GROUP BY Employment_Type, Loan_Status;


# 7. Average Loan Amount by Income Bracket

CREATE VIEW view_loan_by_income_bracket AS
SELECT
  CASE 
    WHEN Annual_Income < 50000 THEN 'Low Income'
    WHEN Annual_Income BETWEEN 500000 AND 1000000 THEN 'Mid Income'
    ELSE 'High Income'
  END AS income_bracket,
  ROUND(AVG(Loan_Amount), 2) AS avg_loan_amount
FROM clean
GROUP BY income_bracket;


# 8. Loan Approval by Gender

CREATE VIEW view_approval_by_gender AS
SELECT 
  Gender,
  Loan_Status,
  COUNT(*) AS total
FROM clean
GROUP BY Gender, Loan_Status;


# 9. Top Risky Customers 

CREATE VIEW view_high_risk_customers AS
SELECT 
  Loan_ID,
  Gender,
  Annual_Income,
  Loan_Amount,
  Credit_Score,
  ROUND(Loan_Amount / Annual_Income, 2) AS loan_to_income_ratio
FROM clean
WHERE Credit_Score < 600 AND (Loan_Amount / Annual_Income) > 0.5;
