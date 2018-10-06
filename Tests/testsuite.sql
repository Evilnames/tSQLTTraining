/***************
	This defines a new 'schema' or group of tests that we will work with.
****************/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'TestSuite')
BEGIN
	EXEC TsqlT.NewTestClass 'TestSuite';
END

GO


if exists (select * from sysobjects where name = 'fake_udf_AddTwoNumbers')
drop function dbo.fake_udf_AddTwoNumbers
GO
CREATE FUNCTION dbo.fake_udf_AddTwoNumbers
(
	@A INT,
	@B INT
)
-- WITH ENCRYPTION, SCHEMABINDING, EXECUTE AS CALLER|SELF|OWNER|USER
RETURNS INT
AS BEGIN
	RETURN 5;
END
GO


GO

if EXISTS (select * from sysobjects where name = 'test ASprocThatcallsAFunction actually can fail')
drop proc TestSuite.[test ASprocThatcallsAFunction actually can fail]
go
create procedure TestSuite.[test ASprocThatcallsAFunction actually can fail] 
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
set nocount on
	
	--Assemble
		DECLARE @ExpectedOutput VARCHAR(25) = 'False',
				@ActualOutput	VARCHAR(25);

		EXEC tsqlt.FakeFunction @FunctionName = 'dbo.udf_AddTwoNumbers'
							   ,@FakeFunctionName = 'dbo.fake_udf_AddTwoNumbers'
		
		DECLARE @Test TABLE (Result VARCHAR(25));

	--Act
	INSERT INTO @Test
	EXEC ASprocThatCallsAFunction	

	SELECT @ActualOutput = Result 
	FROM @Test;

	--Assert
	EXEC tSqlt.AssertEquals @ExpectedOutput, @ActualOutput, 'it should return a false if the function has the wrong results';
GO


EXEC tsqlt.run 'TestSuite';