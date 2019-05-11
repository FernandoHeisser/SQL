
-- Insere um novo aluno.
DELIMITER $$
CREATE PROCEDURE insereNovoAluno (IN nome_aluno VARCHAR(45), IN email_aluno VARCHAR(45))
BEGIN
	INSERT INTO alunos (nome, email) VALUES (nome_aluno, email_aluno);
END $$
DELIMITER ;
CALL insereNovoAluno('Maelli', 'maelli@terra.com');

-- Insere um novo livro.
DELIMITER $$
CREATE PROCEDURE insereNovoLivro (IN titulo_livro VARCHAR(45), IN quantidade INT)
BEGIN
	INSERT INTO livros (titulo, estoque) VALUES (titulo_livro, quantidade);
END $$
DELIMITER ;
CALL insereNovoLivro('Senhor dos Anéis', 5);

-- Diminui o estoque do livro que foi emprestado.
DELIMITER $$
CREATE TRIGGER diminuiEstoque
AFTER INSERT ON pedidos
FOR EACH ROW BEGIN
	UPDATE livros SET estoque=estoque-1 WHERE id_livro = NEW.id_livro;
END $$
DELIMITER ;
INSERT INTO pedidos (id_livro, id_aluno, data_pedido, data_entrega) VALUES(6, 6, CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY));

-- Aumenta o estoque do livro que foi devolvido.
DELIMITER $$
CREATE TRIGGER aumentaEstoque
AFTER INSERT ON entregas
FOR EACH ROW BEGIN
	UPDATE livros SET estoque=estoque+1 WHERE id_livro = NEW.id_livro;
END $$
DELIMITER ;
INSERT INTO entregas (id_pedido, id_livro, data_entrega) VALUES(6, 6, CURRENT_DATE());

-- Realiza um pedido testando as variáveis.
DELIMITER $$
CREATE FUNCTION realizaPedido (idlivro INT, idaluno INT)
RETURNS VARCHAR(100)
BEGIN
	DECLARE aluno_teste INT;
    DECLARE livro_teste INT;
	DECLARE quantidade INT;
	
    SELECT COUNT(id_livro), estoque INTO livro_teste, quantidade FROM livros WHERE id_livro = idlivro;
    IF (livro_teste = 0) THEN
		RETURN 'Livro não encontra-se no sistema!';
	END IF;
    
    SELECT COUNT(id_aluno) INTO aluno_teste FROM alunos WHERE id_aluno = idaluno;
    IF (aluno_teste = 0) THEN
		RETURN 'Aluno não cadastrado!';
	END IF;

    IF (quantidade = 0) THEN
		RETURN 'Todos as cópias estão emprestadas no momento!';
	END IF;
    
    INSERT INTO pedidos(id_livro, id_aluno, data_pedido, data_entrega) 
    VALUES(idlivro, idaluno, CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY));
    
    RETURN 'Pedido realizado com sucesso!';
END $$
DELIMITER ;
SELECT realizaPedido(1, 1);

DELIMITER $$
CREATE FUNCTION realizaEntrega (idpedido INT)
RETURNS VARCHAR(100)
BEGIN
	DECLARE pedido INT;
    DECLARE livro INT;
    
    SELECT id_pedido, id_livro INTO pedido, livro FROM pedidos WHERE id_pedido = idpedido;
    IF (pedido IS NULL) THEN
		RETURN 'Pedido Incorreto!';
	END IF;
    
    INSERT INTO entregas(id_pedido, id_livro, data_entrega) 
    VALUES(idpedido, livro, CURRENT_DATE());
    
    RETURN 'Entrega realizada com sucesso!';
END $$
DELIMITER ;
SELECT realizaEntrega(1);