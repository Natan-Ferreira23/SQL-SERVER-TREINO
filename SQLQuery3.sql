/*
	1.
	Liste os 5 produtos mais vendidos (em quantidade total), mostrando a descrição e a soma total vendida.
*/
SELECT 
	TOP 5
	P.Descricao,
	SUM(D.Quantidade) TOTAL_VENDIDOS
FROM TB_DETALHE_PEDIDO D
INNER JOIN TB_PRODUTO P ON P.ProdutoId = D.ProdutoId
GROUP BY 
	P.Descricao
ORDER BY
	TOTAL_VENDIDOS DESC

/*
	2.
	Exiba o total de vendas por mês no ano de 2024. Mostre o mês e o valor total (preço × quantidade - desconto).
*/
SELECT 
	SUBSTRING(CONVERT(VARCHAR(10),P.DataPedido,102),6,2) AS [MES], 
	SUM (D.Preco * D.Quantidade - Desconto) AS TOTAL
FROM
	TB_PEDIDO P 
INNER JOIN TB_DETALHE_PEDIDO D ON D.NumeroPedido= P.NumeroPedido
WHERE P.DataPedido BETWEEN '1996-01-01' AND '1996-12-31'
GROUP BY
	SUBSTRING(CONVERT(VARCHAR(10),P.DataPedido,102),6,2)
