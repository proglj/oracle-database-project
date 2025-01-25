CREATE OR REPLACE PACKAGE pkg_compress IS
    PROCEDURE comprimir_tabela(p_tabela VARCHAR2);
    PROCEDURE comprimir_particao(p_tabela VARCHAR2, p_particao VARCHAR2);
END;
/

CREATE OR REPLACE PACKAGE BODY pkg_compress IS
    PROCEDURE comprimir_tabela(p_tabela VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE ' || p_tabela || ' COMPRESS FOR OLTP';
    END;
END;
/
