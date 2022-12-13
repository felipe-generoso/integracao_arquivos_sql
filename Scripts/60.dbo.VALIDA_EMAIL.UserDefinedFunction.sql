USE [DB_PMITG_FGOS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[VALIDA_EMAIL] (@EMAIL VARCHAR(200))
RETURNS INT
AS
BEGIN

	DECLARE @EMAIL_VALIDO INT = 0 ---1 para Sim / 0 para Não

	SELECT @EMAIL_VALIDO = 1
	 WHERE @EMAIL LIKE '%@%'
           AND @EMAIL LIKE '%.%'
           AND @EMAIL NOT LIKE '%.@%'
           AND @EMAIL NOT LIKE '%@.%'
	   AND LEN(LTRIM(RTRIM(@EMAIL))) - LEN(REPLACE(LTRIM(RTRIM(@EMAIL)),'@','')) = 1 --Apenas um arroba por e-mail é permitido
	   AND CHARINDEX(' ',LTRIM(RTRIM(@EMAIL))) = 0					 --Não é possível ter espaços
	   AND LEFT(LTRIM(@EMAIL),1) <> '@'						 --O arroba não pode ser o primeiro caractér
	   AND RIGHT(RTRIM(@EMAIL),1) <> '.'						 --O ponto não pode ser o primeiro caractér
	   AND CHARINDEX('.',@EMAIL,CHARINDEX('@',@EMAIL)) - CHARINDEX('@',@EMAIL) > 1   --Deve haver um ponto após o arroba
	   AND CHARINDEX('.',REVERSE(LTRIM(RTRIM(@EMAIL)))) >= 3			 --O nome do domínio deve finalizar com dois caractéres

	RETURN @EMAIL_VALIDO

END
GO
