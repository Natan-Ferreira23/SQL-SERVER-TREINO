/*
NATAN
Data: 25/10/2026 
Aula sobre indices, chaves primarias e extrangeiras
*/
--CRIANDO TABELA
use AdventureWorks
DROP TABLE IF  EXISTS dbo.Cliente

CREATE TABLE dbo.Cliente(
 ClienteId int NOT NULL CONSTRAINT pk_Cliente PRIMARY KEY,
 Nome varchar(152) NOT NULL,
 Tipo char(2) NOT NULL
)
GO
--IMPEDE NOMES REPETIDOS
ALTER TABLE dbo.Cliente ADD CONSTRAINT unq_Cliente_Nome UNIQUE (Nome)
go
-- se nao infomar qual o tipo do indice ele cria por padrao nonclustered
CREATE NONCLUSTERED INDEX ix_Cliente_Tipo ON dbo.Cliente(Tipo)
go

EXEC sp_helpindex 'dbo.Cliente'

-- IMPORTANDO DADOS DE OUTRA TABELA
INSERT INTO dbo.Cliente (ClienteId, Nome, Tipo) 
SELECT c.CustomerID as ClienteID, FirstName + ISNULL(' ' + MiddleName,'') + ISNULL(' ' + LastName,'') as Nome, PersonType as Tipo
FROM AdventureWorks.Sales.Customer  AS c
JOIN  AdventureWorks.Person.Person p ON p.BusinessEntityID = c.PersonID
WHERE FirstName = 'Aaron'
go
-- TABLEA APOS A ATUALIZCAO
SELECT * FROM dbo.Cliente

--com o comando abaixo temos um erro pois a chave primaria 11739 ja esta presente na tabela
INSERT dbo.Cliente (ClienteId,Nome,Tipo) VALUES (11739,'Landry Duailibe','IN')

-- NAO DEIXA INCLUIR NOVAMENTE POIS O NOME JA EXISTE NA TABELA, NA COLUNA NOME FOI ADIOCIONADO A PROPRIEDADE UNIQUE
INSERT dbo.Cliente (ClienteId,Nome,Tipo) VALUES (63000,'Aaron L King','IN')

-- CRIANDO TABELA VENDA
CREATE TABLE dbo.Venda(
 VendaID int NOT NULL CONSTRAINT pk_Venda PRIMARY KEY,
 DataVenda datetime NOT NULL, 
 ClienteID int null,
 ValorTotal decimal(19,4) NOT NULL
)
GO
--ADICIONA UMA CHAVE EXTRANGEIRA NA TABELA VENDA
ALTER TABLE dbo.Venda ADD CONSTRAINT fk_Venda_Cliente
FOREIGN KEY (ClienteID) REFERENCES dbo.Cliente (ClienteID)
GO

-- INSERE DADOS DO ADVENTURE WORKS NA TABELA VENDA
INSERT dbo.Venda (VendaID, DataVenda, ClienteID, ValorTotal)
SELECT SalesOrderID as VendaID, OrderDate as DataVenda, CustomerID as ClienteID, TotalDue as TotalVenda
FROM AdventureWorks.Sales.SalesOrderHeader as a
WHERE exists (SELECT * FROM dbo.Cliente b WHERE b.ClienteID = a.CustomerID)
GO
--CONSULTA O CLIENTE E TODAS AS VENDAS DO MESMO
SELECT * FROM dbo.Cliente WHERE ClienteID = 27663
SELECT * FROM dbo.Venda WHERE ClienteID = 27663

-- RETORNA A DATA E HORA DO SERVIDOR
SELECT getDATE() 