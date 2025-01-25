CREATE TABLE tarefas_automatizadas (
    id NUMBER PRIMARY KEY,
    nome VARCHAR2(100),
    periodicidade VARCHAR2(50),
    ultima_execucao TIMESTAMP,
    status VARCHAR2(20)
);

BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE (
        schedule_name => 'SCH_DIARIO',
        start_date => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY;BYHOUR=0'
    );
END;
/
