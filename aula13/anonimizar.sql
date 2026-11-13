USE PizzariaDB;
GO

-- TABELA DE AUDITORIA
CREATE TABLE Log_Auditoria 
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	tabelaAfetada VARCHAR(50) NOT NULL,
	operacao VARCHAR(20) NOT NULL,
	usuarioSGDB VARCHAR(100) NOT NULL DEFAULT SUSER_SNAME(),
	dataHora DATETIME NOT NULL DEFAULT GETDATE(),
	detalhes VARCHAR(MAX) NOT NULL
);

--PROCEDURE DE ANONIMIZAÇÃO (LGPD)
CREATE OR ALTER PROCEDURE sp_AnonimizarCliente
	@cliente_id INT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		--SELECIONAR UM CLIENTE, SE ELE EXISTIR 
		IF NOT EXISTS (SELECT 1 FROM Clientes WHERE id = @cliente_id)
		BEGIN 
			RAISERROR('Cliente não encontrado', 16, 1);
			RETURN
		END
		--ANONIMIZAR OS DADOS DO CLIENTE 
		UPDATE Clientes 
		SET nome = 'CLIENTE ANONIMIZADO - LGPD',
			telefone = '000000000',
			endereco = 'DADOS REMOVIDOS A PEDIDO DO TITULAR'
		WHERE id = @cliente_id 
		--GRAVA A AÇÃO NA TRILHA DA AUDITORIA
		INSERT INTO Log_Auditoria (tabelaAfetada, operacao, detalhes)
		VALUES ('Cliente', 'ANONIMIZAÇÃO_LGDP', 'Cliente ID' + @cliente_id + 'anonimizado conforme LGPD Art. 18');
	END TRY
	BEGIN CATCH 
		THROW;
	END CATCH
END;
GO



