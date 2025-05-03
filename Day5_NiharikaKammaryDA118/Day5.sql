/*1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost 
only for those orders where freight cost > 100 */

select order_id,order_date,extract(year from order_date) as year,extract(quarter from order_date) as quarter,
count(order_id)as ordercount,avg(freight)
from orders
where freight>100
group by order_id

/*2.      GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5 */

 select ship_region,min(freight),max(freight),count(order_id) as ordered
 from orders
 group by ship_region
 having count(order_id) >= 5

/*3.Get all title designations across employees and customers ( Try UNION & UNION ALL)*/
select contact_title from customers
union
select title from employees;

select contact_title from customers
union all
select title from employees;


/*4. Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/

select category_id
from products
where discontinued = 0 AND units_in_stock>0;

/*5.Find orders that have no discounted items (Display the  order_id, EXCEPT)*/
select distinct order_id 
from order_details

except

select distinct order_id
from order_details
where discount> 0

select 

select * from orders
select * from employees
select * from customers
select * from order_details
select * from customers
select * from categories
select * from products

select category_id,count(*)as prd,count(category_id) as catg
from categories
group by category_id