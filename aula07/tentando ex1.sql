/*
EstacionamentoDB:
 
- Crie uma procedure sp_RegistrarEntradaVeiculo
- Parâmetros: @placa, @vaga_id, @registro_id INT OUTPUT
- Deve buscar o id do veiculo pela placa informada e registrar a entrada com data/hora atual
- O parametro para buscar data e hora atual é o "GATEDATE()"
*/

USE EstacionamentoDB;
GO

-- procedure para cadastrar VEICULOS
CREATE OR ALTER PROCEDURE dbo.sp_RegistrarEntradaVeiculo
	@placa VARCHAR(7),
	@vaga_id INT OUTPUT,
	@registro_id INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validação    
	IF EXISTS (SELECT 1 FROM Veiculos WHERE Vaga = @vaga_id)
	BEGIN 
		RAISERROR('Vaga indisponível', 16, 1); --sera q ta certo???
		RETURN;
	END

	INSERT INTO Veiculos (placa, vaga, registro)
	VALUES (@placa, @vaga_id, @registro_id);

	SET @registro_id = SCOPE_IDENTITY();

END;
GO