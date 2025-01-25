CREATE OR REPLACE PACKAGE pkg_dimensionamento IS
    PROCEDURE calcular_crescimento_tabelas;
    PROCEDURE estimar_espaco_necessario;
    PROCEDURE recomendar_config;
END;
/

CREATE OR REPLACE PACKAGE BODY pkg_dimensionamento IS
    PROCEDURE calcular_crescimento_tabelas IS
    BEGIN
        INSERT INTO dimensionamento_tabelas
        SELECT 
            table_name,
            num_rows,
            blocks * 8192 / 1024 / 1024 "MB",
            SYSDATE
        FROM user_tables;
    END;
END;
/
