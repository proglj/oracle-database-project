-- Procedure de limpeza e manutenção
CREATE OR REPLACE PROCEDURE limpar_dados_antigos IS
BEGIN
    DELETE FROM log_acessos 
    WHERE data_acesso < ADD_MONTHS(SYSDATE, -6);
    
    DELETE FROM metricas_desempenho 
    WHERE data_coleta < ADD_MONTHS(SYSDATE, -3);
    
    COMMIT;
END;
/
