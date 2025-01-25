-- Particionamento de tabelas grandes
CREATE TABLE historico_clientes (
    id NUMBER,
    data_evento DATE,
    tipo_evento VARCHAR2(30),
    descricao VARCHAR2(200)
)
PARTITION BY RANGE (data_evento)
(
    PARTITION hist_2023 VALUES LESS THAN (TO_DATE('2024-01-01', 'YYYY-MM-DD')),
    PARTITION hist_2024 VALUES LESS THAN (TO_DATE('2025-01-01', 'YYYY-MM-DD')),
    PARTITION hist_futuro VALUES LESS THAN (MAXVALUE)
);

-- Índices locais por partição
CREATE INDEX idx_hist_data ON historico_clientes(data_evento) LOCAL;
