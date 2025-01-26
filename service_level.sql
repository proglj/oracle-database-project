CREATE TABLE sla_monitor (
    id NUMBER PRIMARY KEY,
    servico VARCHAR2(50),
    tempo_resposta NUMBER,
    disponibilidade NUMBER,
    data_medicao TIMESTAMP
);

CREATE OR REPLACE PROCEDURE verificar_sla IS
BEGIN
    INSERT INTO sla_monitor
    SELECT 
        seq_sla.NEXTVAL,
        'DATABASE',
        AVG(elapsed_time)/1000000,
        ROUND((uptime/total_time)*100, 2),
        SYSTIMESTAMP
    FROM v$instance_recovery;
END;
/
