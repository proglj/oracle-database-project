CREATE TABLE controle_etl (
    id NUMBER PRIMARY KEY,
    processo VARCHAR2(50),
    inicio TIMESTAMP,
    fim TIMESTAMP,
    status VARCHAR2(20),
    registros_processados NUMBER
);

CREATE OR REPLACE PROCEDURE executar_etl(p_processo VARCHAR2) IS
    v_id NUMBER;
BEGIN
    v_id := seq_etl.NEXTVAL;
    
    INSERT INTO controle_etl (id, processo, inicio, status)
    VALUES (v_id, p_processo, SYSTIMESTAMP, 'EM_EXECUCAO');
    
    COMMIT;
END;
/
