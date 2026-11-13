USE EstacionamentoDB;
GO

--CTRL + K + U descomenta
--ctrl + K + C COMENTA

--DECLARE @entrada DATETIME = '2026-24-09 14:00:00';
--DECLARE @saida DATETIME = '2026-24-09 16:15:00';


----DATEDIFF ARREDONDA O VALOR, CEILING ARREDONDA PRA CIMA E FLOOR ARREDONDA PRA BAIXO. 
--DECLARE @minutos INT = DATEDIFF(MINUTE, @entrada, @saida); --135min
--DECLARE @horasCobradas INT = CEILING(@minutos/60.0); 


--DECLARE @tarifaPrimeiraHora DECIMAL(10,2) = 15.00;
--DECLARE @tarifaAdicional DECIMAL(10,2) = 10.00
--DECLARE @total DECIMAL(10,2);

--IF @minutos <= 15
--	SET @total = 0.00; --tolerancia
--ELSE IF @horasCobradas = 1 
--	SET @total = @tarifaPrimeiraHora
--ELSE 
--	SET @total = @tarifaPrimeiraHora + (@tarifaAdicional * (@horasCobradas -1));

--visualização do resultado em tabela
--SELECT 
--	@minutos AS Minutos,
--	@horasCobradas AS Horas,
--	@total AS TotalAPagar;


--CRIAÇÃO STORGE PROCEDURE
CREATE OR ALTER PROCEDURE sp_RegistrarSaidaVeiculo
	@registro_id INT
AS

BEGIN
	SET NOCOUNT ON;
	BEGIN TRY 
		-- CODIGO QUE PODE DAR ERRADO
		DECLARE @entrada DATETIME, @saida DATETIME, @minutos INT, @horasCobradas INT, @total DECIMAL(10,2);
		DECLARE @tarifaPrimeiraHora DECIMAL(10,2) = 15.00;
		DECLARE @tarifaAdicional DECIMAL(10,2) = 10.00 

		SELECT @entrada = data_hora_entrada, @saida = data_hora_saida 
		FROM RegistrosEstacionamento 
		WHERE id = @registro_id; 

		IF @entrada IS NULL
			THROW 5001, 'Registro de estacionamento não encontrado.', 1;

		IF @entrada IS NOT NULL
			THROW 5002, 'Este veículo já registrou a saída.', 1;

		SET @saida =GETDATE();
		SET @minutos = DATEDIFF(MINUTE, @entrada,@saida);
		SET @horasCobradas =CEILING(@minutos/60.0);

		IF @minutos <= 15
			SET @total = 0.00; --tolerancia
		ELSE IF @horasCobradas = 1 
			SET @total = @tarifaPrimeiraHora
		ELSE 
			SET @total = @tarifaPrimeiraHora + (@tarifaAdicional * (@horasCobradas -1));

			UPDATE RegistrosEstacionamento
			SET data_hora_saida = @saida, valor_total = @total
			WHERE id = @registro_id;
		END TRY
		BEGIN CATCH
	--CAPTURA O ERRO, FAZ ROLLBACK, LANÇA O ERRO COM trhow
	THROW;
	END CATCH
END;
GO

SELECT * FROM RegistrosEstacionamento;

--DATEDIFF ARREDONDA O VALOR, CEILING ARREDONDA PRA CIMA E FLOOR ARREDONDA PRA BAIXO. 