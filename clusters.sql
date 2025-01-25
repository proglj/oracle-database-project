CREATE CLUSTER cluster_cliente (
    id_cliente NUMBER(10)
)
SIZE 4096
TABLESPACE dados_clientes;

CREATE INDEX idx_cluster_cliente 
ON CLUSTER cluster_cliente;

CREATE TABLE cliente_cluster (
    id_cliente NUMBER(10),
    nome VARCHAR2(100),
    email VARCHAR2(100)
)
CLUSTER cluster_cliente (id_cliente);
