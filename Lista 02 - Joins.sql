-- 1
SELECT c.nome, p.codpedido FROM cliente c INNER JOIN pedido p ON c.codCliente = p.codCliente;

-- 2
SELECT c.nome, p.codpedido FROM cliente c LEFT JOIN pedido p ON c.codCliente = p.codCliente;

-- 3
SELECT c.nome, p.prazoEntrega FROM cliente c INNER JOIN pedido p ON c.codCliente = p.codCliente ORDER BY p.prazoEntrega;

-- 4
SELECT c.nome FROM cliente c INNER JOIN pedido p ON c.codCliente = p.codCliente 
WHERE (c.Uf LIKE '%RS%' OR c.Uf LIKE '%SC%') AND datediff(p.prazoEntrega, p.dataPedido)>10;

-- 5
SELECT c.nome, COUNT(p.codpedido) AS Quantidade FROM cliente c INNER JOIN pedido p ON c.codCliente = p.codCliente 
GROUP BY c.codCliente ORDER BY Quantidade DESC, c.nome; # ASC-Crescente DESC-Descrescente

-- 6
SELECT COUNT(i.codProduto) AS Quantidade, i.codPedido FROM itempedido i GROUP BY i.codPedido;

-- 7
SELECT COUNT(i.codProduto) AS Quantidade, i.codPedido FROM itempedido i GROUP BY i.codPedido HAVING COUNT(i.codProduto)>3;

-- 8
SELECT c.nome, p.codPedido, COUNT(i.quantidade) AS Quantidade FROM (cliente c INNER JOIN pedido p ON c.codCliente = p.codCliente) 
INNER JOIN itempedido i ON i.codPedido = p.codPedido GROUP BY i.codPedido ORDER BY Quantidade DESC;

-- 9
SELECT v.nome FROM vendedor v INNER JOIN pedido p ON v.codVendedor = p.codVendedor 
WHERE datediff(p.prazoEntrega, p.dataPedido)>15 AND v.salarioFixo>=1000 ORDER BY v.nome;

-- 10
SELECT c.nome, p.codPedido, i.quantidade*pr.valorUnitario AS Valor_Total FROM ((cliente c INNER JOIN pedido p ON  c.codCliente = p.codCliente)
INNER JOIN itempedido i ON i.codPedido = p.codPedido) INNER JOIN produto pr ON i.codProduto = pr.codProduto ORDER BY Valor_Total DESC;

-- 11
SELECT c.nome, SUM(i.quantidade*pr.valorUnitario) AS Valor_Total FROM ((cliente c INNER JOIN pedido p ON  c.codCliente = p.codCliente)
INNER JOIN itempedido i ON i.codPedido = p.codPedido) INNER JOIN produto pr ON i.codProduto = pr.codProduto GROUP BY c.codCliente 
ORDER BY Valor_Total DESC;

-- 12
SELECT v.nome, SUM(i.quantidade*pr.valorUnitario) AS Valor_Total FROM ((vendedor v INNER JOIN pedido p ON  v.codVendedor = p.codVendedor)
INNER JOIN itempedido i ON i.codPedido = p.codPedido) INNER JOIN produto pr ON i.codProduto = pr.codProduto GROUP BY v.codVendedor 
ORDER BY Valor_Total DESC;

-- 13
SELECT v.nome, SUM(i.quantidade*pr.valorUnitario) AS Valor_Total FROM ((vendedor v INNER JOIN pedido p ON  v.codVendedor = p.codVendedor)
INNER JOIN itempedido i ON i.codPedido = p.codPedido) INNER JOIN produto pr ON i.codProduto = pr.codProduto WHERE YEAR(p.dataPedido) = '2014'
GROUP BY v.codVendedor ORDER BY Valor_Total DESC;

-- 14
SELECT p.descricao, i.quantidade FROM produto p INNER JOIN itempedido i ON p.codProduto = i.codProduto GROUP BY p.codProduto 
ORDER BY i.quantidade DESC, p.descricao;

-- 15
SELECT p.descricao, i.quantidade FROM produto p INNER JOIN itempedido i ON p.codProduto = i.codProduto WHERE p.descricao LIKE '%APPLE%'
GROUP BY p.codProduto ORDER BY i.quantidade DESC, p.descricao;

-- 16
SELECT p.descricao, SUM(i.quantidade*p.valorUnitario) AS valor FROM produto p INNER JOIN itempedido i ON p.codProduto = i.codProduto GROUP BY p.codProduto 
ORDER BY valor DESC, p.descricao;

-- 17
SELECT p.descricao, i.quantidade FROM (produto p INNER JOIN itempedido i ON p.codProduto = i.codProduto) NATURAL JOIN pedido 
WHERE YEAR(pedido.dataPedido) = '2015' AND MONTH(pedido.dataPedido) = '08' GROUP BY p.codProduto ORDER BY i.quantidade DESC, p.descricao;

-- 18
SELECT c.nome, c.codCliente FROM cliente c LEFT JOIN pedido p ON p.codCliente = c.codCliente WHERE p.codPedido IS NULL;

-- 19
SELECT produto.codProduto, produto.descricao, SUM(itempedido.quantidade*produto.valorUnitario) AS Total FROM produto 
LEFT JOIN itempedido ON itempedido.codProduto = produto.codProduto GROUP BY produto.codProduto ORDER BY Total DESC;
