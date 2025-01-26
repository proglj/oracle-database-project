CREATE TABLE metricas_ux (
    id NUMBER PRIMARY KEY,
    metrica VARCHAR2(50),
    valor NUMBER,
    data_captura TIMESTAMP
);

CREATE OR REPLACE PROCEDURE medir_ux IS
BEGIN
    INSERT INTO metricas_ux VALUES (
        seq_ux.NEXTVAL,
        'TEMPO_MEDIO_QUERY',
        (SELECT AVG(elapsed_time/1000000) FROM v$sql),
        SYSTIMESTAMP
    );
END;
/
