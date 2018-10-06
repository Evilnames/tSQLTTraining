/*
	create table testMe (UserName varchar(50))
*/

if exists (select * from sysobjects where name = 'testInsertToTestMe')
drop proc dbo.[testInsertToTestMe]
go
create procedure dbo.[testInsertToTestMe] 
	@UserName VARCHAR(50)
AS
set nocount on
	INSERT INTO testMe(UserName)
	SELECT @UserName;	
GO

