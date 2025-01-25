CREATE OR REPLACE PACKAGE pkg_espaco IS
    PROCEDURE verificar_espaco;
    PROCEDURE limpar_espacos;
END;
/

CREATE OR REPLACE PACKAGE BODY pkg_espaco IS
    PROCEDURE verificar_espaco IS
    BEGIN
        INSERT INTO monitor_espaco
        SELECT tablespace_name,
               SUM(bytes)/1024/1024 MB,
               SUM(maxbytes)/1024/1024 MAX_MB
        FROM dba_data_files
        GROUP BY tablespace_name;
    END;
END;
/
