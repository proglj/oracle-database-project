CREATE TABLE flashback_log (
    id NUMBER PRIMARY KEY,
    data_operacao TIMESTAMP,
    operacao VARCHAR2(20),
    objeto VARCHAR2(100),
    scn NUMBER
);

CREATE OR REPLACE PROCEDURE gerenciar_flashback IS
BEGIN
    INSERT INTO flashback_log
    SELECT 
        seq_flash.NEXTVAL,
        SYSTIMESTAMP,
        operation,
        table_name,
        scn
    FROM flashback_transaction_query;
END;
/
