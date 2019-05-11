-- 1 --------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insere_pedido (IN PrazoEntrega DATE, IN DataPedido DATE, IN CodCliente INT(4), IN CodVendedor INT(4))
BEGIN
	INSERT INTO pedido (PrazoEntrega, DataPedido, CodCliente, CodVendedor) VALUES (PrazoEntrega, DataPedido, CodCliente, CodVendedor);
END $$
DELIMITER ;
CALL insere_pedido('2018-12-30', '2018-11-29', 1, 1);

-- 2 --------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insere_itempedido (IN CodPedido INT(4), IN CodProduto INT(4), IN Quantidade INT(5))
BEGIN
	IF (Quantidade<=0) THEN
		SELECT 'Quantidade tem que ser maior que zero!' AS msg;
	ELSE
		INSERT INTO itempedido (CodPedido, CodProduto, Quantidade) VALUES (CodPedido, CodProduto, Quantidade);
	END IF;
END $$
DELIMITER ;
CALL insere_itempedido(1, 1, 2);

-- 3 --------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insere_5_itempedido (IN CodPedido INT(4), IN CodProduto INT(4))
BEGIN
	DECLARE x INT;
    SET x = 0;
    
    while_: WHILE (x<5) DO
		
        INSERT INTO itempedido (CodPedido, CodProduto, Quantidade) VALUES (CodPedido, CodProduto, 1);
		SET x = x+1;
        
    END WHILE while_;
    
END $$
DELIMITER ;
CALL insere_5_itempedido(1, 1);

-- 4 --------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE maior_cliente (OUT nome VARCHAR(45))
BEGIN
	SELECT c.nome INTO nome FROM pedido p NATURAL JOIN cliente c WHERE datediff(p.PrazoEntrega, p.DataPedido)<=15
	GROUP BY c.CodCliente ORDER BY COUNT(p.CodPedido) DESC LIMIT 1;
END $$
DELIMITER ;
CALL maior_cliente (@cliente);
SELECT @cliente;

-- 5 --------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE quantidade_produtos (OUT quantidade INT)
BEGIN
	SELECT COUNT(CodProduto) INTO quantidade FROM produto;
END $$
DELIMITER ;
CALL quantidade_produtos (@quantidade);
SELECT @quantidade;

-- 6 --------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE retorna_cliente (IN pedido INT, OUT cliente VARCHAR(45), OUT valor DECIMAL)
BEGIN
	SELECT c.nome, i.quantidade*p.valorUnitario INTO cliente, valor FROM cliente c NATURAL JOIN pedido o NATURAL JOIN itempedido i NATURAL JOIN produto p WHERE i.CodPedido = pedido GROUP BY i.CodPedido;
END $$
DELIMITER ;
CALL retorna_cliente (1, @cliente, @valor);
SELECT @cliente, @valor;

-- 7 --------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE retorna_vendedor (IN codVendedor INT)
BEGIN
	SELECT p.descricao FROM produto p NATURAL JOIN itempedido i NATURAL JOIN pedido d NATURAL JOIN vendedor v WHERE v.CodVendedor  = codVendedor;
END $$
DELIMITER ;
CALL retorna_vendedor (1);

-- 8 --------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE retorna_media (OUT media DECIMAL)
BEGIN
	SELECT AVG(p.ValorUnitario) INTO media FROM produto p;
END $$
DELIMITER ;
CALL retorna_media (@media);
SELECT @media;

-- 9 --------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE retorna_prazo (IN CodPedido INT, OUT prazo INT)
BEGIN
	SELECT datediff(p.PrazoEntrega, p.DataPedido) INTO prazo FROM pedido p WHERE p.CodPedido = CodPedido;
END $$
DELIMITER ;
CALL retorna_prazo (1, @prazo);
SELECT @prazo;

-- 10 -------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE produto_mais_caro (OUT produto VARCHAR(45))
BEGIN
	SELECT p.descricao INTO produto FROM produto p ORDER BY p.ValorUnitario DESC LIMIT 1;
END $$
DELIMITER ;
CALL produto_mais_caro (@produto);
SELECT @produto;