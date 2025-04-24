BEGIN;


CREATE TABLE IF NOT EXISTS public.orders
(
    orderid integer NOT NULL,
    customerid character varying(10) COLLATE pg_catalog."default",
    employeeid integer,
    orderdate date,
    requireddate date,
    shippeddate date,
    shipperid integer,
    freight numeric(10, 2),
    CONSTRAINT orders_pkey PRIMARY KEY (orderid)
);

CREATE TABLE IF NOT EXISTS public.customers
(
    customer_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    company_name character varying(100) COLLATE pg_catalog."default",
    contact_name character varying(100) COLLATE pg_catalog."default",
    contact_title character varying(100) COLLATE pg_catalog."default",
    city character varying(100) COLLATE pg_catalog."default",
    country character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS public.employees
(
    employeeid serial NOT NULL,
    employeename character varying(100) COLLATE pg_catalog."default",
    title character varying(100) COLLATE pg_catalog."default",
    city character varying(100) COLLATE pg_catalog."default",
    country character varying(100) COLLATE pg_catalog."default",
    reportsto integer,
    CONSTRAINT employees_pkey PRIMARY KEY (employeeid)
);

CREATE TABLE IF NOT EXISTS public.shippers
(
    shipperid integer NOT NULL,
    companyname character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT shippers_pkey PRIMARY KEY (shipperid)
);

CREATE TABLE IF NOT EXISTS public.order_details
(
    orderid integer NOT NULL,
    productid integer NOT NULL,
    unitprice numeric(10, 2),
    quantity integer,
    discount numeric(4, 2),
    CONSTRAINT order_details_pkey PRIMARY KEY (orderid, productid)
);

CREATE TABLE IF NOT EXISTS public.products
(
    productid integer NOT NULL,
    productname character varying(100) COLLATE pg_catalog."default",
    quantityperunit character varying(100) COLLATE pg_catalog."default",
    unitprice numeric(10, 2),
    discontinued boolean,
    categoryid integer,
    CONSTRAINT products_pkey PRIMARY KEY (productid)
);

CREATE TABLE IF NOT EXISTS public.categories
(
    category_id serial NOT NULL,
    category_name character varying(100) COLLATE pg_catalog."default",
    description character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT categories_pkey PRIMARY KEY (category_id)
);

ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT customers FOREIGN KEY (customerid)
    REFERENCES public.customers (customer_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT employeeid_fk FOREIGN KEY (employeeid)
    REFERENCES public.employees (employeeid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT shippers FOREIGN KEY (shipperid)
    REFERENCES public.shippers (shipperid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_details
    ADD CONSTRAINT "orderId_fk" FOREIGN KEY (orderid)
    REFERENCES public.orders (orderid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_details
    ADD CONSTRAINT "productId_fk" FOREIGN KEY (productid)
    REFERENCES public.products (productid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT categoryid_fk FOREIGN KEY (categoryid)
    REFERENCES public.categories (category_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;

--To check the tables created with data

select * from public.categories;

select * from public.customers;

select * from public.employees

select * from public.order_details

select * from public.orders

select * from public.products

select from public.shippers


