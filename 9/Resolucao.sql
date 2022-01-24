-- 1. Em que páginas da caderneta estão os jogadores do ‘Sporting Clube de Braga’ e do ‘Rio Ave Futebol Clube’ que jogam na posição ‘Defesa’?

SELECT PagCaderneta FROM Cromo as Cr
	INNER JOIN Jogador AS Jo 
    ON Cr.Jogador = Jo.Nr
    INNER JOIN  Posicao AS Po 
    ON Jo.Posicao = Po.Id 
    INNER JOIN Equipa AS Eq 
    ON Jo.Equipa = Eq.Id
    WHERE Po.Designacao = 'Defesa' AND Eq.Designacao IN ('Sporting Clube de Braga','Rio Ave Futebol Clube');

-- ou

SELECT PagCaderneta FROM Cromo as Cr
	WHERE Jogador IN (SELECT Nr from Jogador WHERE Posicao IN (SELECT id FROM Posicao WHERE Designacao = 'Defesa') 
						AND Equipa IN (SELECT id FROM Equipa WHERE Designacao IN ('Sporting Clube de Braga','Rio Ave Futebol Clube')));
    
-- 2. Quais os números dos cromos dos jogadores que não jogam como ‘Médio’ ou ‘Defesa’, cujos treinadores são 
-- ‘Rúben Amorim’ e ‘Carlos Carvalhal’. Apresente a lista ordenada, de forma crescente, por número de cromo.

SELECT Nr FROM Cromo as Cr
	WHERE Jogador IN (SELECT Nr FROM Jogador WHERE Posicao IN (SELECT id FROM Posicao WHERE Designacao NOT IN ('Médio','Defesa') )
						AND Equipa IN (SELECT id FROM Equipa WHERE Treinador IN ('Carlos Carvalhal','Ruben Amorim')))
	ORDER BY Nr;
    
-- 3. Definir uma vista (view) que permita apresentar a lista dos cromos em falta, apresentando o
-- número do cromo, nome do jogador e o nome da equipa à qual pertencem.

CREATE OR REPLACE VIEW  CromosEmFalta AS
	SELECT Cr.Nr, Jo.Nome AS Jogador, Eq.Designacao AS Equipa FROM Cromo AS Cr
    INNER JOIN Jogador as Jo 
    ON Cr.Jogador = Jo.Nr
    INNER JOIN Equipa AS Eq 
    ON Eq.Id = Jo.Equipa
    Where Adquirido = 'N';

SELECT * FROM CromosEmFalta;
    
-- 4. Crie os índices que forem necessários para facilitar a pesquisa da informação dos jogadores utilizando a sua data de nascimento.

-- por exemplo:

CREATE INDEX jogador_data_nascimento_idx on Jogador(DataNascimento);

-- 5. Implementar um procedimento (procedure) que, dado o nome de uma equipa apresente a
-- lista completa dos cromos que a ela dizem respeito, ordenando-a por número de página e
-- número do cromo.
 
 DELIMITER $$
 CREATE PROCEDURE DaCromos (IN nomeEquipa VARCHAR(45))
 BEGIN 
	SELECT Cr.Nr, Cr.PagCaderneta FROM Cromo AS Cr
    INNER JOIN Jogador AS Jo 
    ON Cr.Jogador = Jo.Nr
    INNER JOIN (SELECT Id FROM Equipa WHERE Designacao = nomeEquipa) AS Eq
    ON Jo.Equipa = Eq.Id
    ORDER BY 2,1;
END $$


CALL DaCromos('Sporting Clube de Braga');
 
 
-- 6. Implementar um procedimento que apresente a caderneta completa da coleção de cromos,
-- indicando o número do cromo, o tipo do cromo, o nome do jogador, o nome da equipa e se o
-- cromo já foi ou não adquirido.
DELIMITER $$
CREATE PROCEDURE DaCaderneta()
BEGIN
	SELECT Cr.Nr, Ti.Descricao, IFNULL(Nome,'-') AS Jogador, IFNULL(Designacao,'Sem equipa') AS Equipa, Cr.Adquirido FROM Cromo as Cr
	INNER JOIN TipoCromo Ti ON Cr.Tipo = Ti.Nr
	LEFT OUTER JOIN Jogador Jo ON Cr.jogador = Jo.Nr
	LEFT OUTER JOIN Equipa Eq ON Eq.id = Jo.Equipa;
END$$

CALL DaCaderneta();


-- 7. Implementar uma função (function) que, dado o número de um cromo, indique se o cromo é ou não repetido.

DELIMITER $$
CREATE FUNCTION cromoRepetido(numero INT) RETURNS TEXT
DETERMINISTIC
BEGIN
	DECLARE contaCromo INT DEFAULT 0;
    SELECT COUNT(*) INTO contaCromo FROM Cromo
		WHERE Nr=numero and Adquirido='S';
    IF contaCromo=1 THEN
		RETURN CONCAT(numero,' Cromo Repetido');
	ELSE
		RETURN CONCAT(numero, ' Cromo em Falta');
	END IF;
END $$


SELECT cromoRepetido(35);


-- 8. Implementar uma função (function) que, dado o número de um cromo, devolva o tipo do
-- cromo, o nome do jogador e o nome da equipa.
DELIMITER $$
CREATE FUNCTION cromoDados(numero INT) RETURNS TEXT
DETERMINISTIC
BEGIN
	DECLARE dadosCromo TEXT;
    SELECT CONCAT(Cr.Nr, ' | ',IFNULL(Nome,'-'),' | ',IFNULL(Designacao,'Sem equipa')) INTO dadosCromo FROM Cromo as Cr
	LEFT OUTER JOIN Jogador AS Jo ON Cr.jogador = Jo.Nr
	LEFT OUTER JOIN Equipa AS Eq ON Eq.Id = Jo.Equipa
    WHERE Cr.Nr=numero;
    RETURN dadosCromo;
END $$

SELECT cromoDados(Nr) FROM Cromo;


-- 9. Implementar um gatilho (trigger) que registe numa tabela de auditoria (“audCromos”), criada
-- especificamente para o efeito, a data e a hora em que um dado cromo foi adquirido. Este
-- gatilho deverá ser ativado sempre que o valor do atributo “Adquirido” da tabela “Cromo” mude de ‘N’ para ‘S’.

CREATE TABLE audCromo(
Nr INT, 
DataCompra DATETIME,
PRIMARY KEY(Nr));

DELIMITER $$
CREATE TRIGGER tgAudCromo
AFTER UPDATE ON Cromo
FOR EACH ROW 
BEGIN
	IF OLD.Adquirido='N' AND NEW.Adquirido='S' THEN
    INSERT INTO audCromo VALUES(NEW.Nr,SYSDATE());
    END IF;
END$$


-- 10. Crie um utilizador que tenha apenas permissões para consultar as tabelas “Cromo”, “Jogador” e “Equipa”.

CREATE USER teste@localhost 
IDENTIFIED BY "Adm1nas-";

GRANT SELECT ON caderneta.Equipa to 'teste'@'localhost'; 
GRANT SELECT ON caderneta.Jogador TO 'teste'@'localhost'; 
GRANT SELECT ON caderneta.Cromo TO 'teste'@'localhost'; 