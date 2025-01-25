-- Principais queries de otimização
CREATE OR REPLACE PROCEDURE otimizar_banco IS
BEGIN
    -- Reorganiza índices
    FOR r IN (SELECT index_name FROM user_indexes) LOOP
        EXECUTE IMMEDIATE 'ALTER INDEX ' || r.index_name || ' REBUILD';
    END LOOP;
    
    -- Atualiza estatísticas
    DBMS_STATS.GATHER_SCHEMA_STATS(
        ownname => USER,
        estimate_percent => 100,
        degree => DBMS_STATS.AUTO_DEGREE
    );
END;
/
