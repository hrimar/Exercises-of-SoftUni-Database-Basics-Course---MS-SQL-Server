CREATE FUNCTION udf_GetCost(@jobId INT)
RETURNS DECIMAL(15,2)
AS
BEGIN
	DECLARE @Result DECIMAL(15,2)=
	(
	SELECT ISNULL(SUM(p.Price*op.Quantity), 0) AS 'Parts Total'
	 FROM Parts AS p
	JOIN OrderParts AS op ON op.PartId = p.PartId
	JOIN Orders AS o ON o.OrderId = op.OrderId
	JOIN Jobs AS j ON j.JobId = o.JobId
	WHERE o.JobId= @jobId
	)
RETURN @Result
END

SELECT dbo.udf_GetCost(1) AS Result