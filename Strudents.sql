DECLARE @FirstName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);
DECLARE @DateOfBirth DATE;
DECLARE @University NVARCHAR(50);
DECLARE @TelephoneNo NVARCHAR(50);
DECLARE @EmailAddress NVARCHAR(50);
DECLARE @IdNumber NVARCHAR(50);
DECLARE @Gender BIT;

-- Assign values to the variables
SET @FirstName = 'John';
SET @LastName = 'Doe';
SET @DateOfBirth = '1995-06-15'; -- Use the format YYYY-MM-DD for dates
SET @University = 'Example University';
SET @TelephoneNo = '1234567890';
SET @EmailAddress = 'johndoe@example.com';
SET @IdNumber = '987654321';
SET @Gender = 0; -- 0 for Male, 1 for Female

-- Insert the values into the Student table
INSERT INTO [Student] 
    (FirstName, LastName, DateOfBirth, University, TelephoneNo, EmailAddress, IdNumber, Gender) 
VALUES 
    (@FirstName, @LastName, @DateOfBirth, @University, @TelephoneNo, @EmailAddress, @IdNumber, @Gender);

-- Retrieve all records from the Student table
SELECT * FROM [Student];
