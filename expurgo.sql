CREATE OR REPLACE PROCEDURE expurgar_dados IS
BEGIN
    -- Remove dados antigos
    DELETE FROM log_acessos WHERE data_acesso < ADD_MONTHS(SYSDATE, -12);
    DELETE FROM metricas_desempenho WHERE data_coleta < ADD_MONTHS(SYSDATE, -6);
    DELETE FROM auditoria_clientes WHERE data_operacao < ADD_MONTHS(SYSDATE, -12);
    
    -- Compacta tabelas
    FOR r IN (SELECT table_name FROM user_tables) LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE ' || r.table_name || ' SHRINK SPACE';
    END LOOP;
    
    COMMIT;
END;
/
