-- Administração e manutenção do banco
CREATE OR REPLACE PACKAGE pkg_admin IS
    PROCEDURE reorganizar_tablespace;
    PROCEDURE verificar_fragmentacao;
    PROCEDURE limpar_temp;
    PROCEDURE gerar_relatorio_espaco;
END pkg_admin;
/

CREATE OR REPLACE PACKAGE BODY pkg_admin IS
    PROCEDURE reorganizar_tablespace IS
    BEGIN
        FOR r IN (SELECT tablespace_name FROM dba_tablespaces) LOOP
            EXECUTE IMMEDIATE 'ALTER TABLESPACE ' || r.tablespace_name || ' COALESCE';
        END LOOP;
    END;
END pkg_admin;
/
