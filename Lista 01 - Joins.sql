-- -----------------------------------------------------
-- Criar e selecionar o banco BD_BANCARIO
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS BD_ESTACIONAMENTO;
USE BD_ESTACIONAMENTO;

-- -----------------------------------------------------
-- Tabela Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
	idCliente INT NOT NULL AUTO_INCREMENT,
    cpf VARCHAR(16) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    dataNascimento DATE NOT NULL,
    PRIMARY KEY (idCliente)
);


-- -----------------------------------------------------
-- Tabela Modelo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Modelo (
  idModelo INT NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(45) NOT NULL,
  PRIMARY KEY (idModelo)
);

-- -----------------------------------------------------
-- Tabela Patio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Patio (
  idPatio INT NOT NULL AUTO_INCREMENT,
  endereco VARCHAR(45) NOT NULL,
  capacidade INT NOT NULL,
  PRIMARY KEY (idPatio)
);


-- -----------------------------------------------------
-- Tabela Vaiculo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Veiculo (
  idVeiculo INT NOT NULL AUTO_INCREMENT,
  idCliente INT NOT NULL,
  idModelo INT NOT NULL, 
  placa VARCHAR(9) NOT NULL,
  cor VARCHAR(30) NOT NULL,
  ano YEAR NOT NULL,
  PRIMARY KEY (idVeiculo),
  FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
  FOREIGN KEY (idModelo) REFERENCES modelo(idModelo)
);

-- -----------------------------------------------------
-- Tabela Estacionamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Estacionamento (
  idEstacionamento INT NOT NULL AUTO_INCREMENT,
  idVeiculo INT NOT NULL,
  idPatio INT NOT NULL, 
  dataEntrada DATE NOT NULL, 
  dataSaida DATE NOT NULL, 
  horaEntrada TIME NOT NULL,
  horaSaida TIME NOT NULL,
  PRIMARY KEY (idEstacionamento),
  FOREIGN KEY (idVeiculo) REFERENCES veiculo(idVeiculo),
  FOREIGN KEY (idPatio) REFERENCES patio(idPatio)
);


-- -----------------------------------------------------
-- Inserção na tabela Cliente
-- -----------------------------------------------------
INSERT INTO cliente(idCliente, nome, dataNascimento, CPF) VALUES
(1, 'Alfredo Chaves', '1951-05-24', 41500796480),
(2, 'Antônio Marques', '1958-10-21', 26976279279),
(3, 'Romulo Serafin', '2002-01-03', 32605016520),
(4, 'Alex Peretti', '1970-05-04', 65292369145),
(5, 'Alencar Vitor Souza', '1950-05-07', 25400150198),
(6, 'Roberto Alves', '1973-01-15', 15883561459),
(7, 'Ricardo Almeida', '1988-12-04', 15384434466),
(8, 'Marcia Sales', '1971-04-27', 82305048271),
(9, 'Fabio Prates', '1979-05-21', 73716860453),
(10, 'Paulo Brito', '1985-06-24', 79920674659),
(11, 'Valéria Mattos', '1991-01-11', 33431439895),
(12, 'Silvia Antunes', '1971-12-21', 96363772163),
(13, 'Guilherme Arcanjo', '2004-05-11', 49542152702),
(14, 'Mateus Felipe Souza', '1982-04-10', 81877196102),
(15, 'Felipe Santos', '1964-10-19', 30688338540),
(16, 'Luis de Almeida', '1959-10-12', 29435217066);


-- -----------------------------------------------------
-- Inserção na tabela Modelo
-- -----------------------------------------------------
INSERT INTO modelo(idModelo, descricao) VALUES
(1, 'FOCUS FASTBACK'),
(2, 'KA SEDAN'),
(3, 'KA HATCH'),
(4, 'GRAND SANTA FE'),
(5, 'SPACE CROSS'),
(6, 'RENEGADE'),
(7, 'TORO'),
(8, 'MOBI'),
(9, 'NEW BEETLE'),
(10, 'CROSSFOX');

-- -----------------------------------------------------
-- Inserção na tabela Veiculo
-- -----------------------------------------------------

INSERT INTO veiculo(idVeiculo, idCliente, idModelo, placa, cor, ano) VALUES
(1, 4, 9, 'IHJ-9090', 'Branco', 2008),
(2, 1, 1, 'III-7890', 'Vermelho', 2001),
(3, 6, 2, 'KLL-6160', 'Branco', 2015),
(4, 11, 6, 'IHC-5437', 'Preto', 2014),
(5, 12, 3, 'AEB-3232', 'Laranja', 2008),
(6, 10, 4, 'RMF-1304', 'Vermelho', 2009),
(7, 10, 4, 'JAB-0006', 'Branco', 2009);

-- -----------------------------------------------------
-- Inserção na tabela Patio
-- -----------------------------------------------------
INSERT INTO patio(idPatio, endereco, capacidade) VALUES
(1, 'Rua Joaquim Nabuco, 100', 20),
(2, 'Alameda Trindade, 2345', 10),
(3, 'Rua Pedro Alvares, 32', 100),
(4, 'Rua Santa Clara, 23', 16),
(5, 'Rua Aratiba, 456', 200),
(6, 'Rua Senegal, 9865', 55),
(7, 'Avenida Castelo Branco, 345', 68),
(8, 'Avenida da Legalidade, 26', 30),
(9, 'Rua Pedro Menegola, 234', 5),
(10,  'Avenida Bento Gonçalvez, 234', 100);


-- -----------------------------------------------------
-- Inserção na tabela Estacioanamento 
-- -----------------------------------------------------
INSERT INTO estacionamento(idEstacionamento, idVeiculo, idPatio, dataEntrada, dataSaida, horaEntrada, horaSaida) VALUES
(1, 1, 3, '2018-09-25', '2018-09-24', '14:00:00', '18:00:00'),
(2, 2, 1, '2018-09-25', '2018-09-25', '09:00:00', '09:30:00'),
(3, 1, 3, '2018-09-25', '2018-09-25', '14:00:00', '18:00:00'),
(4, 3, 10, '2018-09-23', '2018-09-24', '23:00:00', '08:00:00'),
(5, 6, 5, '2018-09-25', '2018-09-25', '14:00', '18:00');

-- 1
SELECT c.nome, v.placa FROM cliente c INNER JOIN veiculo v ON v.idCliente = c.idCliente;
-- 2
SELECT c.nome, v.placa FROM cliente c LEFT JOIN veiculo v ON v.idCliente = c.idCliente;
-- 3
SELECT c.nome, v.placa FROM cliente c RIGHT JOIN veiculo v ON v.idCliente = c.idCliente;
-- 4
SELECT c.nome FROM cliente c LEFT JOIN veiculo v ON v.idCliente = c.idCliente WHERE v.idCliente IS NULL;
-- 5
SELECT c.cpf, c.nome FROM cliente c LEFT JOIN veiculo v ON v.idCliente = c.idCliente WHERE v.placa LIKE '%RMF-1304%';
-- 6
SELECT v.placa, v.cor FROM veiculo v LEFT JOIN estacionamento e ON v.idVeiculo = e.idVeiculo WHERE e.idEstacionamento=4;
-- 7
SELECT v.placa, v.ano, m.descricao FROM veiculo v LEFT JOIN modelo m ON v.idModelo = m.idModelo WHERE v.ano > '2005';
-- 8
SELECT p.endereco, e.dataEntrada, e.dataSaida FROM (estacionamento e  INNER JOIN patio p ON e.idPatio = p.idPatio) INNER JOIN veiculo v ON v.idVeiculo = e.idVeiculo WHERE v.placa LIKE '%JAB-0006%';
-- 9
SELECT COUNT(e.idEstacionamento) FROM estacionamento e INNER JOIN veiculo v ON e.idVeiculo = v.idVeiculo WHERE v.cor LIKE '%Laranja%';
-- 10
SELECT c.nome FROM cliente c INNER JOIN veiculo v ON v.idCliente = c.idCliente WHERE v.idModelo = 3;
-- 11
SELECT v.placa, e.horaEntrada, e.horaSaida FROM veiculo v INNER JOIN estacionamento e ON v.idVeiculo = e.idVeiculo WHERE v.cor LIKE '%Vermelho%';
-- 12
SELECT * FROM estacionamento e INNER JOIN veiculo v ON e.idVeiculo = v.idVeiculo WHERE v.placa LIKE '%AEB-3232%';
-- 13
SELECT c.nome, v.cor FROM (cliente c INNER JOIN veiculo v ON c.idCliente = v.idCliente) INNER JOIN estacionamento e ON e.idVeiculo = v.idVeiculo WHERE idEstacionamento=3;
-- 14
SELECT c.cpf FROM (cliente c INNER JOIN veiculo v ON c.idCliente = v.idCliente) INNER JOIN modelo m ON v.idModelo = m.idModelo WHERE m.descricao LIKE '%RENEGADE%';
-- 15
SELECT v.placa, c.nome, m.descricao FROM (veiculo v INNER JOIN cliente c ON c.idCliente = v.idCliente) INNER JOIN modelo m ON m.idModelo = v.idModelo;







