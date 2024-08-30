-- Declare variables
DECLARE @Name NVARCHAR(50);
DECLARE @Surname NVARCHAR(50);
DECLARE @IdNumber VARCHAR(13);
DECLARE @Cellphone VARCHAR(20);
DECLARE @Email NVARCHAR(100);
DECLARE @Password VARCHAR(64);


INSERT INTO [User] (Name,Surname,IdNumber,Email,Cellphone, Password )
VALUES (@Name, @Surname,@IdNumber, @Email,@Cellphone , @Password);
SELECT * FROM [User]