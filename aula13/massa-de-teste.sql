USE EstacionamentoDB;
GO

-- GERAR MASSA DE TESTE (5K REGISTROS)
SET NOCOUNT ON;
DECLARE @i INT = 1;
WHILE @i <= 5000
BEGIN 
	INSERT INTO RegistrosEstacionamento (veiculo_id, vaga_id, data_hora_entrada, data_hora_saida, valor_total)
	VALUES (3, 1, DATEADD(MINUTE, -@i, GETDATE()), DATEADD(MINUTE, -@i, GETDATE()), 25.00);
	SET @i = @i + 1;
END;
GO

INSERT INTO RegistrosEstacionamento (veiculo_id, vaga_id, data_hora_entrada, data_hora_saida,valor_total)
VALUES (3, 1, )

SELECT * FROM RegistrosEstacionamento

--HABILITAR METRICAS E/S E TEMPO
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- CONSULTA EM CAMPOS SEM ÍNDICE 
SELECT * FROM RegistrosEstacionamento;