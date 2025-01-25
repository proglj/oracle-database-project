CREATE TABLE monitor_conexoes (
    id NUMBER PRIMARY KEY,
    data TIMESTAMP,
    total_conexoes NUMBER,
    ativas NUMBER,
    inativas NUMBER
);

CREATE OR REPLACE PROCEDURE verificar_conexoes IS
BEGIN
    INSERT INTO monitor_conexoes
    SELECT 
        seq_conexao.NEXTVAL,
        SYSTIMESTAMP,
        COUNT(*),
        SUM(DECODE(status, 'ACTIVE', 1, 0)),
        SUM(DECODE(status, 'INACTIVE', 1, 0))
    FROM v$session;
END;
/
