CREATE DATABASE biblioteca;

USE biblioteca;

CREATE TABLE alunos(
	id_aluno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL
);
CREATE TABLE livros(
	id_livro INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45) NOT NULL,
    estoque INT NOT NULL
);
CREATE TABLE pedidos(
	id_pedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_livro INT NOT NULL,
    id_aluno INT NOT NULL,
    data_pedido DATE NOT NULL,
    data_entrega DATE NOT NULL,
    FOREIGN KEY fk_livro (id_livro) REFERENCES livros (id_livro),
    FOREIGN KEY fk_aluno (id_aluno) REFERENCES alunos (id_aluno)
);
CREATE TABLE entregas(
	id_devolucao INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
	id_livro INT NOT NULL,
	data_entrega DATE NOT NULL,
    FOREIGN KEY fk_pedido (id_pedido) REFERENCES pedidos (id_pedido),
    FOREIGN KEY fk_livro2 (id_livro) REFERENCES livros (id_livro)
);