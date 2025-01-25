-- Backup lógico das tabelas principais
CREATE OR REPLACE PROCEDURE realizar_backup_diario IS
    v_data VARCHAR2(8);
BEGIN
    v_data := TO_CHAR(SYSDATE, 'YYYYMMDD');
    
    EXECUTE IMMEDIATE 'CREATE TABLE BACKUP_CLIENTES_' || v_data || 
    ' AS SELECT * FROM CLIENTES';
    
    INSERT INTO LOG_BACKUP (
        data_backup,
        tabela,
        registros
    ) VALUES (
        SYSDATE,
        'CLIENTES',
        SQL%ROWCOUNT
    );
    COMMIT;
END;
/
