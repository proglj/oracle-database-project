CREATE ROLE administrador_sistema;
CREATE ROLE analista_dados;
CREATE ROLE usuario_consulta;

-- Permissões
GRANT CREATE SESSION TO administrador_sistema;
GRANT CREATE TABLE TO administrador_sistema;
GRANT CREATE VIEW TO administrador_sistema;

GRANT SELECT ON Clientes TO analista_dados;
GRANT SELECT ON vw_clientes_ativos TO usuario_consulta;

-- Auditoria de roles
CREATE TABLE log_roles (
    id NUMBER PRIMARY KEY,
    usuario VARCHAR2(30),
    role VARCHAR2(30),
    data_alteracao DATE
);
