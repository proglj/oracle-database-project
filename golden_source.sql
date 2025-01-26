CREATE TABLE golden_source (
    id NUMBER PRIMARY KEY,
    objeto VARCHAR2(100),
    ultima_sync TIMESTAMP,
    status VARCHAR2(20),
    checksum VARCHAR2(64)
);

CREATE OR REPLACE PROCEDURE sincronizar_golden IS
BEGIN
    MERGE INTO golden_source g
    USING (SELECT object_name, last_ddl_time 
           FROM user_objects) o
    ON (g.objeto = o.object_name)
    WHEN MATCHED THEN UPDATE SET g.ultima_sync = SYSTIMESTAMP
    WHEN NOT MATCHED THEN INSERT (id, objeto, ultima_sync)
    VALUES (seq_golden.NEXTVAL, o.object_name, SYSTIMESTAMP);
END;
/
