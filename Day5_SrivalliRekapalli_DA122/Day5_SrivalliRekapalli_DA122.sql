                                     Day 5
 
/*1. GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100*/
SELECT 
    EXTRACT(YEAR FROM Order_date) AS OrderYear,
    EXTRACT(QUARTER FROM Order_date) AS OrderQuarter,
    COUNT(*) AS OrderCount,
    AVG(freight) AS AvgFreightCost
FROM 
    Orders
WHERE 
    freight > 100
GROUP BY 
    EXTRACT(YEAR FROM Order_date), 
    EXTRACT(QUARTER FROM Order_date)
ORDER BY 
    OrderYear, 
    OrderQuarter;

/*2.GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5 */

SELECT 
    ship_region,
    COUNT(*) AS OrderCount,
    MIN(freight) AS MinFreight,
    MAX(freight) AS MaxFreight
FROM 
    orders
WHERE 
    Ship_region IS NOT NULL
GROUP BY 
    Ship_region
HAVING 
    COUNT(*) >= 5
ORDER BY 
    OrderCount DESC;

/*3. Get all title designations across employees and customers ( Try UNION & UNION ALL)*/
--Using UNION--
SELECT  title FROM Employees
UNION
SELECT  contact_title FROM Customers;

--Using UNION ALL--
SELECT title FROM Employees
UNION ALL
SELECT contact_title FROM Customers;

/*4.Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect) */

-- Categories with discontinued products
SELECT Category_ID
FROM Products
WHERE Discontinued = 1

INTERSECT

-- Categories with in-stock products
SELECT Category_ID
FROM Products
WHERE Units_In_Stock > 0;

/*5.Find orders that have no discounted items (Display the  order_id, EXCEPT)*/
-- All orders
SELECT DISTINCT Order_ID
FROM Order_details

EXCEPT

-- Orders with at least one discounted item
SELECT DISTINCT Order_ID
FROM Order_details
WHERE Discount > 0;

