CREATE OR REPLACE PACKAGE pkg_manutencao IS
    PROCEDURE executar_manutencao;
    PROCEDURE registrar_manutencao(p_tipo VARCHAR2);
END;
/

CREATE OR REPLACE PACKAGE BODY pkg_manutencao IS
    PROCEDURE executar_manutencao IS
    BEGIN
        -- Executa todas as rotinas de manutenção
        otimizar_banco;
        comprimir_dados;
        limpar_logs;
        reorganizar_indices;
        registrar_manutencao('COMPLETA');
    END;
END;
/
