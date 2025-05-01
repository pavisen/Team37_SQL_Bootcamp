--1.     Rank employees by their total sales
--(Total sales = Total no of orders handled, JOIN employees and orders table)

SELECT O.employee_id,COUNT(o.order_id) total_orders,rank() over(order by COUNT(o.order_id) desc ) rank
	FROM  public.employees EMP LEFT JOIN public.orders O
	ON EMP.employee_id=O.employee_id
	GROUP BY O.employee_id
	ORDER BY COUNT(o.order_id) DESC 
	
/*2.      Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).
*/

SELECT order_id,customer_id,order_date,freight,
	LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_freight,
    LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_freight
FROM public.orders

/*3.     Show products and their price categories, product count in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)
*/
WITH  PRICE_CAT AS 
(SELECT product_id,unit_price,
	CASE WHEN unit_price <20 THEN 'Low Price'
	WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price' END  AS price_categorY
FROM public.products
)
SELECT PRICE_CAT.price_categorY,
	COUNT(PRICE_CAT.product_id) product_count,
	ROUND(AVG(PRICE_CAT.unit_price)::NUMERIC,2) AVG_UNIT_PRICE
FROM public.products P INNER JOIN PRICE_CAT
	ON P.product_id=PRICE_CAT.product_id
	GROUP BY PRICE_CAT.price_categorY


























