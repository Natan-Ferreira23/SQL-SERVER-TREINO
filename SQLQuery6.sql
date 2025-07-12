/*
	Clientes com mais pedidos que a média:
	Liste os clientes que fizeram mais pedidos do que a média de pedidos por cliente.
*/
SELECT 
	CL.NomeCompleto AS NOME_CLIENTE,
	COUNT(PE.NumeroPedido) AS TOTAL_PEDIDO
FROM 
	TB_PEDIDO AS PE
INNER JOIN TB_CLIENTE AS CL ON CL.ClienteId = PE.ClienteId
GROUP BY 
	CL.NomeCompleto
HAVING 
	COUNT(*) > (
			SELECT 
				AVG(QRY2.TOTAL_PEDIDO)
			FROM(
				SELECT		
					CL2.NomeCompleto AS NOME_CLIENTE,
					COUNT(PE2.ClienteId) AS [TOTAL_PEDIDO]
				FROM
					TB_PEDIDO AS PE2
				INNER JOIN TB_CLIENTE AS CL2 ON CL2.ClienteId = PE2.ClienteId
				GROUP BY 
					CL2.NomeCompleto
			) AS QRY2 
	)
 
 /*
	Produtos mais vendidos que um produto específico:
	Liste os produtos que foram vendidos em quantidade maior do que o produto com ProdutoId = 3.
 */
 SELECT 
	PR.ProdutoId AS PRODUTO_ID,
	PR.Descricao AS NOME_PRODUTO,
	SUM(DE.Quantidade) AS TOTAL_VENDIDO
 FROM 
	TB_DETALHE_PEDIDO AS DE 
 INNER JOIN TB_PRODUTO AS PR ON PR.ProdutoId = DE.ProdutoId	
 GROUP BY
	PR.Descricao, PR.ProdutoId
 HAVING 
  SUM(DE.Quantidade) >(  
			SELECT
				SUM(DE2.Quantidade) AS QUANTIDADE_TOTAL
			FROM
				TB_DETALHE_PEDIDO AS DE2 
				INNER JOIN TB_PRODUTO AS PR2 ON PR2.ProdutoId = DE2.ProdutoId
			 WHERE
				PR2.ProdutoId= 17								
   )
  