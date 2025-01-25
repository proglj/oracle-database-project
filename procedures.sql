-- Procedures otimizadas
CREATE OR REPLACE PROCEDURE inserir_cliente (
    p_nome IN VARCHAR2,
    p_email IN VARCHAR2,
    p_id_cliente OUT NUMBER
) IS
BEGIN
    SELECT NVL(MAX(id_cliente), 0) + 1 INTO p_id_cliente FROM Clientes;
    
    INSERT INTO Clientes (id_cliente, nome, email)
    VALUES (p_id_cliente, p_nome, p_email);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
