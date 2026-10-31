

/*
    @natan
    30/10/2026
    Descrição: Neste script realizei a importação de um arquivo csv onde possuia informacoes de codigo e endereço,
    essas informações foram inseridas em uma tabela intermediaria e após isso foram utilizadas para alterar dados com update na
    tabela de cadastro de produtos do ERP Protheus (tabela SB1)
*/

------fazer backup
SELECT *
  INTO SB1010_BKP_20261030
  FROM TOTVS_3DJ.dbo.SB1010;


--- 1)  cria um banco de dados para criarmos uma tabela espelho
CREATE DATABASE PRODUTO;
USE PRODUTO;
-- 2) criacao da tabela que ira receber os dados do csv
CREATE TABLE Produtos (
    ID VARCHAR(20),
    Descricao VARCHAR(100),
	Endereco  VARCHAR(20)  
);
-- 3) fazendo leitura de csv e inserindo dados na tabela
BULK INSERT Produtos
FROM 'C:\TEMP\altprodutos.csv'
WITH (
    FIELDTERMINATOR = ';',     -- Delimitador de colunas (vírgula, ponto e vírgula ';', etc.)
    ROWTERMINATOR = '\n',      -- Quebra de linha
    FIRSTROW = 2,              -- Pula a primeira linha se houver cabeçalho
    DATAFILETYPE = 'char',     -- Tipo de dados do arquivo
    CODEPAGE = '65001'         -- UTF-8 (útil para acentuação e caracteres especiais)
);
GO
--- 4) dando update na tabela SB1010 Protheus 3dj

UPDATE SB1 SET SB1.B1_UENDER = P.Endereco
FROM TOTVS_3DJ.dbo.SB1010 SB1
JOIN PRODUTO.dbo.Produtos P ON P.ID=SB1.B1_COD
WHERE SB1.D_E_L_E_T_=''
GO

-- COMPARANDO OS DADOS
SELECT 
	SB1.B1_COD, SB1.B1_DESC, SB1.B1_UENDER, P.ID, P.Descricao, P.Endereco
FROM TOTVS_3DJ.dbo.SB1010  SB1
INNER JOIN PRODUTO.dbo.Produtos P ON P.ID=SB1.B1_COD
WHERE 
  SB1.D_E_L_E_T_=''

-- ENCONTRANDO A DIFERENCA ENTRE O QUE ESTA NA PRODUTOS E NAO ESTA NA SB1
SELECT 
  p.ID,
  p.Descricao,
  p.Endereco
FROM PRODUTO.dbo.Produtos p
LEFT JOIN TOTVS_3DJ.dbo.SB1010 SB1 
       ON SB1.B1_COD = p.ID
      AND SB1.D_E_L_E_T_ = ' '
WHERE SB1.B1_COD IS NULL;

-- 5) Excluindo a tabela criada para receber dados do csv (opcional)
DROP DATABASE PRODUTO 





