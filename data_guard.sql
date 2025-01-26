CREATE TABLE monitor_dataguard (
    id NUMBER PRIMARY KEY,
    data_verificacao TIMESTAMP,
    status VARCHAR2(30),
    gap_segundos NUMBER,
    role VARCHAR2(20)
);

CREATE OR REPLACE PROCEDURE verificar_dataguard IS
BEGIN
    INSERT INTO monitor_dataguard
    SELECT 
        seq_dg.NEXTVAL,
        SYSTIMESTAMP,
        database_role,
        transport_lag,
        protection_mode
    FROM v$database, v$dataguard_stats;
END;
/
