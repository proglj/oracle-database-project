CREATE TABLE logs_sistema (
    id_log NUMBER PRIMARY KEY,
    data_log DATE,
    tipo VARCHAR2(50),
    mensagem VARCHAR2(4000),
    nivel VARCHAR2(20)
);

CREATE OR REPLACE PROCEDURE registrar_log (
    p_tipo IN VARCHAR2,
    p_mensagem IN VARCHAR2,
    p_nivel IN VARCHAR2
) IS
BEGIN
    INSERT INTO logs_sistema VALUES (
        seq_log.NEXTVAL,
        SYSDATE,
        p_tipo,
        p_mensagem,
        p_nivel
    );
    COMMIT;
END;
/
