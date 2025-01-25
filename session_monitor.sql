CREATE TABLE monitor_sessao (
    id NUMBER,
    data_inicio TIMESTAMP,
    sid NUMBER,
    username VARCHAR2(30),
    programa VARCHAR2(100),
    status VARCHAR2(20),
    tempo_execucao NUMBER
);

CREATE OR REPLACE PROCEDURE monitorar_sessoes IS
BEGIN
    INSERT INTO monitor_sessao
    SELECT 
        seq_monitor.NEXTVAL,
        SYSTIMESTAMP,
        sid,
        username,
        program,
        status,
        last_call_et
    FROM v$session
    WHERE type != 'BACKGROUND';
END;
/
