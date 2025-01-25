CREATE OR REPLACE FUNCTION calcular_valor_total_cliente (
    p_id_cliente IN NUMBER
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(valor_total), 0)
    INTO v_total
    FROM Pedidos
    WHERE id_cliente = p_id_cliente;
    
    RETURN v_total;
END;
/
