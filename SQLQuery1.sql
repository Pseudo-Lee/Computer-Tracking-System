-- Declare variables for user credentials
DECLARE @Name NVARCHAR(50);
DECLARE @Password NVARCHAR(50);

-- Set the variables (replace these with actual user input values)
SET @Name = 'admin';
SET @Password = 'password123';

-- Select statement to check user credentials
SELECT COUNT(*) 
FROM [User]
WHERE Name = @Name AND Password = @Password;

-- Insert default users into the [User] table
INSERT INTO [User] (Name, Password) VALUES ('admin', 'password123');
INSERT INTO [User] (Name, Password) VALUES ('user1', 'password456');
INSERT INTO [User] (Name, Password) VALUES ('user2', 'password789');

