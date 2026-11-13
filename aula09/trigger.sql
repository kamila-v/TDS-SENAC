USE PizzariaDB;
GO


--	Trigger para calcular valor_total 
CREATE OR ALTER TRIGGER tgr_AtualizarValorTotalPedido
ON Pedido_Itens 
AFTER INSERT, UPDATE, DELETE
AS BEGIN
	SET NOCOUNT ON;

	-- DESCOBRIR QUAIS PEDIDOS SOFRERAM ALTERAÇÃO
	DECLARE @PedidosModificados TABLE (pedido_id INT);

	SELECT pedido_id FROM inserted
	UNION
	SELECT pedido_id FROM deleted;

	-- RECALCULAR E ATUALIZAR CADA PEDIDO AFETADO
	UPDATE p
	SET p.valor_total = ISNULL ((
		SELECT SUM(pdi.quantidade * pdi.valor_unitario)
		FROM Pedido_Itens pdi 
		WHERE pdi.pedido_id = p.id
	), 00)
	FROM Pedidos p
	INNER JOIN @PedidosModificados m ON p.id = m.pedido_id
END;
GO
