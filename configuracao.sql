CREATE OR REPLACE PACKAGE pkg_configuracao IS
    TYPE t_parametros IS TABLE OF parametros_sistema%ROWTYPE;
    
    FUNCTION obter_configuracoes RETURN t_parametros;
    PROCEDURE atualizar_configuracao(
        p_nome IN VARCHAR2,
        p_valor IN VARCHAR2
    );
END;
/

CREATE OR REPLACE PACKAGE BODY pkg_configuracao IS
    FUNCTION obter_configuracoes RETURN t_parametros PIPELINED IS
        l_parametro parametros_sistema%ROWTYPE;
    BEGIN
        FOR r IN (SELECT * FROM parametros_sistema) LOOP
            PIPE ROW(r);
        END LOOP;
        RETURN;
    END;
END;
/
