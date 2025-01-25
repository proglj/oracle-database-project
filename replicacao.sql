CREATE OR REPLACE PROCEDURE configurar_replicacao IS
BEGIN
    DBMS_REPCAT.CREATE_MASTER_REPGROUP(
        gname => 'grupo_replicacao'
    );
    
    DBMS_REPCAT.CREATE_MASTER_REPOBJECT(
        gname => 'grupo_replicacao',
        type => 'TABLE',
        oname => 'CLIENTES'
    );
    
    COMMIT;
END;
/
