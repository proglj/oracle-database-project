-- Gerenciamento de cache
CREATE OR REPLACE PROCEDURE gerenciar_cache IS
BEGIN
    -- Ajusta parâmetros de cache
    ALTER SYSTEM SET db_cache_size = '1G';
    ALTER SYSTEM SET shared_pool_size = '500M';
    
    -- Monitora hit ratio
    INSERT INTO cache_stats (
        data_coleta,
        buffer_hit_ratio,
        shared_pool_hit_ratio
    )
    SELECT 
        SYSDATE,
        (1 - (phy.value / (cur.value + con.value))) * 100,
        (1 - (reload.value / (pins.value + reloads.value))) * 100
    FROM v$sysstat phy, v$sysstat cur, v$sysstat con;
END;
/
