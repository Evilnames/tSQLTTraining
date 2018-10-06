if exists (select * from sysobjects where name = 'udf_AddTwoNumbers')
drop function udf_AddTwoNumbers
GO
CREATE FUNCTION dbo.udf_AddTwoNumbers
(
	@A INT,
	@B INT
)
-- WITH ENCRYPTION, SCHEMABINDING, EXECUTE AS CALLER|SELF|OWNER|USER
RETURNS INT
AS BEGIN
	RETURN @A + @B
END
GO

SELECT dbo.udf_AddTwoNumbers(1,1)