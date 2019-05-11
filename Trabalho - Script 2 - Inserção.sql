INSERT INTO alunos (nome, email)
VALUES 	('Thiago', 'tiaguinho@outlook.com'),
		('Mônica', 'monicao@gmail.com'),
        ('Rafael', 'rafinha@yahool.com'),
        ('Marina', 'mari_loka@hotmail.com'),
        ('Mateus', 'teteu_tuto@live.com');

INSERT INTO livros (titulo, estoque)
VALUES	('Diario de um Banana', 5),
		('O Pequeno Principe', 5),
        ('O Poderoso Chefão', 5),
        ('Goosebumps', 5),
        ('Don Quixote', 5);

INSERT INTO pedidos (id_livro, id_aluno, data_pedido, data_entrega)
VALUES 	(1, 1, CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY)),
		(2, 2, CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY)),
        (3, 3, CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY)),
        (4, 4, CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY)),
        (5, 5, CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY));
        
INSERT INTO entregas (id_pedido, id_livro,  data_entrega)
VALUES 	(1, 1, CURRENT_DATE()),
		(2, 2, CURRENT_DATE()),
        (3, 3, CURRENT_DATE()),
        (4, 4, CURRENT_DATE()),
        (5, 5, CURRENT_DATE());