-- Controles de segurança e auditoria
CREATE TABLE log_acessos (
    id_log NUMBER PRIMARY KEY,
    usuario VARCHAR2(30),
    data_acesso DATE,
    tipo_operacao VARCHAR2(10),
    tabela VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER trg_auditoria_seguranca
AFTER DDL ON SCHEMA
BEGIN
    INSERT INTO log_acessos VALUES (
        seq_log.NEXTVAL,
        SYS_CONTEXT('USERENV', 'SESSION_USER'),
        SYSDATE,
        ora_sysevent,
        ora_dict_obj_name
    );
END;
/
