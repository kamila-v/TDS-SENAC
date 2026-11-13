USE PizzariaDB;
GO

SELECT * FROM Clientes;

CREATE OR ALTER PROCEDURE sp_BuscarClientesPorNome
	@nome VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;
	-- SGDB RECEBE VARIAVEL LITERAL
	SELECT * FROM Clientes WHERE nome LIKE '%'+ @nome + '%';

END;
GO

DECLARE @nomeABuscar VARCHAR(100) = 'silva';
EXEC sp_BuscarClientesPorNome @nomeABuscar;