--
-- Unidade Curricular de Bases de Dados.
-- Sistemas de Dados Relacionais.
-- SQL 
-- Caso de Estudo - O Restaurante da Avó Micas
--
-- Q U E R I E S
-- Operações de Manipulacao de Dados.
-- Povoamento da base de dados.
-- Exemplos de Aplicação.
-- Exercícios apresentados nas aulas.
-- Belo, O., 2021.
--

-- Indicação da base de dados de trabalho.
USE restauranteam;

-- Desativação e ativação do modo de segurança do MySQL
-- SET SQL_SAFE_UPDATES=0;
-- SET SQL_SAFE_UPDATES=1;

-- Povoamento das tabelas do esquema da base de dados.
-- Utilização da instrução I N S E R T.
-- Povoamento incial da tabela "TiposReceita"
-- SELECT * FROM TiposReceita;
-- DELETE FROM TiposReceita;
INSERT INTO TiposReceita
	(Id, Descrição)
    Values ('1','Entrada');
INSERT INTO TiposReceita
	(Descrição, Id)
    Values ('Prato de Carne','2');
INSERT INTO TiposReceita
    Values ('3','Aperitivo');
INSERT INTO TiposReceita
	(Id, Descrição)
    VALUES 
		('4','Prato de Peixe'),
		('5','Sobremesa'),
		('6','Snack');
-- preencher com mais exemplos.

-- Povoamento incial da tabela "Receita"
-- SELECT * FROM Receita;
-- DELETE FROM Receita;
INSERT INTO Receita
	(Id, Designação, Custo, Foto, Tipo)
    VALUES ('1','Arroz de Pato','12.50',NULL,'2');
INSERT INTO Receita
	(Id, Designação,Tipo)
    VALUES 
    ('2','Bacalhau com Todos','4'),
    ('3','Bife da Casa','2'),
    ('4','Francesinha','6'),
    ('5','Arroz de Marisco','4'),
    ('6','Pescada Cozida com Grelos','4');
-- preencher com mais exemplos.

-- Povoamento incial da tabela "Ingrediente"
-- SELECT * FROM Ingrediente;
-- DELETE FROM Ingrediente;
INSERT INTO Ingrediente
	(Id, Nome, Preço, Stock)
    VALUES 
    ('1','Arroz',NULL, 10),
    ('2','Azeite',NULL, 8),
    ('3','Alho',NULL, 2),
    ('4','Salsa',NULL, 3),
    ('5','Folha de Louro',NULL, 2),
    ('6','Vinho Branco',NULL, 6),
    ('7','Pimentão Doce',NULL, 2),
    ('8','Pimenta',NULL, 2),
    ('9','Cebola',NULL, 10),
    ('10','Batata',NULL, 50),
    ('11','Couve',NULL, 12),
    ('12','Cenoura',NULL, 10),
    ('13','Grão de Bico',NULL, 5),
    ('14','Ovo',NULL, 12),
    ('15','Bacalhau',NULL, 4),
    ('16','Pescada',NULL, 4),
    ('17','Camarão',NULL, 2),
    ('18','Tamboril',NULL, 2);
-- preencher com mais exemplos.

-- Povoamento incial da tabela "ReceitaIngrediente"
-- SELECT * FROM ReceitaIngrediente;
-- DELETE FROM ReceitaIngrediente
INSERT INTO ReceitaIngrediente
	(Receita, Ingrediente, Quantidade)
    VALUES 
    ('2','15','0.5'),
    ('2','10','0.5'),
    ('2','11','0.2'),
    ('2','13','0.1'),
    ('2','12','0.2'),
    ('2','14','3'),
    ('2','2','.25'),
    ('2','3','.5'),
    ('2','14','3');
-- preencher com mais exemplos.

-- Povoamento incial da tabela "Utensílio"
-- SELECT * FROM Utensílio;
-- DELETE FROM Utensílio;
INSERT INTO Utensílio
	(Id, Nome)
    VALUES 
    ('1','Panela grande'),
    ('2','Frigideira'),
    ('3','Colher de pau'),
    ('4','Faca de chefe'),
    ('5','Espumadeira');
-- preencher com mais exemplos.

-- Povoamento incial da tabela "ReceitaUtensílio"
-- SELECT * FROM ReceitaUtensílio;
-- DELETE FROM ReceitaUtensílio;
INSERT INTO ReceitaUtensílio
	(Receita, Utensílio, Quantidade)
    VALUES 
    ('1','3','1');
-- preencher com mais exemplos.

-- Povoamento incial da tabela "ReceitaProcesso"
-- SELECT * FROM ReceitaProcesso;
-- DELETE FROM ReceitaProcesso;
INSERT INTO ReceitaProcesso
	(Receita, Nr, Acção)
    VALUES 
    ('1','1','Preparar os ingredientes');
-- preencher com mais exemplos.

-- Alteração de registos de tabelas do esquema da base de dados.
-- Utilização da instrução U P D A T E.
--
UPDATE Receita
	SET Tipo = '2'
    WHERE Id='5';

-- Remoção de registos de tabelas do esquema da base de dados.
-- Utilização da instrução D E L E T E.
--
DELETE FROM Receita
	WHERE Id = '5';

--
-- <fim>
-- Belo, O., 2021, Novembro.

