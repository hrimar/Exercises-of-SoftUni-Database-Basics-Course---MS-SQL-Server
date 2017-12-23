CREATE TRIGGER tr_OrderDelivered ON Orders
AFTER UPDATE
AS
BEGIN
	DECLARE @OldStatus INT = (SELECT Delivered FROM deleted)
	DECLARE @NewStatus INT = (SELECT Delivered FROM inserted)

	IF(@OldStatus = 0 ANd @NewStatus = 1)
	BEGIN
		UPDATE Parts	
		SET StockQty+= op.Quantity
		FROM Parts AS p
		JOIN OrderParts AS op ON op.PartId = op.PartId
		JOIN Orders AS o ON o.OrderId = op.OrderId
		JOIN inserted AS i ON o.OrderId = i.OrderId
		JOIN deleted AS d ON d.OrderId = i.OrderId
		WHERE d.Delivered = 0 ANd i.Delivered = 1
	END
END

