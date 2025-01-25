-- View para relatórios de clientes ativos
CREATE OR REPLACE VIEW vw_clientes_ativos AS
SELECT 
    c.id_cliente,
    c.nome,
    c.email,
    COUNT(p.id_pedido) as total_pedidos,
    SUM(p.valor_total) as valor_total_pedidos
FROM 
    Clientes c
    LEFT JOIN Pedidos p ON c.id_cliente = p.id_cliente
WHERE 
    c.ativo = 'S'
GROUP BY 
    c.id_cliente, c.nome, c.email;
