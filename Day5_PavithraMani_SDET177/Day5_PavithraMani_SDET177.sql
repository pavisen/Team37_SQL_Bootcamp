-- 1.Group by with WHERE on orders by year and quarter.
-- Display the year, quarter, order count, and average freight cost, but only for those orders where the freight cost is greater than 100!
SELECT
	EXTRACT(
		YEAR
		FROM
			ORDER_DATE
	) AS YEAR,
	CEIL(
		EXTRACT(
			MONTH
			FROM
				ORDER_DATE
		) / 3
	) AS QUARTER,
	COUNT(*) AS ORDER_COUNT,
	AVG(FREIGHT) AS AVG_FREIGHT
FROM
	ORDERS
WHERE
	FREIGHT > 100
GROUP BY
	EXTRACT(
		YEAR
		FROM
			ORDER_DATE
	),
	CEIL(
		EXTRACT(
			MONTH
			FROM
				ORDER_DATE
		) / 3
	)
ORDER BY
	YEAR,
	QUARTER;

-- Group by with HAVING on high-volume ship regions.
-- Display the ship region, number of orders in each region, and the minimum and maximum freight costs.
-- Filter to show only regions where the number of orders is greater than or equal to 5!
SELECT
	SHIP_REGION,
	COUNT(*) AS ORDER_COUNT,
	MIN(FREIGHT) AS MIN_FREIGHT,
	MAX(FREIGHT) AS MAX_FREIGHT
FROM
	ORDERS
WHERE
	SHIP_REGION IS NOT NULL
GROUP BY
	SHIP_REGION
HAVING
	COUNT(*) >= 5
ORDER BY
	ORDER_COUNT DESC;

-- Get all title designations across employees and customers.
-- Try using UNION and UNION ALL!
SELECT
	TITLE
FROM
	EMPLOYEES
UNION
SELECT
	CONTACT_TITLE
FROM
	CUSTOMERS
ORDER BY
	TITLE;

-- Find categories that have both discontinued and in-stock products.
-- Display the category ID (in-stock means units in stock > 0) using INTERSECT.

SELECT
	CATEGORY_ID
FROM
	PRODUCTS
WHERE
	DISCONTINUED = 1
INTERSECT
-- Categories with in-stock products
SELECT
	CATEGORY_ID
FROM
	PRODUCTS
WHERE
	UNITS_IN_STOCK > 0
ORDER BY
	CATEGORY_ID;
	
-- 5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)
 

SELECT
	ORDER_ID
FROM
	ORDER_DETAILS
EXCEPT
SELECT DISTINCT
	ORDER_ID
FROM
	ORDER_DETAILS
WHERE
	DISCOUNT > 0
ORDER BY
	ORDER_ID;