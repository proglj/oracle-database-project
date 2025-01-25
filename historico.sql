CREATE TABLE historico_acesso (
    id NUMBER,
    usuario VARCHAR2(30),
    data_acesso TIMESTAMP,
    operacao VARCHAR2(50),
    objeto VARCHAR2(100)
)
PARTITION BY RANGE (data_acesso)
(
    PARTITION p_atual VALUES LESS THAN (MAXVALUE)
);
