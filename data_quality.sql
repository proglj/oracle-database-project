CREATE TABLE metricas_qualidade (
    id NUMBER PRIMARY KEY,
    tabela VARCHAR2(30),
    total_registros NUMBER,
    nulos NUMBER,
    duplicados NUMBER,
    data_analise TIMESTAMP
);

CREATE OR REPLACE PROCEDURE analisar_qualidade IS
BEGIN
    FOR r IN (SELECT table_name FROM user_tables) LOOP
        EXECUTE IMMEDIATE 
        'INSERT INTO metricas_qualidade
        SELECT seq_qualidade.NEXTVAL, :1, COUNT(*),
        SUM(CASE WHEN nome IS NULL THEN 1 ELSE 0 END),
        COUNT(*) - COUNT(DISTINCT id),
        SYSTIMESTAMP
        FROM ' || r.table_name
        USING r.table_name;
    END LOOP;
END;
/
