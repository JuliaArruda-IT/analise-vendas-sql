# Faturamento total da empresa
SELECT SUM(p.preco * i.quantidade) AS faturamento_total
FROM itens_pedido i
INNER JOIN produtos p
ON i.id_produto = p.id_produto;

# Produtos mais vendidos
SELECT
    p.produto,
    SUM(i.quantidade) AS total_vendido
FROM itens_pedido i
INNER JOIN produtos p
ON i.id_produto = p.id_produto
GROUP BY p.produto
ORDER BY total_vendido DESC;

# Faturamento por produto
SELECT
    p.produto,
    SUM(p.preco * i.quantidade) AS faturamento
FROM itens_pedido i
INNER JOIN produtos p
ON i.id_produto = p.id_produto
GROUP BY p.produto
ORDER BY faturamento DESC;

# Categorias que mais faturaram
SELECT
    p.categoria,
    SUM(p.preco * i.quantidade) AS faturamento
FROM itens_pedido i
INNER JOIN produtos p
ON i.id_produto = p.id_produto
GROUP BY p.categoria
ORDER BY faturamento DESC;

# Clientes que mais compraram
SELECT
    c.nome,
    COUNT(pe.id_pedido) AS quantidade_pedidos
FROM clientes c
INNER JOIN pedidos pe
ON c.id_cliente = pe.id_cliente
GROUP BY c.nome
ORDER BY quantidade_pedidos DESC;

# Quanto cada cliente gastou
SELECT
    c.nome,
    SUM(p.preco * i.quantidade) AS total_gasto
FROM clientes c
INNER JOIN pedidos pe
ON c.id_cliente = pe.id_cliente
INNER JOIN itens_pedido i
ON pe.id_pedido = i.id_pedido
INNER JOIN produtos p
ON i.id_produto = p.id_produto
GROUP BY c.nome
ORDER BY total_gasto DESC;

# Produtos nunca vendidos
SELECT
    p.produto
FROM produtos p
LEFT JOIN itens_pedido i
ON p.id_produto = i.id_produto
WHERE i.id_produto IS NULL;

# Quantidade de pedidos por mês
SELECT
    MONTH(data_pedido) AS mes,
    COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY MONTH(data_pedido)
ORDER BY mes;

# Ticket médio dos pedidos
SELECT
    AVG(total_pedido) AS ticket_medio
FROM (
    SELECT
        pe.id_pedido,
        SUM(p.preco * i.quantidade) AS total_pedido
    FROM pedidos pe
    INNER JOIN itens_pedido i
        ON pe.id_pedido = i.id_pedido
    INNER JOIN produtos p
        ON i.id_produto = p.id_produto
    GROUP BY pe.id_pedido
) AS pedidos_totais;

# Top 5 clientes
SELECT
    c.nome,
    SUM(p.preco * i.quantidade) AS total_gasto
FROM clientes c
INNER JOIN pedidos pe
ON c.id_cliente = pe.id_cliente
INNER JOIN itens_pedido i
ON pe.id_pedido = i.id_pedido
INNER JOIN produtos p
ON i.id_produto = p.id_produto
GROUP BY c.nome
ORDER BY total_gasto DESC
LIMIT 5;