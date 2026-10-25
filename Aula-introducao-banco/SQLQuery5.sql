/*
@natan
21/10/2026
introducao ao T-SQL

DDL : create, ALTER  e drop
DCL : grant, deny e revoke
DML : insert, update e delete, select 
*/

CREATE DATABASE AULA
USE AULA
CREATE TABLE TESTE(
	Coluna char(10)
);
-- 1) explicação das variaveis
INSERT INTO TESTE VALUES ('TESTE1');
INSERT INTO TESTE VALUES ('TESTE2');
INSERT INTO TESTE VALUES ('TESTE3');
INSERT INTO TESTE  ('TESTE4');
GO -- COM O GO AO RODAR OS SCRIPTS ACIMA NENHUM REALMENTE SERA EXECUTADO POIS HA UM ERRO DE SINTAXE

SELECT * FROM TESTE


--- 2) exercicios com variaveis
USE AdventureWorks
SELECT * FROM Person.Person -- todos da tabela person

DECLARE @NAME AS  NVARCHAR(50) -- declara variavel e tipo
SET @NAME = 'David' --define o valor da variavel 
SELECT * FROM Person.Person WHERE FirstName = @NAME; --query usando varaiveis
GO
-- TUDO QUE COMECA COM A
DECLARE @PARTENOME AS NVARCHAR(10)
SET @PARTENOME = 'A'
SELECT * FROM Person.Person WHERE FirstName LIKE @PARTENOME+'%'
GO
-- 3) UTILIZANDO EXECUTE, TRANSFORMANDO STRING EM COMANDOS SQL
DECLARE @Banco AS NVARCHAR(20),@Tabela AS VARCHAR(20)
SET @Banco = 'AdventureWorks'
SET @Tabela = 'Production.Product'
EXECUTE('USE ' + @Banco + ' SELECT * FROM ' + @Tabela)
GO

-- 4) Utilizando o CASE na tabela de produtos 
	--R = Road, M = Mountain, T = Touring, S = Standard
SELECT
	ProductId,
	Name,
	CASE  
		WHEN ProductLine = 'R' THEN 'Road'
		WHEN ProductLine = 'M' THEN 'Mountain'
		WHEN ProductLine = 'T' THEN 'Touring'
		WHEN ProductLine = 'S' THEN 'Standard'	
	END AS ProductlINE_DESC
FROM AdventureWorks.Production.Product
WHERE ProductLine IS NOT NULL
 