CREATE TABLE IF NOT EXISTS categories
(
    category_id serial NOT NULL,
    category_name character varying(100),
    description character varying(255),
    CONSTRAINT categories_pk PRIMARY KEY (category_id)
);

select * from categories;

CREATE TABLE IF NOT EXISTS shippers
(
    shipper_id integer NOT NULL,
    company_name character varying(100),
    CONSTRAINT shippers_pk PRIMARY KEY (shipper_id)
);

select from shippers;

CREATE TABLE IF NOT EXISTS employees
(
    employee_id serial NOT NULL,
    employee_name character varying(100),
    title character varying(100),
    city character varying(100),
    country character varying(100),
    reports_to integer,
    CONSTRAINT employees_pk PRIMARY KEY (employee_id)
);

select * from employees;

CREATE TABLE IF NOT EXISTS products
(
    product_id integer NOT NULL,
    product_name character varying(100),
    quantity_per_unit character varying(100),
    unit_price numeric(10, 2),
    discontinued boolean,
    category_id integer,
    CONSTRAINT products_pk PRIMARY KEY (product_id)
);

select * from products;

CREATE TABLE IF NOT EXISTS customers
(
    customer_id character varying(10) NOT NULL,
    company_name character varying(100),
    contact_name character varying(100),
    contact_title character varying(100),
    city character varying(100),
    country character varying(100),
    CONSTRAINT customers_pk PRIMARY KEY (customer_id)
);

select * from customers;

CREATE TABLE IF NOT EXISTS orders
(
    order_id integer NOT NULL,
    customer_id character varying(10),
    employee_id integer,
    order_date date,
    required_date date,
    shipped_date date,
    shipper_id integer,
    freight numeric(10, 2),
    CONSTRAINT orders_pk PRIMARY KEY (order_id)
);


CREATE TABLE IF NOT EXISTS order_details
(
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    unit_price numeric(10, 2),
    quantity integer,
    discount numeric(4, 2),
    CONSTRAINT order_details_pk PRIMARY KEY (order_id, product_id)
);


ALTER TABLE IF EXISTS orders
    ADD CONSTRAINT customer_id_fk FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id);


ALTER TABLE IF EXISTS orders
    ADD CONSTRAINT employee_id_fk FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id);


ALTER TABLE IF EXISTS orders
    ADD CONSTRAINT shipper_id_fk FOREIGN KEY (shipper_id)
    REFERENCES shippers (shipper_id);

select * from orders;


ALTER TABLE IF EXISTS order_details
    ADD CONSTRAINT orderId_fk FOREIGN KEY (order_id)
    REFERENCES orders (order_id);


ALTER TABLE IF EXISTS order_details
    ADD CONSTRAINT product_id_fk FOREIGN KEY (product_id)
    REFERENCES products (product_id);

select * from order_details;


ALTER TABLE IF EXISTS products
    ADD CONSTRAINT category_id_fk FOREIGN KEY (category_id)
    REFERENCES categories (category_id);

select * from products;
