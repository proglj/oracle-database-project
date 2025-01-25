CREATE TABLE dicionario_dados (
    tabela VARCHAR2(30),
    coluna VARCHAR2(30),
    tipo_dados VARCHAR2(30),
    descricao VARCHAR2(200)
);

INSERT INTO dicionario_dados VALUES (
    'CLIENTES',
    'ID_CLIENTE',
    'NUMBER',
    'Identificador único do cliente'
);
