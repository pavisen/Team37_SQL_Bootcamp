/*1.Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')*/

select product_name,
(case 
 when units_in_stock = 0  then 'Out of Stock'
 when units_in_stock < 20  then 'Low Stock'
end) as stockstatus
from products

/*2.Find All Products in Beverages Category
(Subquery, Display product_name,unitprice)*/

select product_name,unit_price
from products
where 
category_id =(select category_id from categories
where category_name = 'Drinks')

/*3.      Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for
each employee then order by DESC and limit 1. Use Subquery)*/
Select order_id, order_date, freight, employee_id
from orders  where employee_id = (
select employee_id
from orders a
group by employee_id
order by count(order_id) asc
limit 1)

/*4.Find orders  where for country!= ‘USA’ with freight costs 
higher than any order from USA. (Subquery, Try with ANY, ALL operators)*/

select order_id,freight
from orders
where ship_country!= 'USA'
and freight > any (
select freight
from orders
where ship_country = 'USA'
)
order by freight;

select * from categories
select * from products
select * from employees
select * from orders
where  employee_id= 5
select * from order_details
select * from customers