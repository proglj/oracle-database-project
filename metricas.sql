CREATE TABLE metricas_desempenho (
    id_metrica NUMBER PRIMARY KEY,
    data_coleta DATE,
    tempo_processamento NUMBER,
    total_consultas NUMBER,
    media_tempo_resposta NUMBER
);

CREATE OR REPLACE PROCEDURE coletar_metricas IS
BEGIN
    INSERT INTO metricas_desempenho VALUES (
        seq_metrica.NEXTVAL,
        SYSDATE,
        dbms_utility.get_time,
        (SELECT COUNT(*) FROM v$sql),
        (SELECT AVG(elapsed_time) FROM v$sql)
    );
    COMMIT;
END;
/
