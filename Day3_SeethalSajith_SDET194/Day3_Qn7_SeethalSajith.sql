select * from employees
select * from orders
SELECT 
    o.order_id,
    o.order_date,
    e.first_name || ' ' || e.last_name AS employeename
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id;