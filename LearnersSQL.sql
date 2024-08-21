DECLARE @Name VARCHAR(50), @Surname NVARCHAR(50), @Email VARCHAR(100), @Telephone VARCHAR(20), @DateOfBirth DATE, @IDNumber VARCHAR(20);

INSERT INTO [Student] (FirstName, LastName, EmailAddress, TelephoneNo, DateOfBirth,IdNumber) 
VALUES (@Name, @Surname, @Email, @Telephone,@DateOfBirth, @IDNumber)