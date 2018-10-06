/***************
	This defines a new 'schema' or group of tests that we will work with.
****************/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'functionTester')
BEGIN
	EXEC TsqlT.NewTestClass 'functionTester';
END

GO

/*******************
	Each test must start with the word TEST
*******************/
if EXISTS (select * from sysobjects where name = 'test udf_AddTwoNumber it should add one plus one to equal two')
drop proc functionTester.[test udf_AddTwoNumber it should add one plus one to equal two]
GO
/*********************
	You always create the test in the schema you defined in the 'newtestclass' area above.
*********************/
create procedure functionTester.[test udf_AddTwoNumber it should add one plus one to equal two] 

AS
set nocount on

	/***********************
		The first sections of this are to assemble and act on the data.
	***********************/
	--Assemble
		DECLARE				@Expected			INT			=		2,
							@Actual				INT;
	--Act
	SELECT @Actual = dbo.udf_AddTwoNumbers(1,1);

	--Assert
	/*******************
		The purpose of the assertequals is to validate that the expected = actual.
	********************/
	EXEC tSqlt.AssertEquals @Expected, @Actual, '1 + 1 equals 2';
GO


/*******************
	This simply tells the system to run all of the tests inside of this schema.
*******************/
EXEC tsqlt.run 'functionTester';
