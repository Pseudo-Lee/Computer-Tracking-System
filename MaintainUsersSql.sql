--t=query to maintain users table incase of error

--DBCC CHECKIDENT('User',RESEED,0);
--TRUNCATE TABLE [User];
SELECT * FROM [User]