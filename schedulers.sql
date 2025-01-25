CREATE OR REPLACE PACKAGE pkg_schedulers IS
    -- Agenda tarefas de manutenção
    PROCEDURE agendar_manutencao;
    
    -- Define jobs diários
    PROCEDURE criar_jobs_diarios;
END pkg_schedulers;
/

CREATE OR REPLACE PACKAGE BODY pkg_schedulers IS
    PROCEDURE agendar_manutencao IS
    BEGIN
        DBMS_SCHEDULER.CREATE_JOB (
            job_name => 'JOB_MANUTENCAO',
            job_type => 'STORED_PROCEDURE',
            job_action => 'otimizar_banco',
            start_date => SYSTIMESTAMP,
            repeat_interval => 'FREQ=DAILY;BYHOUR=23'
        );
    END;
END pkg_schedulers;
/
