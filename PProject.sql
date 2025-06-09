-- Creating a copy of the original table to preserve the raw data and avoid making direct changes

SELECT * 
FROM sales_data;

CREATE TABLE sales_data2
LIKE sales_data;

SELECT * 
FROM sales_data2;

INSERT sales_data2
SELECT *
FROM sales_data;

-- what is each product category total revenue ?


SELECT `product category`,SUM(`total amount`) AS Total_amount
FROM sales_data2
GROUP BY `product category` 
ORDER BY Total_amount DESC;

-- What is the total revenue by month for each category?


SELECT 
DATE_FORMAT(`date`, '%Y-%m') AS sale_month,
`product category`,
SUM(`total amount`) AS total_amount
FROM sales_data2
GROUP BY sale_month, `product category`
ORDER BY sale_month, `product category`;


-- Which product category sold the most this year?

SELECT `product category`,
SUM(`total amount`) AS total_amount
FROM sales_data2
GROUP BY `product category`
ORDER BY total_amount DESC 
LIMIT 1;

-- What is the Top customer information for Male and Female?

SELECT *
FROM (
	SELECT *,
    ROW_NUMBER() OVER( PARTITION BY `gender` ORDER BY `total amount` DESC) AS RN
    FROM sales_data2
    ) AS ranked
    WHERE RN = 1;


-- which gender spent the most this year and and what age spent the most?

SELECT `gender`, 
SUM(`total amount`) AS gender_revenue_total , 
AVG(`age`) AS avg_age
FROM sales_data2
GROUP BY `gender`
ORDER BY gender_revenue_total DESC
;


-- Are there any seasonal patterns in product sales?

SELECT DATE_FORMAT(`date`, '%Y-%m') AS sale_month,
`product category`,
SUM(`total amount`) AS total_sales_for_the_month
FROM sales_data2
GROUP BY sale_month , `product category`
ORDER BY sale_month,
total_sales_for_the_month DESC;
 

-- What is the average order value for each gender ?

SELECT `gender`, AVG(`Total Amount`) AS avg_total
FROM sales_data2
GROUP BY `gender`;





































