-- Criação das tabelas otimizadas
CREATE TABLE Clientes (
    id_cliente NUMBER PRIMARY KEY,
    nome VARCHAR2(100),
    email VARCHAR2(100),
    data_cadastro DATE DEFAULT SYSDATE
);

CREATE INDEX idx_cliente_email ON Clientes(email);
