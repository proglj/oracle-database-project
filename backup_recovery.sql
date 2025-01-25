CREATE OR REPLACE PROCEDURE backup_completo IS
BEGIN
    RMAN 
    BACKUP DATABASE PLUS ARCHIVELOG
    TAG 'BACKUP_COMPLETO'
    FORMAT '/backup/full_%d_%T_%s_%p';
    
    INSERT INTO backup_log VALUES (
        seq_backup.NEXTVAL,
        SYSDATE,
        'COMPLETO',
        'CONCLUIDO'
    );
END;
/
