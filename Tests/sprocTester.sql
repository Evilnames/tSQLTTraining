IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'sprocTester')
BEGIN
	EXEC TsqlT.NewTestClass 'sprocTester';
END

GO

if EXISTS (select * from sysobjects where name = 'test testInsertToTestMe it should insert a row')
drop proc sprocTester.[test testInsertToTestMe it should insert a row]
go
create procedure sprocTester.[test testInsertToTestMe it should insert a row] 
AS
set nocount on

	--Assemble
	/**********
		Clear out our testme table so that we now nothing is inside of it.
	**********/
		EXEC tSQLt.FakeTable @TableName = 'testMe';

		DECLARE @ExpectedRows		INT		=	1,
				@ActualRows			INT;

	--Act
		EXEC testInsertToTestMe 'Alex';

		SELECT @ActualRows = COUNT(*) FROM testme;

	--Assert
	EXEC tSqlt.AssertEquals @ExpectedRows, @ActualRows, 'it should insert one row';

GO

GO 

EXEC tsqlt.run 'sprocTester';