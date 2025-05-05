CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    productid INT,
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE OR REPLACE FUNCTION log_price_change()
RETURNS TRIGGER AS $$
BEGIN
    -- Only log if the price actually changed
    IF OLD.unitprice IS DISTINCT FROM NEW.unitprice THEN
        INSERT INTO product_price_audit (productid, old_price, new_price)
        VALUES (OLD.productid, OLD.unitprice, NEW.unitprice);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
select * from products;
CREATE TRIGGER trg_price_change
AFTER UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION log_price_change();


DROP TABLE product_price_audit;

CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);
select * from product_price_audit;

CREATE OR REPLACE FUNCTION log_product_price_change()
RETURNS TRIGGER AS $$
BEGIN
    -- Only log if the price has actually changed
    IF OLD.unit_price IS DISTINCT FROM NEW.unit_price THEN
        INSERT INTO product_price_audit (
            product_id,
            product_name,
            old_price,
            new_price
        )
        VALUES (
            OLD.product_id,
            OLD.product_name,
            OLD.unit_price,
            NEW.unit_price
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_unit_price_change
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION log_product_price_change();

select * from products;

UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 3; 

SELECT * FROM product_price_audit
ORDER BY change_date DESC
LIMIT 5;

CREATE OR REPLACE PROCEDURE assign_task_to_employee(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
  
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);

   
    SELECT COUNT(*)
    INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

  
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;
DO $$
DECLARE
    task_total INT := 0;
BEGIN
    CALL assign_task_to_employee(101, 'Submit Status Report', task_total);
END;
$$;

SELECT * FROM information_schema.tables 
WHERE table_name = 'employee_tasks';

CREATE TABLE employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);
DO $$
DECLARE
    task_total INT := 0;
BEGIN
    CALL assign_task_to_employee(101, 'Submit Status Report', task_total);
END;
$$;

select * from employee_tasks;

