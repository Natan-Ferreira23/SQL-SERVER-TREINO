
-- 1) Quais cargos possuem media salarial maior que a média salarial do coordenador de vendas internas ?

SELECT
	Cargo
FROM
	TB_FUNCIONARIO f1
WHERE
	(SELECT AVG(f3.Salario) FROM TB_FUNCIONARIO f3 WHERE f1.Cargo=f3.Cargo) 
	> 
	(SELECT AVG(f2.Salario) FROM TB_FUNCIONARIO f2 WHERE UPPER(f2.Cargo)='COORDENADOR DE VENDAS INTERNAS')

-- 2) Qual produto teve mais vendas em 07 de 1996
SELECT 
	c1.Descricao,
	c1.Quantidade
FROM
(
	SELECT 
		TOP 1
		p.Descricao,
		SUM(d.Quantidade) [Quantidade]
	FROM 
		TB_PRODUTO p
	INNER JOIN TB_DETALHE_PEDIDO  d ON d.ProdutoId = p.ProdutoId
	WHERE
		d.NumeroPedido IN (
			SELECT
				pe.NumeroPedido
			FROM
				TB_PEDIDO pe
			WHERE
				pe.DataPedido BETWEEN '1996-07-01' AND '1996-07-31'
		)
	GROUP BY
		p.Descricao
	ORDER BY 
		Quantidade DESC
) as c1

-- 03) Vendedor que teve o maior valor no total de suas vendas
SELECT
	c1.NomeCompleto,
	c1.Total
FROM
	(
		SELECT 
		 TOP 1
		 c2.NomeCompleto,
		 SUM(d.Preco) Total
		FROM
			TB_DETALHE_PEDIDO d
		JOIN (
			SELECT 
				pe.NumeroPedido, f.NomeCompleto 				
			FROM
				TB_PEDIDO pe
			JOIN
				TB_FUNCIONARIO f ON f.FuncionarioId=pe.FuncionarioId
			WHERE
				UPPER(f.Cargo)='REPRESENTANTE DE VENDAS'
		) AS c2
		on c2.NumeroPedido=d.NumeroPedido
		GROUP BY
			c2.NomeCompleto
		ORDER BY
			Total DESC
	 ) AS c1

--4)traga a descrição dos produtos que possuem o preço maior que a média de todos os produtos
SELECT
	p1.Descricao
FROM
	TB_PRODUTO p1
WHERE
	p1.Preco>(SELECT AVG(p2.Preco) FROM TB_PRODUTO p2)

--5) traga todos os clientes que possuem pedidos no mes 7 de 1996**
SELECT
*
FROM
TB_CLIENTE c
WHERE
c.ClienteId IN (SELECT p.ClienteId FROM TB_PEDIDO p WHERE p.DataPedido BETWEEN '1996-07-01' AND '1996-07-31')
Order By
c.ClienteId

-- 6) traga o nome e o total de pedidos de cada cliente**
SELECT
	c.NomeCompleto,
	(SELECT COUNT(*) FROM TB_PEDIDO p WHERE c.ClienteId=p.ClienteId) [total_pedido]
FROM
	TB_CLIENTE c	
ORDER BY
	[total_pedido]

--7) Qual produto teve a maior quantidade de vendas no mes 7 de 1996

SELECT
	TOP 1
	p.Descricao produto,	
	SUM(d.Quantidade) quantidade
FROM
	TB_DETALHE_PEDIDO d
INNER JOIN TB_PRODUTO p ON p.ProdutoId = d.ProdutoId
INNER JOIN TB_PEDIDO pe ON pe.NumeroPedido = d.NumeroPedido
WHERE
	pe.DataPedido between '1996-07-01' AND '1996-07-31'
GROUP BY
	p.Descricao
ORDER BY
	SUM(d.Quantidade) DESC

--8) Qual cliente teve mais gastos no mes 7 de 1996**

SELECT
	TOP 1
	NomeCompleto,
	SUM(d.Preco) as gastos
FROM
	TB_PEDIDO pe
INNER JOIN TB_CLIENTE c ON  c.ClienteId = pe.ClienteId
INNER JOIN TB_DETALHE_PEDIDO d ON d.NumeroPedido=pe.NumeroPedido
WHERE
	pe.DataPedido between '1996-07-01' AND '1996-07-31'
GROUP BY
	NomeCompleto
Order by
	SUM(d.Preco) DESC

--9) Listar todos os clientes que moram na alemanha
SELECT 
	*
FROM 
	TB_CLIENTE c
INNER JOIN TB_ENDERECO e ON e.ClienteId = c.ClienteId
WHERE 
	upper(e.Pais)='ALEMANHA'

--10)Listar todos os clientes que compraram da categoria bebida**
--tabelas

SELECT 
	c.NomeCompleto 
FROM
	TB_PEDIDO pe
INNER JOIN TB_CLIENTE c ON c.ClienteId= pe.ClienteId
INNER JOIN TB_DETALHE_PEDIDO d ON d.NumeroPedido=pe.NumeroPedido
INNER JOIN TB_PRODUTO p	ON p.ProdutoId=d.ProdutoId
INNER JOIN TB_CATEGORIA ca ON ca.CategoriaId= p.CategoriaId
WHERE 
	UPPER(ca.Descricao)='BEBIDAS'
ORDER BY
	c.NomeCompleto

-- 11) unindo tabelas porém não tras valores repetidos
SELECT NomeCompleto, Contato, Cargo from TB_CLIENTE
UNION
SELECT Empresa, Contato, Cargo FROM TB_FORNECEDOR
--12) utilizando o union all, caso houver item repetido ele traz também
SELECT 
	pais,'cliente' 
FROM 
	TB_ENDERECO
WHERE
	ClienteId is not null
UNION all
SELECT pais,'fornecedor' FROM TB_ENDERECO WHERE FornecedorId is not null