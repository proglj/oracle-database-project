CREATE TABLE sql_profile_historico (
    id NUMBER PRIMARY KEY,
    sql_id VARCHAR2(13),
    data_captura TIMESTAMP,
    plano_execucao CLOB,
    custo_execucao NUMBER,
    tempo_cpu NUMBER
);

CREATE OR REPLACE PROCEDURE capturar_profile IS
BEGIN
    INSERT INTO sql_profile_historico
    SELECT 
        seq_profile.NEXTVAL,
        sql_id,
        SYSTIMESTAMP,
        plan_table_output,
        optimizer_cost,
        cpu_time/1000000
    FROM v$sql s
    CROSS JOIN TABLE(DBMS_XPLAN.DISPLAY_CURSOR(s.sql_id));
END;
/
