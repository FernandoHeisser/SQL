-- SELECT que mostra os alunos e os livros emprestados.
SELECT A.nome, L.Titulo FROM alunos A NATURAL JOIN pedidos P NATURAL JOIN livros L;

-- SELECT que mostra os alunos que não entregaram os livros na data certa.
SELECT A.nome, datediff(E.data_entrega, P.data_pedido) AS dias_atraso FROM alunos A NATURAL JOIN pedidos P NATURAL JOIN entregas E 
WHERE datediff(E.data_entrega, P.data_pedido)>5;

-- SELECT que mostra os livros que estão com todas cópias emprestadas e os alunos que pegaram emprestado.
SELECT L.Titulo, A.nome FROM livros L NATURAL JOIN pedidos P NATURAL JOIN alunos A WHERE L.estoque = 0;

-- SELECT que mostra quantas vezes um livro foi emprestado.
SELECT L.titulo, COUNT(P.id_pedido) AS n°_vezes FROM livros L NATURAL JOIN pedidos P WHERE P.id_livro = L.id_livro GROUP BY L.id_livro;