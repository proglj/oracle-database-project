CREATE TABLE notificacoes (
    id NUMBER PRIMARY KEY,
    tipo VARCHAR2(50),
    mensagem VARCHAR2(4000),
    status VARCHAR2(20),
    data_criacao TIMESTAMP
);

CREATE OR REPLACE TRIGGER trg_notificar_admin
AFTER INSERT ON alertas_sistema
FOR EACH ROW
BEGIN
    INSERT INTO notificacoes VALUES (
        seq_notificacao.NEXTVAL,
        'ALERTA',
        :NEW.mensagem,
        'PENDENTE',
        SYSTIMESTAMP
    );
END;
/
