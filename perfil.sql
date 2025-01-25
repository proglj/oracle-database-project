CREATE TABLE perfil_usuario (
    id NUMBER PRIMARY KEY,
    nome VARCHAR2(50),
    nivel_acesso NUMBER(1),
    autorizacoes VARCHAR2(1000)
);

CREATE OR REPLACE PROCEDURE definir_perfil (
    p_usuario VARCHAR2,
    p_nivel NUMBER
) IS
BEGIN
    INSERT INTO perfil_usuario (id, nome, nivel_acesso)
    VALUES (seq_perfil.NEXTVAL, p_usuario, p_nivel);
END;
/
