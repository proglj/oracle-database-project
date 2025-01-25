CREATE TABLE auditoria (
    id NUMBER PRIMARY KEY,
    usuario VARCHAR2(30),
    data TIMESTAMP,
    operacao VARCHAR2(10),
    tabela VARCHAR2(30),
    valor_antigo CLOB,
    valor_novo CLOB
);

CREATE OR REPLACE TRIGGER trg_auditoria_dados
AFTER INSERT OR UPDATE OR DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria VALUES (
        seq_auditoria.NEXTVAL,
        USER,
        SYSTIMESTAMP,
        CASE 
            WHEN INSERTING THEN 'INSERT'
            WHEN UPDATING THEN 'UPDATE'
            WHEN DELETING THEN 'DELETE'
        END,
        'CLIENTES',
        :OLD.nome,
        :NEW.nome
    );
END;
/
