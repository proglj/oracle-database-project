CREATE TABLE estatisticas_sistema (
    data_coleta DATE,
    total_registros NUMBER,
    media_tempo_resposta NUMBER,
    espaco_utilizado NUMBER
);

CREATE OR REPLACE PROCEDURE coletar_estatisticas IS
BEGIN
    INSERT INTO estatisticas_sistema 
    SELECT 
        SYSDATE,
        COUNT(*),
        AVG(elapsed_time),
        SUM(bytes)/1024/1024
    FROM user_segments;
    COMMIT;
END;
/
