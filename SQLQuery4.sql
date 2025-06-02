
/*
	1.
	Liste os 3 clientes que mais gastaram em compras, mostrando o nome completo e o valor total gasto por cada um.
*/
SELECT
	TOP 3
	C.NomeCompleto AS NOME_COMPLETO,
	SUM(D.Quantidade * (D.Preco - D.Desconto)) AS TOTAL_GASTO	
FROM
	TB_PEDIDO AS P
INNER JOIN 
	TB_DETALHE_PEDIDO AS D ON D.NumeroPedido=P.NumeroPedido
INNER JOIN 
	TB_CLIENTE AS C ON C.ClienteId = P.ClienteId
GROUP BY
	C.NomeCompleto
ORDER BY
	SUM(D.Quantidade * (D.Preco - D.Desconto)) DESC	

/*
	10.
	Liste o número de pedidos e o valor total arrecadado por país (com base no país do cliente).
*/

SELECT 
	E.Pais,
	COUNT(P.NumeroPedido) AS TOTAL_PEDIDOS,
	SUM(D.Quantidade * (D.Preco - D.Desconto)) AS TOTAL_GASTO_PAIS
FROM 
	TB_PEDIDO AS P
INNER JOIN TB_DETALHE_PEDIDO AS D ON D.NumeroPedido = P.NumeroPedido
INNER JOIN TB_CLIENTE AS C ON C.ClienteId = P.ClienteId
INNER JOIN TB_ENDERECO AS E ON E.ClienteId = C.ClienteId
GROUP BY
	E.Pais
ORDER BY 
	TOTAL_GASTO_PAIS DESC