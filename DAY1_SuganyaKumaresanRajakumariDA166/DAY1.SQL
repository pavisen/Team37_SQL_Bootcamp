--1.Create Tables -Design and create the required tables in your database.

--2.Import Data - Import values from CSV files (e.g., Kaggle datasets) into the respective tables in your newly created database.

--3.Add Constraints - Implement constraints to enforce data integrity and relationships between tables.
--Include Primary key, foreign key, composite primary key.

--4.Explanation - Brief about why have you chose each constraints

--5. ER Diagram - Provide screenshot of Entity Relationship Diagram


SELECT * FROM public."Products"

CREATE TABLE public.categories(
category_id integer NOT NULL PRIMARY KEY,
category_name varchar(50),
category_description varchar(255));

DROP TABLE public.categories;


SELECT * FROM public.categories

DROP TABLE public."Products"

CREATE TABLE public.products(
product_id bigint NOT NULL,
product_name varchar(100) NOT NULL,
quantity_per_unit varchar(100) NOT NULL,
unit_price numeric,
discontinued smallint,
category_id integer NOT NULL,
PRIMARY KEY(product_id),
FOREIGN KEY (category_id) REFERENCES categories(category_id));

CREATE TABLE public.customers(
customer_id varchar(50) NOT NULL PRIMARY KEY,
company_name varchar(50) NOT NULL,
contact_name varchar(50) NOT NULL,
contact_title varchar(50) NOT NULL,
city varchar(50) NOT NULL,
country varchar(50) NOT NULL);

CREATE TABLE public.employees(
employee_id bigint NOT NULL PRIMARY KEY,
employee_name varchar(50) NOT NULL,
title varchar(50) NOT NULL,
city varchar(50) NOT NULL,
country varchar(50) NOT NULL,
reports_to bigint
);

SELECT * FROM public.employees;

CREATE TABLE public.order_details(
order_id bigint NOT NULL,
product_id bigint NOT NULL,
unit_price numeric(10,2) NOT NULL,
quantity integer NOT NULL,
discount numeric(6,2) NOT NULL,
FOREIGN KEY(product_id) REFERENCES products(product_id)
);
ALTER TABLE public.order_details
ADD FOREIGN KEY(order_id) REFERENCES orders(order_id);

ALTER TABLE public.order_details
ADD PRIMARY KEY(order_id,product_id);


CREATE TABLE public.orders(
order_id bigint NOT NULL PRIMARY KEY,
customer_id varchar(50) NOT NULL,
employee_id bigint NOT NULL,
order_date date NOT NULL,
required_date date NOT NULL,
shipped_date date,
shipper_id bigint NOT NULL,
freight numeric NOT NULL,
FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
);

ALTER TABLE public.orders
ADD FOREIGN KEY(shipper_id) REFERENCES shippers(shipper_id);

CREATE TABLE public.shippers(
shipper_id bigint NOT NULL PRIMARY KEY,
company_name varchar
);

SELECT * FROM public.shippers;	
