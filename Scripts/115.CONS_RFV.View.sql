USE [DB_PMITG_FGOS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CONS_RFV]
AS
WITH CTE_PED (
	   ID_CLIENTE
	  ,ID_PEDIDO
	  ,DEPARTAMENTO
	  ,VALOR_UNITARIO
	  ,PARCELAS
	  ,DATA_PEDIDO
	  ,MEIO_PAGAMENTO
		         )
AS
(
SELECT P.ID_CLIENTE			AS ID_CLIENTE
	  ,P.ID_PEDIDO			AS ID_PEDIDO
	  ,P.DEPARTAMENTO		AS DEPARTAMENTO
	  ,P.VALOR_UNITARIO		AS VALOR_UNITARIO
	  ,P.PARCELAS			AS PARCELAS
	  ,P.DATA_PEDIDO		AS DATA_PEDIDO
	  ,P.MEIO_PAGAMENTO		AS MEIO_PAGAMENTO
  FROM PEDIDOS P WITH(NOLOCK)
)
SELECT C.ID						   AS CLIENTE
      ,C.UF						   AS REGIAO
      ,C.CIDADE					           AS CIDADE
      ,dbo.MES_ANIVERSARIO(C.DATA_NASCIMENTO)		   AS CAMPANHA_ANIVERSARIO	--1: é mês de aniversário / 0: não é mês de aniversário
      ,PU.DATA_PEDIDO				           AS DATA_ULTIMA_COMPRA
      ,PU.DEPARTAMENTO				           AS ULTIMO_DEPTO_COMPRA
      ,PP.PARCELAS					   AS PARCELAMENTO_PREFER 
      ,PM.MEIO_PAGAMENTO			           AS MEIO_PAGAMENTO_PREFER
      ,PT.TICKET_MEDIO_ALL			           AS TICKET_MEDIO_ALL
      ,PTD.TICKET_MEDIO_12M			           AS TICKET_MEDIO_12M
      ,PT.FREQUENCIA_COMPRA_ALL		                   AS FREQUENCIA_COMPRA_ALL
      ,PTD.FREQUENCIA_COMPRA_12M	                   AS FREQUENCIA_COMPRA_12M
      ,dbo.RETORNA_TIER(ISNULL(PT.TICKET_MEDIO_ALL,0))     AS TIER_ATUAL
  FROM CLIENTES C WITH(NOLOCK)
  ------------------------------------#-----------------------------------------------------------------
  --Data da Última Compra e Último Departamento comprado
  LEFT JOIN  (SELECT PD.ID_CLIENTE
                    ,PD.DATA_PEDIDO
	            ,PD.DEPARTAMENTO
	            ,ROW_NUMBER() OVER(PARTITION BY PD.ID_CLIENTE ORDER BY PD.DATA_PEDIDO DESC) AS ORDEM
                FROM CTE_PED PD WITH(NOLOCK) ) PU ON PU.ID_CLIENTE = C.ID
		                                 AND PU.ORDEM = 1 
  ------------------------------------#-----------------------------------------------------------------
  --Parcelamento mais Praticado
  LEFT JOIN	(SELECT PT.ID_CLIENTE
		       ,PT.PARCELAS
		       ,ROW_NUMBER() OVER(PARTITION BY PT.ID_CLIENTE ORDER BY COUNT(PT.PARCELAS) DESC) AS ORDEM
		   FROM CTE_PED PT WITH(NOLOCK)
		   ROUP BY PT.ID_CLIENTE, PT.PARCELAS) PP ON PP.ID_CLIENTE = C.ID
		                                         AND PP.ORDEM = 1 
  ------------------------------------#-----------------------------------------------------------------
  --Meio de pagamento mais praticado
  LEFT JOIN	(SELECT PQ.ID_CLIENTE
		       ,PQ.MEIO_PAGAMENTO
		       ,ROW_NUMBER() OVER(PARTITION BY PQ.ID_CLIENTE ORDER BY COUNT(PQ.MEIO_PAGAMENTO) DESC) AS ORDEM
		   FROM CTE_PED PQ WITH(NOLOCK)
		  GROUP BY PQ.ID_CLIENTE, PQ.MEIO_PAGAMENTO) PM ON PM.ID_CLIENTE = C.ID
		                                               AND PM.ORDEM = 1 
  ------------------------------------#-----------------------------------------------------------------
  --Ticket médio e frequência de compras total 
  LEFT JOIN	(SELECT PC.ID_CLIENTE
		       ,CONVERT(NUMERIC(15,2),AVG(PC.VALOR_UNITARIO)) AS TICKET_MEDIO_ALL
		       ,COUNT(DISTINCT PC.ID_PEDIDO)		      AS FREQUENCIA_COMPRA_ALL 
		   FROM CTE_PED PC WITH(NOLOCK)
		   GROUP BY PC.ID_CLIENTE) PT ON PT.ID_CLIENTE = C.ID
  ------------------------------------#-----------------------------------------------------------------
  --Ticket médio e frequência de compras dos últimos 12 meses
  LEFT JOIN (SELECT PS.ID_CLIENTE
		   ,CONVERT(NUMERIC(15,2),AVG(PS.VALOR_UNITARIO)) AS TICKET_MEDIO_12M
		   ,COUNT(DISTINCT PS.ID_PEDIDO)		  AS FREQUENCIA_COMPRA_12M
	      FROM CTE_PED PS WITH(NOLOCK)
	     WHERE PS.DATA_PEDIDO >= GETDATE() - 360
	     GROUP BY PS.ID_CLIENTE) PTD ON PTD.ID_CLIENTE = C.ID
GO
