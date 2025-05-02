/*1.     List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products */

Select company_name as customer,o.order_id,p.product_name,od.quantity,o.order_date from
customers c
JOIN orders O
on c.customer_id = o.customer_id
JOIN order_details od
on o.order_id = od.order_id
JOIN products p
on od.product_id=p.product_id

/*2.     Show each order with customer, employee, shipper, and product info — even if some 
parts are missing. (Left Join)*/

select o.order_id,o.customer_id,o.employee_id,sh.shipper_id,p.product_id from
orders o
left JOIN order_details od
on o.order_id = od.order_id
left JOIN products p
on p.product_id = od.product_id
left JOIN shippers sh
ON O.ship_via= sh.shipper_id
and SH.SHIPPER_ID is NULL

/*3.Show all order details and products (include all products even if they were never ordered). (Right Join)*/

select o.order_id,p.product_id,p.quantity_per_unit,p.product_name
from orders o
right join order_details od
on o.order_id = od.order_id
right join products p
on od.product_id = p.product_id

/*4. 	List all product categories and their products — 
including categories that have no products, and products that are 
not assigned to any category.(Outer Join)*/

select p.product_id,p.product_name,c.category_id,c.category_name
from products p
full outer JOIN categories c
on p.category_id = c.category_id

/*5.Show all possible product and category combinations (Cross join).*/

select p.product_id,p.product_name,c.category_id,c.category_name
from Products p
cross join categories c

/*6. 	Show all employees and their manager(Self join(left join))*/
select
e1.first_name|| ' ' || e1.last_name as employee_name,
e2.first_name || ' ' || e2.last_name as manager_name
from employees e1
left JOIN employees e2 on e1.reports_to = e2.employee_id

--or--
/* you can merge 2 tables with using JOIN as shown below
select
e1.first_name|| ' ' || e1.last_name as employee_name,
e2.first_name || ' ' || e2.last_name as manager_name
from employees e1,employees e2
where  e1.reports_to = e2.employee_id*/


/*7. 	List all customers who have not selected a shipping method.*/

select c.customer_id
from customers c 
left JOIN orders o
ON 
c.customer_id = o.customer_id
where o.ship_via is null






