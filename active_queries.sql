CREATE TABLE monitor_queries (
    id NUMBER PRIMARY KEY,
    data_captura TIMESTAMP,
    sql_id VARCHAR2(13),
    tempo_execucao NUMBER,
    cpu_used NUMBER,
    status VARCHAR2(20)
);

CREATE OR REPLACE PROCEDURE monitorar_queries IS
BEGIN
    INSERT INTO monitor_queries
    SELECT 
        seq_query.NEXTVAL,
        SYSTIMESTAMP,
        sql_id,
        elapsed_time/1000000,
        cpu_time/1000000,
        status
    FROM v$sql_monitor
    WHERE status = 'EXECUTING';
END;
/
