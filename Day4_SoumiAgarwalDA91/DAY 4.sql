--1.     List all customers and the products they ordered with the order date. (Inner join)

SELECT CUST.company_name CUSTOMER,OD.order_id,P.product_name,OD.quantity,O.order_date
	FROM public.customers CUST 
	INNER JOIN public.orders O ON CUST.customer_id=O.customer_id 
	INNER JOIN public.order_details OD ON O.order_id=OD.order_id
	INNER JOIN public.products P ON OD.product_id=P.product_id
	
--2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing.  	 

SELECT O.order_id,CUST.company_name CUSTOMER,EMP.employee_id,EMP.last_name,EMP.first_name,SHP.company_name SHIPPER
	,P.*
	FROM public.orders O LEFT JOIN public.customers CUST 
	ON O.customer_id=CUST.customer_id LEFT JOIN public.employees EMP 
	ON O.employee_id=EMP.employee_id LEFT JOIN public.shippers SHP
	ON O.ship_via=SHP.shipper_id LEFT JOIN public.order_details OD
	ON O.order_id=OD.order_id 
	LEFT JOIN public.products P 
	ON OD.product_id=P.product_id
	
--3.     Show all order details and products (include all products even if they were never ordered). 	
	
SELECT OD.order_id,OD.product_id,OD.quantity,P.product_name
FROM public.order_details OD RIGHT JOIN public.products P 
	ON OD.product_id=P.product_id

--4. 	List all product categories and their products — 
--including categories that have no products, and products that are not assigned to any category.(Outer Join)

SELECT CA.category_name,P.product_name FROM public.categories CA  FULL OUTER JOIN public.products P
	ON CA.category_id=P.category_id

--5. 	Show all possible product and category combinations (Cross join).
SELECT * FROM public.categories CA  CROSS JOIN public.products P

--6. 	Show all employees and their manager(Self join(left join))

SELECT EMP.employee_id,EMP.first_name||' '||EMP.last_name EMPLOYEE,MANAGER.first_name||' '||MANAGER.last_name MANAGER,
EMP.reports_to
FROM public.employees EMP LEFT JOIN public.employees MANAGER 
	ON EMP.reports_to=MANAGER.employee_id
	ORDER BY EMP.employee_id
























































	
	
	
	
	
	
	
	
	
	
	
	
	
	
