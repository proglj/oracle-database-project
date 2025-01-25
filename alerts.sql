CREATE TABLE alertas_sistema (
    id_alerta NUMBER PRIMARY KEY,
    data_ocorrencia TIMESTAMP,
    tipo_alerta VARCHAR2(50),
    mensagem VARCHAR2(4000),
    status VARCHAR2(20)
);

CREATE OR REPLACE TRIGGER trg_performance_baixa
AFTER INSERT ON metricas_desempenho
FOR EACH ROW
WHEN (NEW.tempo_processamento > 1000)
BEGIN
    INSERT INTO alertas_sistema VALUES (
        seq_alerta.NEXTVAL,
        SYSTIMESTAMP,
        'PERFORMANCE',
        'Tempo de processamento crítico: ' || :NEW.tempo_processamento,
        'NOVO'
    );
END;
/
