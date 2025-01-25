CREATE TABLE monitor_controlfiles (
    id NUMBER PRIMARY KEY,
    data_verificacao TIMESTAMP,
    nome_arquivo VARCHAR2(200),
    status VARCHAR2(20),
    tamanho_bytes NUMBER
);

CREATE OR REPLACE PROCEDURE verificar_controlfiles IS
BEGIN
    INSERT INTO monitor_controlfiles
    SELECT 
        seq_control.NEXTVAL,
        SYSTIMESTAMP,
        name,
        status,
        block_size * file_size_blks
    FROM v$controlfile;
END;
/
