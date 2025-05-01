-- 1.     Rank employees by their total sales
-- (Total sales = Total no of orders handled, JOIN employees and orders table)
SELECT
	E.EMPLOYEE_ID,
	E.FIRST_NAME,
	E.LAST_NAME,
	COUNT(O.ORDER_ID) AS TOTAL_SALES,
	RANK() OVER (
		ORDER BY
			COUNT(O.ORDER_ID) DESC
	) AS SALES_RANK
FROM
	EMPLOYEES E
	JOIN ORDERS O ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
GROUP BY
	E.EMPLOYEE_ID,
	E.FIRST_NAME,
	E.LAST_NAME
ORDER BY
	TOTAL_SALES DESC;

-- 2.      Compare current order's freight with previous and next order for each customer.
-- (Display order_id,  customer_id,  order_date,  freight,
-- Use lead(freight) and lag(freight).
SELECT
	ORDER_ID,
	CUSTOMER_ID,
	ORDER_DATE,
	FREIGHT,
	LAG(FREIGHT) OVER (
		PARTITION BY
			CUSTOMER_ID
		ORDER BY
			ORDER_DATE
	) AS PREVIOUS_FREIGHT,
	LEAD(FREIGHT) OVER (
		PARTITION BY
			CUSTOMER_ID
		ORDER BY
			ORDER_DATE
	) AS NEXT_FREIGHT
FROM
	ORDERS
ORDER BY
	CUSTOMER_ID,
	ORDER_DATE;

-- 3.     Show products and their price categories, product count in each category, avg price:
--         	(HINT:
-- ·  	Create a CTE which should have price_category definition:
--         	WHEN unit_price < 20 THEN 'Low Price'
--             WHEN unit_price < 50 THEN 'Medium Price'
--             ELSE 'High Price'
-- ·  	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)
WITH
	PRICE_CTE AS (
		SELECT
			PRODUCT_ID,
			PRODUCT_NAME,
			UNIT_PRICE,
			CASE
				WHEN UNIT_PRICE < 20 THEN 'Low Price'
				WHEN UNIT_PRICE < 50 THEN 'Medium Price'
				ELSE 'High Price'
			END AS PRICE_CATEGORY
		FROM
			PRODUCTS
	)
SELECT
	PRICE_CATEGORY,
	COUNT(*) AS PRODUCT_COUNT,
	ROUND(AVG(UNIT_PRICE)::NUMERIC, 2) AS AVG_PRICE
FROM
	PRICE_CTE
GROUP BY
	PRICE_CATEGORY
ORDER BY
	PRICE_CATEGORY;