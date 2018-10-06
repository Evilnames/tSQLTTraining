if exists (select * from sysobjects where name = 'ASprocThatCallsAFunction')
drop proc dbo.[ASprocThatCallsAFunction]
go
create procedure dbo.[ASprocThatCallsAFunction] 
AS
set nocount on

	DECLARE @I INT;

	SELECT @I = dbo.udf_AddTwoNumbers(2,2);

	IF(@I = 4)
		SELECT 'True' [Result];
	ELSE
		SELECT 'False' [Result];

GO

exec ASprocThatCallsAFunction 