CREATE DATABASE escola;
USE escola;
CREATE TABLE disciplinas(
	cod_disciplina INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_disciplina VARCHAR(45) NOT NULL,
    carga_horaria INT NOT NULL
);
CREATE TABLE alunos(
	cod_aluno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_aluno VARCHAR(45) NOT NULL,
    cpf_aluno VARCHAR(45) NOT NULL
);
CREATE TABLE notas(
	cod_nota INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cod_disciplina INT NOT NULL,
    cod_aluno INT NOT NULL,
    nota FLOAT,
    FOREIGN KEY fk_discilina (cod_disciplina) REFERENCES disciplinas (cod_disciplina),
    FOREIGN KEY fk_aluno (cod_aluno) REFERENCES alunos (cod_aluno)
);

-- 1  ------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE adiciona_disciplina (IN nome VARCHAR(45), IN carga INT)
BEGIN
	INSERT INTO disciplinas (nome_disciplina, carga_horaria) VALUES (nome, carga);
END $$
DELIMITER ;
CALL adiciona_disciplina('BD2', 1000);

-- 2  ------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE adiciona_aluno (IN nome VARCHAR(45), IN cpf VARCHAR(45))
BEGIN
	INSERT INTO alunos (nome_aluno, cpf_aluno) VALUES (nome, cpf);
END $$
DELIMITER ;
CALL adiciona_aluno('Fernando', '043.102.990-32');

-- 3  ------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE adiciona_nota (IN cod_aluno INT, IN cod_disciplina INT, IN nota FLOAT)
BEGIN
	INSERT INTO notas (cod_disciplina, cod_aluno, nota) VALUES (cod_disciplina, cod_aluno, nota);
END $$
DELIMITER ;
CALL adiciona_nota(1, 1, 10);

-- 4  ------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE adiciona_10_fulaninhos ()
BEGIN
	DECLARE x INT;
    SET x = 0;
    
    while_: WHILE (x<10) DO
		
        INSERT INTO alunos (nome_aluno, cpf_aluno) VALUES (CONCAT('fulaninho', x+1), '123.456.789-00');
		SET x = x+1;
        
    END WHILE while_;
    
END $$
DELIMITER ;
CALL adiciona_10_fulaninhos();

-- 5  ------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE mostra_disciplinas ()
BEGIN
	SELECT nome_disciplina FROM disciplinas;
END $$
DELIMITER ;
CALL mostra_disciplinas ();

-- 6  ------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE conta_disciplinas ()
BEGIN
	SELECT COUNT(1) AS Quantidade FROM disciplinas GROUP BY cod_disciplina;
END $$
DELIMITER ;
CALL conta_disciplinas ();

-- 7  ------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE media_aluno_cod (IN cod INT, OUT media FLOAT)
BEGIN
	SELECT AVG(nota) INTO media FROM notas NATURAL JOIN alunos WHERE cod_aluno = cod;
END $$
DELIMITER ;
CALL media_aluno_cod (1, @total);

-- 8  ------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE media_nome_aluno_cod (IN cod INT, OUT nome VARCHAR(45), OUT media FLOAT)
BEGIN
	SELECT nome_aluno, AVG(nota) INTO nome, media FROM notas NATURAL JOIN alunos WHERE cod_aluno = cod;
END $$
DELIMITER ;
CALL media_nome_aluno_cod (1, @nome, @total);

-- 9  ------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE media_nome_disciplina_cod (IN cod INT, OUT nome VARCHAR(45), OUT media FLOAT)
BEGIN
	SELECT nome_disciplina, AVG(nota) INTO nome, media FROM notas NATURAL JOIN disciplinas WHERE cod_disciplina = cod;
END $$
DELIMITER ;
CALL media_nome_disciplina_cod (1, @nome, @total);

-- 10  -----------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE maior_nota_disciplina (IN cod INT, OUT nome_ VARCHAR(45), OUT nota_ FLOAT)
BEGIN
	SELECT disciplinas.nome_disciplina, notas.nota INTO nome_, nota_ FROM notas NATURAL JOIN disciplinas WHERE disciplinas.cod_disciplina = cod ORDER BY notas.nota DESC LIMIT 1;
END $$
DELIMITER ;
CALL maior_nota_disciplina (1, @nome, @total);