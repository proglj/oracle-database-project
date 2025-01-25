CREATE OR REPLACE PACKAGE pkg_memory IS
    PROCEDURE ajustar_memoria(
        p_sga_size IN VARCHAR2,
        p_pga_size IN VARCHAR2
    );
    
    PROCEDURE monitorar_uso_memoria;
END;
/

CREATE OR REPLACE PACKAGE BODY pkg_memory IS
    PROCEDURE ajustar_memoria (
        p_sga_size IN VARCHAR2,
        p_pga_size IN VARCHAR2
    ) IS
    BEGIN
        ALTER SYSTEM SET sga_target = p_sga_size;
        ALTER SYSTEM SET pga_aggregate_target = p_pga_size;
    END;
END;
/
