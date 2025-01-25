CREATE OR REPLACE PROCEDURE sincronizar_dados IS
    cursor_dados SYS_REFCURSOR;
BEGIN
    OPEN cursor_dados FOR
        SELECT * FROM Clientes@db_link_remoto
        MINUS
        SELECT * FROM Clientes;
        
    INSERT INTO Clientes
    SELECT * FROM TABLE(FETCH_ROWS(cursor_dados));
    
    COMMIT;
END;
/
