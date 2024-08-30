DECLARE @FirstName VARCHAR(50);
DECLARE @LastName VARCHAR(50);
DECLARE @DateOfBirth DATE;
DECLARE @University VARCHAR(50);
DECLARE @TelephoneNo VARCHAR(50);
DECLARE @EmailAddress VARCHAR(50);
DECLARE @IdNumber VARCHAR(50);
DECLARE @Gender VARCHAR(2);



-- Insert the values into the Student table
INSERT INTO [Student] 
    (FirstName, LastName, DateOfBirth, University, TelephoneNo, EmailAddress, IdNumber, Gender) 
VALUES 
    (@FirstName, @LastName, @DateOfBirth, @University, @TelephoneNo, @EmailAddress, @IdNumber, @Gender);

-- Retrieve all records from the Student table

SELECT * FROM [Student];
