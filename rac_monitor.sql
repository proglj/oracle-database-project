CREATE TABLE monitor_rac (
    id NUMBER PRIMARY KEY,
    data_verificacao TIMESTAMP,
    instance_name VARCHAR2(50),
    host VARCHAR2(100),
    status VARCHAR2(20),
    active_sessions NUMBER
);

CREATE OR REPLACE PROCEDURE monitorar_rac IS
BEGIN
    INSERT INTO monitor_rac
    SELECT 
        seq_rac.NEXTVAL,
        SYSTIMESTAMP,
        instance_name,
        host_name,
        status,
        active_state
    FROM gv$instance;
END;
/
