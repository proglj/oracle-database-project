CREATE TABLE monitor_archive (
    id NUMBER PRIMARY KEY,
    data TIMESTAMP,
    arquivo_log VARCHAR2(200),
    tamanho_mb NUMBER,
    status VARCHAR2(20)
);

CREATE OR REPLACE PROCEDURE gerenciar_archive IS
BEGIN
    INSERT INTO monitor_archive
    SELECT 
        seq_archive.NEXTVAL,
        SYSTIMESTAMP,
        name,
        blocks * block_size / 1024 / 1024,
        'ATIVO'
    FROM v$archived_log
    WHERE TRUNC(completion_time) = TRUNC(SYSDATE);
END;
/
