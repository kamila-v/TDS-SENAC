USE PizzariaDB;
GO

--DECLARAÇÃO DE VARIÁVEL
DECLARE @idGerado INT;

-- CHAMADA STORAGE PROCEDURE
EXEC sp_CadastrarCliente
	@nome = 'Felipe Marins',
	@telefone = '1199887766',
	@endereco = 'Rua Alta, 500',
	@novoId = @idGerado OUT;

	SELECT * FROM Clientes;
