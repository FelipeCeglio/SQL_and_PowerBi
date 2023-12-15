/* 

ESTRUTURA DO PROJETO // KPIs:

	1-> GERAL:
		a. Receita Total / Ano;
		b. Quantidade Vendida / Ano;
		c. Total de Categorias de Produtos / Ano;
		d. Quantidade de Clientes / Ano;
		e. Receita vs. Lucro / M�s;
		f. Margem do Lucro / M�s;
		g. Quantidade Vendida / M�s;
		h. Lucro por Pa�s / M�s;
		
	2-> CLIENTE:
		a. Vendas por Pa�s;
		b. Clientes por Pa�s;
		c. Vendas por Genero;
		d. Vendas por Categoria;


TABELAS DE REFER�NCIAS:


	FactInternetSales
	DimProductCategory ** em cadeia com DimProduct
	DimGeography
	DimCustomer


COLUNAS:
	SalesOrderNumber				Tabela: FactInternetSales
	OrderDate						Tabela: FactInternetSales
	EnglishProductCategoryName		Tabela: DimProductCategory
	CustomerKey						Tabela: DimCustomer
	FirstName + LastName			Tabela: DimCustomer
	Gender							Tabela: DimCustomer
	EnglishCountryRegionName		Tabela: DimGeography
	OrderQuantity					Tabela: FactInternetSales
	SalesAmount						Tabela: FactInternetSales
	TotalProductCost				Tabela: FactInternetSales
	Profit							Opera��o Matem�tica: Venda - Custo
	
*/

CREATE OR ALTER VIEW VENDAS_INTERNET_2010_2013 AS
SELECT
	fis.SalesOrderNumber AS 'Order No',
	fis.OrderDate AS 'Order Date',
	dpc.EnglishProductCategoryName AS 'Product Category',
	fis.CustomerKey AS 'Customer ID',
	dc.FirstName + ' ' + dc.LastName AS 'Customer Name',
	REPLACE(REPLACE(dc.Gender, 'M', 'Male'), 'F', 'Female') AS 'Gender',
	dg.EnglishCountryRegionName AS 'Country',
	fis.OrderQuantity AS 'Order Qtd',
	fis.TotalProductCost AS 'Order Cost',
	fis.SalesAmount AS 'Order Revenue',
	fis.SalesAmount - fis.TotalProductCost  AS 'Profit'
FROM
	FactInternetSales AS fis
INNER JOIN DimProduct AS dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory AS dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory AS dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN  DimCustomer AS dc ON fis.CustomerKey = dc.CustomerKey
	INNER JOIN DimGeography AS dg ON dc.GeographyKey = dg.GeographyKey


SELECT * FROM VENDAS_INTERNET_2010_2013
