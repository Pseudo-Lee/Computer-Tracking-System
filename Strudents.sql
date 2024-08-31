DECLARE @FirstName VARCHAR(50);
DECLARE @LastName VARCHAR(50);
DECLARE @DateOfBirth DATE;
DECLARE @University VARCHAR(50);
DECLARE @TelephoneNo VARCHAR(50);
DECLARE @EmailAddress VARCHAR(50);
DECLARE @IdNumber VARCHAR(50);
DECLARE @Gender VARCHAR(2);
DECLARE @LearnerID INT;
--DELETE FROM Student


-- Insert the values into the Student table
INSERT INTO [Student] 
    (FirstName, LastName, DateOfBirth, University, TelephoneNo, EmailAddress, IdNumber, Gender) 
VALUES 
    (@FirstName, @LastName, @DateOfBirth, @University, @TelephoneNo, @EmailAddress, @IdNumber, @Gender);

-- Retrieve all records from the Student table
UPDATE Student SET FirstName=@FirstName, LastName=@LastName, EmailAddress=@EmailAddress, IdNumber=@IdNumber, Gender=@Gender WHERE LearnerID=@LearnerID;
                    

SELECT * FROM [Student];
