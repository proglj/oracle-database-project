CREATE OR REPLACE PROCEDURE monitorar_sistema IS
    v_qtd_sessoes NUMBER;
    v_qtd_locks NUMBER;
    v_uso_cpu NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_qtd_sessoes FROM v$session;
    SELECT COUNT(*) INTO v_qtd_locks FROM v$lock;
    
    INSERT INTO monitoramento VALUES (
        seq_monitoramento.NEXTVAL,
        SYSDATE,
        v_qtd_sessoes,
        v_qtd_locks,
        v_uso_cpu
    );
    COMMIT;
END;
/
