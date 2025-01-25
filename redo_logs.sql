CREATE TABLE monitor_redo (
    id NUMBER PRIMARY KEY,
    data TIMESTAMP,
    grupo NUMBER,
    membro VARCHAR2(100),
    status VARCHAR2(20),
    tamanho_mb NUMBER
);

CREATE OR REPLACE PROCEDURE monitorar_redo IS
BEGIN
    INSERT INTO monitor_redo
    SELECT 
        seq_redo.NEXTVAL,
        SYSTIMESTAMP,
        group#,
        member,
        status,
        bytes/1024/1024
    FROM v$logfile;
END;
/
