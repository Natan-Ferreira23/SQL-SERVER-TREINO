/*-------------------
18/10/2026
@natan
aula sobre SHRINK
-------------------*/

-- cria a tabela para testes
USE HandsOn
CREATE TABLE tb_Teste(
	tb_Teste_ID int IDENTITY  CONSTRAINT pk_tb_Teste_ID PRIMARY KEY,
	ColunaGrande nchar(200),
	ColunaBigInt BigInt
	);

--executa  todo o bloco  para popular a tabela com linhas 
set nocount on -- faz com que nao seja mostrado 100000 a mensagem de isnercao
go 
--INCLUI 100000 linhas  repete 100000
INSERT HandsOn.dbo.tb_Teste (ColunaGrande,ColunaBigInt) VALUES ('TESTE',12345) 
GO 100000

use HandsOn
SELECT name as Name, size * 8 /1024 as Tamanho_MB,
FILEPROPERTY(name,'SpaceUsed') * 8 /1024 as Espaco_utilizado_MB,
CAST(FILEPROPERTY(name,'SpaceUsed') as decimal(10,4))
/ CAST(size as decimal(10,4)) * 100 as Percentual_Utilizado
FROM sys.database_files

-- reduz mas mantem 10% do espaço livre (reduz somente o que nao estiver em uso), reduz de todos os arquivos
DBCC SHRINKDATABASE('HandsOn',10)

--exclui metade das linhas
DELETE TOP(50000) HandsOn.dbo.tb_Teste

--comando utilizado para reduzir somente de um arquivo especifico, pdoe ser de dados ou log
USE HandsOn
go
DBCC SHRINKFILE(N'HandsOn_FILE3',50) --informar o nome do arquivo e qual a quantidade e MB 
