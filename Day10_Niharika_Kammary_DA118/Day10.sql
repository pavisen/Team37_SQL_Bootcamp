/*1.	Write  a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2)*/

CREATE OR REPLACE FUNCTION calculate_total_stock(p_category_id INT)
returns decimal(10,2) 
LANGUAGE plpgsql
AS $$
DECLARE
   v_total_stock decimal(10,2);
BEGIN
if not exists(select 1 from products where category_id = p_category_id )THEN
RAISE EXCEPTION 'CategoryID % does not exist',p_category_id;
RETURN 0;
END IF;
select 
COALESCE(ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2),0) INTO v_total_stock
FROM products
where category_id= p_category_id;

RETURN v_total_stock;

END;

$$;

select * from calculate_total_stock(199)


returns decimal(10,2) 
select * from categories
select * from orders
select * from order_details
select * from products
where category_id =199

/*2.Try writing a   cursor query which I executed in the training.*/
CREATE OR REPLACE PROCEDURE update_prices_with_cursor()
LANGUAGE plpgsql
AS $$
DECLARE
 product_cursor CURSOR FOR
 SELECT product_id,product_name,unit_price,units_in_stock
 FROM products
 WHERE discontinued = 0;

 product_record RECORD;
 v_new_price DECIMAL(10,2);
 BEGIN
 OPEN product_cursor;
 LOOP
  FETCH product_cursor INTO product_record;
  EXIT WHEN NOT FOUND;

 IF product_record.units_in_stock < 10 THEN
 v_new_price := product_record.unit_price *1.1;
 ELSE
 v_new_price := product_record.unit_price *0.95;
 END IF;
 UPDATE products
 SET unit_price = ROUND(v_new_price,2)
 WHERE product_id = product_record.product_id;
 RAISE NOTICE 'Updated % price from % to %',
 product_record.product_name,
product_record.unit_price,
v_new_price;
END LOOP;
CLOSE product_cursor;
END;
$$;

call update_prices_with_cursor();