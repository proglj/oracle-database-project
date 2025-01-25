CREATE OR REPLACE TRIGGER trg_auditoria_cliente
AFTER INSERT OR UPDATE OR DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria_Clientes (
        operacao,
        id_cliente,
        data_operacao,
        usuario
    ) VALUES (
        CASE
            WHEN INSERTING THEN 'I'
            WHEN UPDATING THEN 'U'
            WHEN DELETING THEN 'D'
        END,
        :NEW.id_cliente,
        SYSDATE,
        USER
    );
END;
/
