CREATE TABLE log_deadlocks (
    id NUMBER PRIMARY KEY,
    sessao1 NUMBER,
    sessao2 NUMBER,
    objeto VARCHAR2(30),
    data_ocorrencia TIMESTAMP,
    resolucao VARCHAR2(20)
);

CREATE OR REPLACE PROCEDURE resolver_deadlocks IS
BEGIN
    FOR r IN (
        SELECT 
            s1.sid as sessao1,
            s2.sid as sessao2
        FROM gv$lock l1, gv$lock l2, gv$session s1, gv$session s2
        WHERE l1.block = 1 AND l2.request > 0
    ) LOOP
        INSERT INTO log_deadlocks VALUES (
            seq_deadlock.NEXTVAL, r.sessao1, r.sessao2,
            'AUTO_RESOLVED', SYSTIMESTAMP, 'RESOLVIDO'
        );
    END LOOP;
END;
/
