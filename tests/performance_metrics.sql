-- Script para coleta e análise de métricas de performance
-- Este script monitora diversos aspectos do desempenho do banco de dados

-- Tabela principal para armazenar métricas
CREATE TABLE metricas_performance (
    id_metrica NUMBER PRIMARY KEY,
    data_coleta TIMESTAMP,
    tipo_metrica VARCHAR2(50),
    valor_metrica NUMBER,
    descricao VARCHAR2(200)
);

-- Sequence para as métricas
CREATE SEQUENCE seq_metrica START WITH 1;

-- Procedure principal para coleta de métricas
CREATE OR REPLACE PROCEDURE coletar_metricas_performance IS
    -- Variáveis para armazenar métricas temporárias
    v_buffer_hit_ratio NUMBER;
    v_cpu_usage NUMBER;
    v_io_stats NUMBER;
    v_session_count NUMBER;
    v_active_transactions NUMBER;
BEGIN
    -- Coleta taxa de acerto do buffer cache
    SELECT (1 - (physical_reads / (db_block_gets + consistent_gets))) * 100
    INTO v_buffer_hit_ratio
    FROM v$buffer_pool_statistics
    WHERE name = 'DEFAULT';
    
    -- Registra métrica do buffer
    INSERT INTO metricas_performance VALUES (
        seq_metrica.NEXTVAL,
        SYSTIMESTAMP,
        'BUFFER_HIT_RATIO',
        v_buffer_hit_ratio,
        'Taxa de acerto do buffer cache em porcentagem'
    );
    
    -- Coleta uso de CPU
    SELECT value INTO v_cpu_usage
    FROM v$sysstat
    WHERE name = 'CPU used by this session';
    
    -- Registra métrica de CPU
    INSERT INTO metricas_performance VALUES (
        seq_metrica.NEXTVAL,
        SYSTIMESTAMP,
        'CPU_USAGE',
        v_cpu_usage,
        'Uso de CPU pela sessão atual'
    );
    
    -- Coleta estatísticas de I/O
    SELECT physical_reads + physical_writes INTO v_io_stats
    FROM v$buffer_pool_statistics
    WHERE name = 'DEFAULT';
    
    -- Registra métrica de I/O
    INSERT INTO metricas_performance VALUES (
        seq_metrica.NEXTVAL,
        SYSTIMESTAMP,
        'IO_OPERATIONS',
        v_io_stats,
        'Total de operações de I/O físicas'
    );
    
    -- Coleta número de sessões ativas
    SELECT COUNT(*) INTO v_session_count
    FROM v$session
    WHERE status = 'ACTIVE';
    
    -- Registra métrica de sessões
    INSERT INTO metricas_performance VALUES (
        seq_metrica.NEXTVAL,
        SYSTIMESTAMP,
        'ACTIVE_SESSIONS',
        v_session_count,
        'Número de sessões ativas no momento'
    );
    
    -- Coleta número de transações ativas
    SELECT COUNT(*) INTO v_active_transactions
    FROM v$transaction;
    
    -- Registra métrica de transações
    INSERT INTO metricas_performance VALUES (
        seq_metrica.NEXTVAL,
        SYSTIMESTAMP,
        'ACTIVE_TRANSACTIONS',
        v_active_transactions,
        'Número de transações ativas'
    );
    
    -- Commit das métricas
    COMMIT;
    
    -- Gera relatório das métricas coletadas
    DBMS_OUTPUT.PUT_LINE('=== Relatório de Métricas de Performance ===');
    DBMS_OUTPUT.PUT_LINE('Buffer Hit Ratio: ' || ROUND(v_buffer_hit_ratio, 2) || '%');
    DBMS_OUTPUT.PUT_LINE('Uso de CPU: ' || v_cpu_usage);
    DBMS_OUTPUT.PUT_LINE('Operações I/O: ' || v_io_stats);
    DBMS_OUTPUT.PUT_LINE('Sessões Ativas: ' || v_session_count);
    DBMS_OUTPUT.PUT_LINE('Transações Ativas: ' || v_active_transactions);
END;
/

-- Procedure para analisar tendências
CREATE OR REPLACE PROCEDURE analisar_tendencias IS
BEGIN
    -- Análise de tendências do último dia
    FOR r IN (
        SELECT 
            tipo_metrica,
            ROUND(AVG(valor_metrica), 2) media,
            ROUND(MIN(valor_metrica), 2) minimo,
            ROUND(MAX(valor_metrica), 2) maximo,
            ROUND(STDDEV(valor_metrica), 2) desvio_padrao
        FROM metricas_performance
        WHERE data_coleta > SYSDATE - 1
        GROUP BY tipo_metrica
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Métrica: ' || r.tipo_metrica);
        DBMS_OUTPUT.PUT_LINE('Média: ' || r.media);
        DBMS_OUTPUT.PUT_LINE('Mínimo: ' || r.minimo);
        DBMS_OUTPUT.PUT_LINE('Máximo: ' || r.maximo);
        DBMS_OUTPUT.PUT_LINE('Desvio Padrão: ' || r.desvio_padrao);
        DBMS_OUTPUT.PUT_LINE('---');
    END LOOP;
END;
/

-- Executa coleta inicial de métricas
EXEC coletar_metricas_performance;

-- Analisa tendências
EXEC analisar_tendencias;
