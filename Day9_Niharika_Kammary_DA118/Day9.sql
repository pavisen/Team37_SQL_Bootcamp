
create table product_price_audit(
audit_id serial primary key,
product_id INT,
product_name varchar(40),
old_price decimal(10,2),
new_price decimal(10,2),
change_date timestamp default current_timestamp,
user_name varchar(50) default current_user
);

/*Create a trigger function */
create or replace function log_newprice_product()
returns trigger as $$
begin
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
	return new;
end;
$$ language plpgsql;

/* Create AFTER UPDATE trigger to track product price changes*/
create trigger after_update_product
after update of unit_price on products
for each row
execute function log_newprice_product();

/* Test the trigger by updating the product price by 10% to any one product_id.*/
update products 
set unit_price = unit_price * 1.1
where product_id=1

select * from employee_tasks


/*Create table employee_tasks*/
create table if not exists employee_tasks(
task_id serial primary key,
employee_id int,
task_name varchar(50),
assigned_date date default current_date
);

/* Create stored procedure  using IN and INOUT parameters to assign tasks to employees*/
create or replace procedure Assign_Task_Employees(
in p_employee_id int,
in p_task_name varchar(50),
inout p_task_count int default 0
)
language plpgsql
as $$
begin 
   INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name); 

--Count total tasks for employee and put the total count into p_task_coun--

select 
count(*) into p_task_count
 from employee_tasks
 where employee_id = p_employee_id;
	
 raise notice 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
end;
$$;

call Assign_Task_Employees(1,'report');

DO $$
DECLARE
    task_total INT := 0;
BEGIN
    CALL Assign_Task_Employees(1, 'Review Reports', task_total);
    RAISE NOTICE 'Returned task count: %', task_total;
END;
$$;


