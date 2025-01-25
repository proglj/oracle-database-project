CREATE MATERIALIZED VIEW mv_resumo_clientes
REFRESH COMPLETE ON DEMAND
ENABLE QUERY REWRITE AS
SELECT 
    c.id_cliente,
    c.nome,
    COUNT(p.id_pedido) total_pedidos,
    SUM(p.valor) valor_total
FROM 
    Clientes c
    LEFT JOIN Pedidos p ON c.id_cliente = p.id_cliente
GROUP BY 
    c.id_cliente, c.nome;
