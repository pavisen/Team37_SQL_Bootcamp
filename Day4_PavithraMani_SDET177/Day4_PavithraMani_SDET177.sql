-- 1.     List all customers and the products they ordered with the order date. (Inner join)
-- Tables used: customers, orders, order_details, products
-- Output should have below columns:
--     companyname AS customer,
--     orderid,
--     productname,
--     quantity,
--     orderdate
SELECT
	C.CONTACT_NAME AS CUSTOMER,
	O.ORDER_ID,
	P.PRODUCT_NAME,
	OD.QUANTITY,
	O.ORDER_DATE
FROM
	CUSTOMERS C
	INNER JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
	INNER JOIN ORDER_DETAILS OD ON O.ORDER_ID = OD.ORDER_ID
	INNER JOIN PRODUCTS P ON OD.PRODUCT_ID = P.PRODUCT_ID;

-- 2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
-- Tables used: orders, customers, employees, shippers, order_details, products
SELECT
	O.ORDER_ID,
	C.CONTACT_NAME AS CUSTOMER,
	E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE,
	S.COMPANY_NAME AS SHIPPER,
	P.PRODUCT_NAME,
	OD.QUANTITY,
	O.ORDER_DATE
FROM
	ORDERS O
	LEFT JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
	LEFT JOIN EMPLOYEES E ON O.EMPLOYEE_ID = E.EMPLOYEE_ID
	LEFT JOIN SHIPPERS S ON O.SHIP_VIA = S.SHIPPER_ID
	LEFT JOIN ORDER_DETAILS OD ON O.ORDER_ID = OD.ORDER_ID
	LEFT JOIN PRODUCTS P ON OD.PRODUCT_ID = P.PRODUCT_ID;

-- 3.     Show all order details and products (include all products even if they were never ordered). (Right Join)
-- Tables used: order_details, products
-- Output should have below columns:
--     orderid,
--     productid,
--     quantity,
--     productname
SELECT
	OD.ORDER_ID,
	P.PRODUCT_ID,
	OD.QUANTITY,
	P.PRODUCT_NAME
FROM
	ORDER_DETAILS OD
	RIGHT JOIN PRODUCTS P ON OD.PRODUCT_ID = P.PRODUCT_ID;

-- 4. 	List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
-- Tables used: categories, products
SELECT
	C.CATEGORY_ID,
	C.CATEGORY_NAME,
	P.PRODUCT_ID,
	P.PRODUCT_NAME
FROM
	CATEGORIES C
	FULL OUTER JOIN PRODUCTS P ON C.CATEGORY_ID = P.CATEGORY_ID;

-- 5. 	Show all possible product and category combinations (Cross join).
SELECT
	P.PRODUCT_ID,
	P.PRODUCT_NAME,
	P.SUPPLIER_ID,
	P.CATEGORY_ID,
	P.QUANTITY_PER_UNIT,
	P.UNIT_PRICE,
	P.UNITS_IN_STOCK,
	P.UNITS_ON_ORDER,
	P.REORDER_LEVEL,
	P.DISCONTINUED,
	C.CATEGORY_ID,
	C.CATEGORY_NAME,
	C.DESCRIPTION,
	C.PICTURE
FROM
	PRODUCTS P
	CROSS JOIN CATEGORIES C;

-- 6. 	Show all employees who have the same manager(Self join)
SELECT
	E1.EMPLOYEE_ID AS EMPLOYEEID,
	E1.FIRST_NAME || ' ' || E1.LAST_NAME AS EMPLOYEE_NAME,
	E2.EMPLOYEE_ID AS MANAGER_ID,
	E2.FIRST_NAME || ' ' || E2.LAST_NAME AS MANAGER_NAME
FROM
	EMPLOYEES E1
	JOIN EMPLOYEES E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID
ORDER BY
	E2.EMPLOYEE_ID,
	E1.EMPLOYEE_ID;

-- 7. 	List all customers who have not selected a shipping method.
-- Tables used: customers, orders
-- (Left Join, WHERE o.shipvia IS NULL)
SELECT
	C.CUSTOMER_ID,
	C.COMPANY_NAME
FROM
	CUSTOMERS C
	LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE
	O.SHIP_VIA IS NULL;