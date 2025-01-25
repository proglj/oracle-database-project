-- Tabela de parâmetros do sistema
CREATE TABLE parametros_sistema (
    id NUMBER PRIMARY KEY,
    nome VARCHAR2(50),
    valor VARCHAR2(100),
    descricao VARCHAR2(200)
);

-- Procedure para gerenciar parâmetros
CREATE OR REPLACE PROCEDURE atualizar_parametro (
    p_nome IN VARCHAR2,
    p_valor IN VARCHAR2
) IS
BEGIN
    UPDATE parametros_sistema
    SET valor = p_valor
    WHERE nome = p_nome;
    COMMIT;
END;
/
