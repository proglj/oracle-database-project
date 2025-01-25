CREATE OR REPLACE PACKAGE pkg_relatorios AS
    -- Relatório de atividade por período
    FUNCTION gerar_relatorio_atividade(
        p_data_inicio IN DATE,
        p_data_fim IN DATE
    ) RETURN SYS_REFCURSOR;

    -- Relatório de eficiência
    FUNCTION calcular_eficiencia_queries(
        p_data IN DATE
    ) RETURN NUMBER;
END pkg_relatorios;
/
