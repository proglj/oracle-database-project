CREATE OR REPLACE PACKAGE pkg_gestao_clientes AS
    -- Tipos
    TYPE t_ref_cursor IS REF CURSOR;
    
    -- Funções e Procedures
    PROCEDURE inserir_cliente(p_nome IN VARCHAR2, p_email IN VARCHAR2);
    FUNCTION buscar_cliente(p_id IN NUMBER) RETURN t_ref_cursor;
    PROCEDURE atualizar_cliente(p_id IN NUMBER, p_nome IN VARCHAR2);
    FUNCTION gerar_relatorio RETURN t_ref_cursor;
END pkg_gestao_clientes;
/
