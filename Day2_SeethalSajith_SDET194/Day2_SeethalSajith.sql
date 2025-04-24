select * from employees;

ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR;

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT;


ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;

ALTER TABLE employees
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

ALTER TABLE employees
DROP COLUMN linkedin_profile;


SELECT employeename, title
FROM employees;

SELECT DISTINCT unitprice
FROM products;

SELECT *
FROM customers
ORDER BY companyname ASC;


SELECT productname, unitprice AS price_in_usd
FROM products;

SELECT *
FROM customers
WHERE country = 'Germany';

SELECT *
FROM customers
WHERE country IN ('France', 'Spain');

SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM orderdate) = 1997
  AND (freight > 50 OR shippeddate IS NOT NULL);

  
SELECT productid, productname, unitprice
FROM products
WHERE unitprice > 15;


SELECT *
FROM employees
WHERE country = 'USA'
  AND title = 'Sales Representative';

SELECT *
FROM products
WHERE discontinued = FALSE
  AND unitprice > 30;

SELECT *
FROM orders
ORDER BY orderid
LIMIT 10;

SELECT *
FROM orders
ORDER BY orderid
OFFSET 10
LIMIT 10;

SELECT *
FROM customers
WHERE contacttitle IN ('Sales Representative', 'Owner');

SELECT *
FROM orders
WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31';

SELECT *
FROM products
WHERE categoryid NOT IN (1, 2, 3);

SELECT *
FROM customers
WHERE companyname LIKE 'A%';

INSERT INTO orders (
    orderid,
    customerid,
    employeeid,
    orderdate,
    requireddate,
    shippeddate,
    shipperid,
    freight
)
VALUES (
    11078,
    'ALFKI',
    5,
    '2025-04-23',
    '2025-04-30',
    '2025-04-25',
    2,
    45.50
);
UPDATE products
SET unitprice = unitprice * 1.10
WHERE categoryid = 2;
