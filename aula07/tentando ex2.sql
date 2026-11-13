USE EstacionamentoDB;
GO

--DECLARAÇÃO DE VARIÁVEL
DECLARE @idGerado INT;

-- CHAMADA STORAGE PROCEDURE
EXEC sp_RegistrarEntradaVeiculo
	@placa = 'th356d',
	@vaga_id = '33',
	@registro_id = 'vaga33',
	@novoId = @idGerado OUT;

	SELECT * FROM Veiculos;