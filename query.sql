CREATE DATABASE FORD;

USE FORD;

CREATE TABLE veículo (
ID_Veículo INT PRIMARY KEY,
Modelo VARCHAR(50),
Motor VARCHAR(05),
Potência INT,
Capacidade_Carga INT,
Preço FLOAT); 

CREATE TABLE cliente (
ID_Cliente INT PRIMARY KEY,
Nome VARCHAR(50),
Sobrenome VARCHAR(50),
CPF CHAR(11),
E_mail VARCHAR(30),
Telefone VARCHAR(15),
Forma_Contato CHAR(01),
ID_Veículo INT NULL,
Data_Compra DATE NULL); 

INSERT INTO veículo (
ID_Veículo, Modelo, Motor, Potência, Capacidade_Carga, Preço) VALUES (
1, 'XL Cabine Simples 2.2 Diesel 4X4 MT 2022', '2.2', 160, 1234, 183850.00);
INSERT INTO veículo (
ID_Veículo, Modelo, Motor, Potência, Capacidade_Carga, Preço) VALUES (
2, 'XLS 2.2 Diesel 4X4 AT 2022', '2.2', 160, 976, 220690.00);
INSERT INTO veículo (
ID_Veículo, Modelo, Motor, Potência, Capacidade_Carga, Preço) VALUES (
3, 'Storm 3.2 Diesel 4X4 AT 2022', '3.2', 200, 1040, 222790.00);

INSERT INTO cliente (
ID_Cliente, Nome, Sobrenome, CPF, E_mail, Telefone, Forma_Contato,
ID_Veículo, Data_Compra) VALUES (
1, 'José', 'Silva', '1234567', 'Jose@tst.com', '71 2222
2222','1', 3, '2020-12-15'); 
INSERT INTO cliente (
ID_Cliente, Nome, Sobrenome, CPF, E_mail, Telefone, Forma_Contato,
ID_Veículo, Data_Compra) VALUES (
2, 'Maria', 'Santos', '2345678', 'maria@prp.com', '71 3333
3333','2', 2, '2020-12-20'); 
INSERT INTO cliente (
ID_Cliente, Nome, Sobrenome, CPF, E_mail, Telefone, Forma_Contato,
ID_Veículo, Data_Compra) VALUES (
3, 'João', 'Neves', '3456789', 'Joao@tst.com', '71 4444
4444','1', 2, '2021-08-03'); 
INSERT INTO cliente (
ID_Cliente, Nome, Sobrenome, CPF, E_mail, Telefone, Forma_Contato,
ID_Veículo, Data_Compra) VALUES (
4, 'Carla', 'Santana', '3333333', 'carla@prp.com', '71 5555
5555','2', null, null); 

ALTER TABLE cliente ADD FOREIGN KEY veículo_cliente_FK (ID_Veículo) REFERENCES Veículo(ID_Veículo);


/* Alterando a capacidade de carga do veículo 2 para 1076. */
UPDATE veículo SET Capacidade_Carga = 1076 WHERE ID_Veículo = 2; 

/* Apresentando o modelo, motor e potência dos veículos com preço maior que 200.000,00 e motor maior que 3. */
SELECT Modelo, Motor, Potência FROM veículo WHERE Preço > 200000.00 AND Motor > '3';

/* Apresentando o nome, sobrenome e e-mail dos clientes cujo CPF começa com o caractere ‘3’, ordenados pelo nome
de forma ascendente. */
SELECT Nome, Sobrenome, E_mail FROM cliente WHERE CPF LIKE '3%' ORDER BY Nome ASC; 

/* Apresentando o modelo dos veículos, nome e sobrenome dos clientes que os compraram, ordenados pelo modelo
do veículo de forma decrescente e pelo nome do cliente em ordem crescente. */
SELECT v.Modelo, c.Nome, c.Sobrenome FROM cliente c INNER JOIN veículo v 
ON c.ID_Veículo = v.ID_Veículo ORDER BY v.Modelo DESC, c.Nome ASC; 

/* Apresentando o nome do cliente, a data da compra e o preço do veículo comprado, ordenados pelo nome do cliente
de forma crescente, incluindo também os clientes que não compraram veículos. */
SELECT c.Nome, c.Data_Compra, v.Preço FROM cliente c LEFT JOIN veículo v 
ON c.ID_Veículo = v.ID_Veículo ORDER BY c.Nome ASC; 

/* Apresentando os modelos dos veículos e a quantidade de clientes que os compraram. */
SELECT v.Modelo, COUNT(*) AS Qtde_Compradores FROM cliente c INNER JOIN veículo v 
ON c.ID_Veículo = v.ID_Veículo GROUP BY v.Modelo; 

/* Criando uma visão que apresente o somatório dos preços dos veículos vendidos por ano. */
CREATE VIEW `VW_Total_Vendas_Ano` AS
SELECT YEAR(c.Data_Compra) AS Ano, SUM(v.Preço) AS 
Total_Vendas FROM cliente c INNER JOIN veículo v
ON c.ID_Veículo = v.ID_Veículo GROUP BY YEAR(c.Data_Compra); 

SELECT * FROM VW_Total_Vendas_Ano; 

/* Excluindo da tabela cliente o registro da cliente Carla Santana. */
DELETE FROM cliente WHERE Nome = 'Carla' AND Sobrenome = 'Santana' AND ID_Cliente <> 0; 
/* Outra forma: */
DELETE FROM cliente WHERE CONCAT(Nome, ' ', Sobrenome) = 'Carla Santana' AND ID_Cliente <> 0;

SELECT * FROM cliente; 
