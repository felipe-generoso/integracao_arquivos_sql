USE [DB_PMITG_FGOS]
GO
/****** Object:  StoredProcedure [dbo].[GETFILES]    Script Date: 10/12/2019 00:37:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GETFILES] (@DIRETORIO VARCHAR(200), @TABELA VARCHAR(200))  
AS  
BEGIN  
  
 IF OBJECT_ID('TEMPDB..#ARQUIVOS') IS NOT NULL  
  DROP TABLE #ARQUIVOS  
  
 CREATE TABLE #ARQUIVOS  
  (  
	 ID		      NUMERIC(15) IDENTITY(1,1)  
    ,NOME_ARQUIVO NVARCHAR(512)  
    ,DEPTH		  INT  
    ,FLAG_ARQUIVO BIT  
  )  
  
 INSERT INTO #ARQUIVOS  
 EXEC xp_dirtree @DIRETORIO, 2, 1 
   
 --Só efetua a inserção de novos arquivos se os mesmos não existirem  
   
 INSERT INTO INTEGRACAO_ARQUIVOS  
 (  
    NOME_ARQUIVO 
   ,TABELA
 )  
 SELECT A.NOME_ARQUIVO  
	   ,@TABELA 
   FROM #ARQUIVOS A  
   LEFT JOIN INTEGRACAO_ARQUIVOS IA WITH(NOLOCK) ON IA.NOME_ARQUIVO = A.NOME_ARQUIVO  
  WHERE A.FLAG_ARQUIVO = 1  
    AND IA.NOME_ARQUIVO IS NULL  
  
END  
GO
