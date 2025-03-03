CREATE SEQUENCE seq_cliente START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_pedido START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_log START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_cliente_seq
BEFORE INSERT ON Clientes
FOR EACH ROW
BEGIN
    :NEW.id_cliente := seq_cliente.NEXTVAL;
END;
/
