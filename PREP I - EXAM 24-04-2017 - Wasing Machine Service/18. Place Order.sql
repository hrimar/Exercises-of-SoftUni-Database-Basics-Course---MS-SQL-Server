		-- ÎÒÂÐÀÒ ÇÀÄÀ×À 0/6 !!!!!
CREATE PROC usp_PlaceOrder(@JobId INT, @PartSN VARCHAR(50), @Quantity INT)
AS
BEGIN
	
	IF (@Quantity <=0)
	BEGIN
		RAISERROR('Part quantity must be more than zero!', 16, 1)
		RETURN
	END
	
	DECLARE @JobIdSelected INT = (select @@ROWCOUNT from Jobs
WHERE JobId = @JobId)
	If(@JobIdSelected IS NULL)
	BEGIN
		RAISERROR('Job not found!', 16, 1)
		RETURN
	END

	DECLARE @JobStatus VARCHAR(11) = ( SELECT Status FROM Jobs
WHERE JobId = @JobId  )
	IF (@JobStatus = 'Finished')
	BEGIN
		RAISERROR('This job is not active!', 16, 1)
		RETURN
	END
	
	

	DECLARE @DoesPartExist INT = (select @@ROWCOUNT from Parts
WHERE SerialNumber = @PartSN)
	If(@DoesPartExist IS NULL)
	BEGIN
		RAISERROR('Part not found!', 16, 1)
		RETURN
	END

	DECLARE @OrderId INT = (SELECT o.OrderId FROM Orders AS o
	JOIN OrderParts AS op On op.OrderId = o.OrderId
	JOIN Parts AS p On p.PartId = op.PartId
	WHERE JobId = @JobId AND p.PartId = @DoesPartExist)

	----Order does not exist -> create new order:
	IF(@OrderId IS NULL)
	BEGIN
		INSERT INTO Orders(JobId, IssueDate) VALUES
		(@JobId, NULL)
		INSERT INTO OrderParts(OrderId, PartId, Quantity) VALUES
		(IDENT_CURRENT('Orders'), @DoesPartExist, @Quantity)
	END
	ELSE
	BEGIN
		DECLARE @PartExistInOrder INT = (	SELECT @@ROWCOUNT FROM OrderParts
		WHERE OrderId = @OrderId AND PartId = @DoesPartExist)

	IF(@PartExistInOrder IS NULL)
	BEGIN
		--Order Exist, part not exist -> add part to order:
		INSERT INTO OrderParts(OrderId, PartId, Quantity) VALUES
		(@OrderId, @DoesPartExist, @Quantity)
	END
	ELSE
	BEGIN
		--Order Exist, part exist -> increase part quantity in order
		UPDATE OrderParts
		SET Quantity += @Quantity
		WHERE OrderId = @OrderId AND PartId = @DoesPartExist
	END
	END
	
END
