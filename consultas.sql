-- Consultas otimizadas
CREATE PROCEDURE buscar_cliente (
    p_nome IN VARCHAR2,
    p_resultados OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_resultados FOR
    SELECT id_cliente, nome, email, data_cadastro
    FROM Clientes
    WHERE UPPER(nome) LIKE '%' || UPPER(p_nome) || '%';
END;
/
