-- Creating a copy of the original table to preserve the raw data and avoid making direct changes

SELECT * 
FROM sales_data;

CREATE TABLE sales_data2
LIKE sales_data;

INSERT sales_data2
SELECT *
FROM sales_data;

SELECT * 
FROM sales_data2;


-- ------------------------------------------------------------------------------------------------------------------

--     what is each product category total revenue ?


SELECT `product category`,SUM(`total amount`) AS Total_amount
FROM sales_data2
GROUP BY `product category` 
ORDER BY Total_amount DESC;


-- Insight: Electronics generated the highest total revenue, making it the most profitable category overall.

-- ----------------------------------------------------------------------------------------------------------
--      What is the total revenue by month for each category?


SELECT 
DATE_FORMAT(`date`, '%Y-%m') AS sale_month,
`product category`,
SUM(`total amount`) AS total_amount
FROM sales_data2
GROUP BY sale_month, `product category`
ORDER BY sale_month, total_amount DESC;


-- Note: I use DATE_FORMAT to group dates by month and compare revenue over time.
-- Insight: Monthly revenue trends vary by category, with Electronics and Apparel showing seasonal peaks.

-- -------------------------------------------------------------------------------------------------------------

--     Which product category sold the most this year?

SELECT `product category`,
SUM(`total amount`) AS total_amount
FROM sales_data2
GROUP BY `product category`
ORDER BY total_amount DESC 
LIMIT 1;

--  Insight: Electronics was the top-selling category of the year.

-- ---------------------------------------------------------------------------------------------------------


--    What is the Top customer information for Male and Female?

SELECT *
FROM (
	SELECT *,
    ROW_NUMBER() OVER( PARTITION BY `gender` ORDER BY `total amount` DESC) AS RN
    FROM sales_data2
    ) AS ranked
    WHERE RN = 1;

-- Note: I use ROW_NUMBER() with PARTITION BY to find the highest spender for each gender.
-- Insight: This query identifies the single top-spending male and female customers information.

-- -----------------------------------------------------------------------------------------------------------------


--     which gender spent the most this year and and what age spent the most?

SELECT `gender`, 
SUM(`total amount`) AS gender_revenue_total , 
ROUND(AVG(`age`), 2) AS avg_age
FROM sales_data2
GROUP BY `gender`
ORDER BY gender_revenue_total DESC;

-- Note: Using ROUND() to format numeric results to 2 decimal places for cleaner, more readable output
-- Insight: Female customers contributed more to total sales and had a slightly lower average age.



-- ------------------------------------------------------------------------------------------------------------------------------

-- Monthly revenue by product category (detailed breakdown)

SELECT DATE_FORMAT(`date`, '%Y-%m') AS sale_month,
`product category`,
SUM(`total amount`) AS total_sales_for_the_month
FROM sales_data2
GROUP BY sale_month , `product category`
ORDER BY sale_month,
total_sales_for_the_month DESC;

-- Note: I use DATE_FORMAT to group dates by month and compare revenue over time.
 
 --   Which month had the highest overall sales?
 
 
 WITH monthly_totals AS (
	SELECT 
    DATE_FORMAT(`date`, '%Y-%m' ) AS sale_month, 
     SUM(`total amount`) AS total_monthly_revenue
    FROM sales_data2
    GROUP BY sale_month
)
SELECT *
FROM monthly_totals
ORDER BY total_monthly_revenue DESC
LIMIT 1;

-- Note: I use a CTE to summarize revenue per month and extract the top-performing one.
-- Note: I use DATE_FORMAT to group dates by month and compare revenue over time.
-- Insight: May had the highest overall sales — showing seasonal peaks.
 
-- --------------------------------------------------------------------------------------------------------------
--        What is the average order value for each gender ?

SELECT `gender`, 
ROUND(AVG(`Total Amount`) , 2) AS avg_total
FROM sales_data2
GROUP BY `gender`
ORDER BY avg_total DESC;

--  Insight: On average, Female customers placed slightly higher-value orders than male customers.


































