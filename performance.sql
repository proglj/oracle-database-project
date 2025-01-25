-- Análise de performance e otimização
CREATE OR REPLACE PROCEDURE analisar_performance IS 
BEGIN
    -- Atualiza estatísticas
    DBMS_STATS.GATHER_SCHEMA_STATS(
        ownname => USER,
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        method_opt => 'FOR ALL COLUMNS SIZE AUTO'
    );
    
    -- Registra métricas
    INSERT INTO metricas_performance (
        data_analise,
        tempo_medio_consulta,
        total_registros
    )
    SELECT 
        SYSDATE,
        AVG(elapsed_time)/1000000,
        SUM(executions)
    FROM v$sql 
    WHERE parsing_schema_name = USER;
    
    COMMIT;
END;
/
