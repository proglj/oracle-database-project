-- Índices para otimização de performance
CREATE INDEX idx_cliente_nome ON Clientes(nome);
CREATE INDEX idx_cliente_data ON Clientes(data_cadastro);

-- Estatísticas do banco
ANALYZE TABLE Clientes COMPUTE STATISTICS;

-- Índice composto para consultas frequentes
CREATE INDEX idx_cliente_nome_email ON Clientes(nome, email);
