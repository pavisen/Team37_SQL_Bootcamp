CREATE OR REPLACE FUNCTION get_stock_value_by_category(p_category_id INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    v_stock_value DECIMAL(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    INTO v_stock_value
    FROM products
    WHERE category_id = p_category_id;

    RETURN COALESCE(v_stock_value, 0.00);
END;
$$ LANGUAGE plpgsql;

SELECT get_stock_value_by_category(2);
