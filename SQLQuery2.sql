
/*
	1.
	Liste todos os nomes dos clientes e os respectivos cargos.
*/

SELECT NomeCompleto, Cargo FROM TB_CLIENTE

/*
	2.
	Exiba a descrição de todos os produtos e seus respectivos preços, ordenados do mais caro para o mais barato.
*/

SELECT Descricao, Preco FROM TB_PRODUTO Order By  Preco desc

/*
	3.
	Liste os produtos que possuem mais de 50 unidades em estoque.
*/
SELECT * FROM TB_PRODUTO WHERE Unidades > 50

/*
	4.
	Mostre o nome completo de todos os funcionários que têm salário acima de R$ 5.000,00.
*/
SELECT * FROM TB_FUNCIONARIO WHERE Salario > 5000

/*
	5.
	Liste os pedidos realizados entre 01/01/2024 e 31/03/2024, incluindo a data do pedido e a data de entrega.
*/
SELECT * FROM TB_PEDIDO WHERE DataPedido BETWEEN  '1996-07-01' AND '1996-09-30'

/*
	6.
	Mostre o nome completo dos clientes e os nomes dos funcionários responsáveis pelos seus pedidos.
*/
SELECT 
	c.NomeCompleto,
	f.NomeCompleto
FROM
	TB_PEDIDO p
INNER JOIN TB_CLIENTE c ON c.ClienteId = p.ClienteId
INNER JOIN TB_FUNCIONARIO f ON f.FuncionarioId = P.FuncionarioId


/*
	7.
	Exiba a descrição dos produtos, nome da categoria e o nome da empresa fornecedora de cada produto.
*/
SELECT 
	p.Descricao,
	c.Descricao,
	f.Empresa
FROM
	TB_PRODUTO p
INNER JOIN TB_CATEGORIA c ON c.CategoriaId = p.CategoriaId
INNER JOIN TB_FORNECEDOR f on f.FornecedorId = p.FornecedorId

/*
	8.
	Liste todos os endereços dos clientes, incluindo o nome do cliente, cidade e país.
*/
SELECT 
	c.NomeCompleto,
	e.Cidade,
	e.Pais
FROM 
 TB_CLIENTE c
INNER JOIN TB_ENDERECO e ON c.ClienteId = e.ClienteId


/*
	9.
	Mostre quantos pedidos cada cliente fez. Apresente o ID do cliente e o total de pedidos.
*/
SELECT 
	C.ClienteId,
	COUNT(p.NumeroPedido) AS TOTAL_PEDIDO
FROM
	TB_PEDIDO P
INNER JOIN TB_CLIENTE C ON C.ClienteId = P.ClienteId
GROUP BY
	C.ClienteId

/*
	10.
	Calcule o valor total (preço * quantidade - desconto) de cada pedido. Mostre o número do pedido e o valor total.
*/
SELECT 
	P.NumeroPedido,
	SUM(D.Preco * D.Quantidade - D.Desconto) AS TOTAL_PEDIDO
FROM
	TB_DETALHE_PEDIDO D
INNER JOIN TB_PEDIDO P ON P.NumeroPedido = D.NumeroPedido
GROUP BY
	P.NumeroPedido

