BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name => 'JOB_MANUTENCAO',
        job_type => 'PLSQL_BLOCK',
        job_action => '
            BEGIN
                otimizar_banco;
                coletar_estatisticas;
                limpar_dados_antigos;
                refresh_materializadas;
            END;',
        repeat_interval => 'FREQ=DAILY;BYHOUR=1;BYMINUTE=0;BYSECOND=0',
        enabled => TRUE
    );
END;
/
