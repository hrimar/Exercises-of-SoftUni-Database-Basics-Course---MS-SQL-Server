CREATE PROC usp_SendFeedback(@CustomerId INT, 
		@ProductId INT, @Rate DECIMAL(4, 2), @Desctription VARCHAR(250))
AS
BEGIN

BEGIN TRANSACTION
	 INSERT INTO Feedbacks (CustomerId, ProductId, Rate, Description)
	 VALUES (@CustomerId, @ProductId, @Rate, @Desctription )

	 DECLARE @FeedbackCount INT = (
		SELECT COUNT(f.Id)
		FROM Feedbacks AS f
		WHERE ProductId = @ProductId 
		AND CustomerId = @CustomerId
		)
		IF(@FeedbackCount > 3)
		BEGIN
			ROLLBACK
			RAISERROR('You are limited to only 3 feedbacks per product!', 16, 1)

		END
		ELSE
			COMMIT
END

EXEC usp_SendFeedback 1, 5, 7.50, 'Average experience';
SELECT COUNT(*) FROM Feedbacks WHERE CustomerId = 1 AND ProductId = 5;
