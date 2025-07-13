/*
	Verificar número par ou ímpar
Crie um script que armazena um número em uma variável e exibe se ele é par ou ímpar.
*/
DECLARE @NUMERO INT
SET @NUMERO = 10

IF @NUMERO % 2 = 0
	BEGIN
		PRINT ' É UM NUMERO PAR '
	END
ELSE
	BEGIN
		PRINT ' É UM NUMERO IMPAR '
	END

/*
	2. Comparar dois valores
Declare duas variáveis @a e @b. Exiba qual é o maior valor ou se são iguais.
*/
DECLARE @A INT
DECLARE @B INT

SET @A = 10
SET @B = 11

IF @A > @B 
	BEGIN
		PRINT ' @A E MAIOR QUE @B'
	END
ELSE
	BEGIN
		PRINT ' @B E MAIOR QUE @A'
	END

	/*
		Classificar idade
	Com base em uma variável @idade, exiba:

	"Criança" se for menor que 12

	"Adolescente" entre 12 e 17

	"Adulto" entre 18 e 59

	"Idoso" se 60 ou mais
	
	*/
DECLARE @IDADE INT
SET @IDADE = 59

IF @IDADE <= 12
	BEGIN 
		PRINT 'CRIANCA'
	END

ELSE IF @IDADE <= 17
	BEGIN 
		PRINT 'ADOLESCENTE'
	END
ELSE IF @IDADE <= 59
	BEGIN 
		PRINT 'ADULTO'
	END
ELSE 
	BEGIN 
		PRINT 'IDOSO'
	END

/*
	4. Tabuada do 5
	Use um laço WHILE para mostrar a tabuada do 5 (5 x 1 até 5
*/
DECLARE @CONTADOR INT  
SET @CONTADOR = 1

WHILE @CONTADOR <= 10
	BEGIN
		PRINT '5 X ' + CAST(@CONTADOR AS VARCHAR) + ' = ' + CAST((@CONTADOR * 5) AS VARCHAR) 
		SET @CONTADOR = @CONTADOR + 1
	END
	
/*
	5. Soma dos 10 primeiros números inteiros
	Use WHILE para somar os números de 1 a 10 e mostrar o total.
*/
DECLARE @SOMA1 INT 
DECLARE @CONTADOR1 INT 
SET @SOMA1 = 0
SET @CONTADOR1 = 1
WHILE @CONTADOR1 <= 10
	BEGIN
		SET @SOMA1 = @SOMA1 + @CONTADOR1
		PRINT ' A SOMA E : ' + CAST(@SOMA1 AS VARCHAR)
		SET @CONTADOR1  = @CONTADOR1 + 1
	END
/*
	6. Contador regressivo
	Exiba os números de 10 a 1 com WHILE.
*/
DECLARE @CONTADOR2 INT 
SET @CONTADOR2 = 10

WHILE @CONTADOR2 > 0
	BEGIN
		PRINT @CONTADOR2
		SET @CONTADOR2 = @CONTADOR2 - 1
	END
/*
	Verificar quantidade de pedidos de um cliente
	Declare uma variável @ClienteId e atribua um valor
	Conte quantos pedidos ele fez.
	Se for mais de 5, mostre "Cliente ativo", senão, "Cliente inativo".
*/
DECLARE @CLIENTE_ID INT 
--FAZENDO O SELECT E ATRIBUINDO VALOR
SET @CLIENTE_ID = (SELECT 
	COUNT(*) AS TOTAL_PEDIDOS
FROM
	TB_PEDIDO AS P
INNER JOIN TB_CLIENTE AS C ON C.ClienteId = P.ClienteId
WHERE 
	C.ClienteId = 'TOMSP')

IF @CLIENTE_ID > 5
	BEGIN
		PRINT 'CLIENTE ATIVO'
	END
ELSE
	BEGIN
		PRINT 'CLIENTE INATIVO'
	END

/*
	Classificar produto por estoque
	Com base em uma variável @ProdutoId, pegue o valor da coluna QuantidadeEmEstoque da TB_PRODUTO.

	Se for maior que 100, diga "Estoque alto".

	Entre 20 e 100: "Estoque normal".

	Menor que 20: "Estoque crítico".	
*/
DECLARE @PRODUTO_ID INT 
SET @PRODUTO_ID = (SELECT 
	Unidades
FROM
	TB_PRODUTO
WHERE 
	ProdutoId = 36
	)
IF @PRODUTO_ID > 100
	BEGIN
		PRINT 'ESTOQUE ALTO'
	END
ELSE IF @PRODUTO_ID <=100 AND @PRODUTO_ID >=20
	BEGIN
		PRINT 'ESTOQUE NORMAL'
	END
ELSE
	BEGIN
		PRINT 'ESTOQUE BAIXO'
	END




