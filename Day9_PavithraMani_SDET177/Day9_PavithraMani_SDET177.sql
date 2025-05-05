-- 1.      Create AFTER UPDATE trigger to track product price changes
-- Create the product_price_audit Table
CREATE TABLE PRODUCT_PRICE_AUDIT (
	AUDIT_ID SERIAL PRIMARY KEY,
	PRODUCT_ID INT,
	PRODUCT_NAME VARCHAR(40),
	OLD_PRICE DECIMAL(10, 2),
	NEW_PRICE DECIMAL(10, 2),
	CHANGE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	USER_NAME VARCHAR(50) DEFAULT CURRENT_USER
);

--Create the Trigger Function
CREATE
OR REPLACE FUNCTION TRACK_PRICE_CHANGES () RETURNS TRIGGER AS $$
BEGIN
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
    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

-- Create the Trigger on products Table
CREATE TRIGGER TRG_AFTER_PRICE_UPDATE
AFTER
UPDATE OF UNIT_PRICE ON PRODUCTS FOR EACH ROW WHEN (OLD.UNIT_PRICE IS DISTINCT FROM NEW.UNIT_PRICE)
EXECUTE FUNCTION TRACK_PRICE_CHANGES ();

--Update To verify  the Trigger
UPDATE PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.1
WHERE
	PRODUCT_ID = 1;

--check the audit log to verify
SELECT
	*
FROM
	PRODUCT_PRICE_AUDIT
ORDER BY
	CHANGE_DATE DESC;

--------------------------------------------------------------------------------------------------------------
-- 2.      Create stored procedure  using IN and INOUT parameters to assign tasks to employees
-- Create employee_tasks Table
CREATE TABLE IF NOT EXISTS EMPLOYEE_TASKS (
	TASK_ID SERIAL PRIMARY KEY,
	EMPLOYEE_ID INT,
	TASK_NAME VARCHAR(50),
	ASSIGNED_DATE DATE DEFAULT CURRENT_DATE
);

--Create the Stored Procedure
CREATE
OR REPLACE PROCEDURE ASSIGN_TASK (
	IN P_EMPLOYEE_ID INT,
	IN P_TASK_NAME VARCHAR(50),
	INOUT P_TASK_COUNT INT DEFAULT 0
) LANGUAGE PLPGSQL AS $$
BEGIN
    -- Insert new task for the employee
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);

    -- Count total tasks assigned to the employee
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

    -- Show notice message
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;

--Define a variable here and 
-- To Call the Procedure to Test
DO $$
DECLARE
    task_total INT := 0;
BEGIN
    CALL assign_task(1, 'Review Reports', task_total);
    RAISE NOTICE 'Returned task count: %', task_total;
END;
$$;

----------------------------------------------------------------------------
