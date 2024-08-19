CREATE PROCEDURE UpdateUserPassword
    @Username NVARCHAR(50),
    @IDNumber NVARCHAR(50),
    @Email NVARCHAR(100),
    @NewPassword NVARCHAR(100)
AS
BEGIN
    -- Check if user exists with the provided credentials
    IF EXISTS (SELECT 1 FROM [User] WHERE Name = @Username AND UserID = @IDNumber AND Email = @Email)
    BEGIN
        -- Update the password if user is found
        UPDATE [User]
        SET Password = @NewPassword
        WHERE Name = @Username AND UserID = @IDNumber AND Email = @Email;

        -- Return success message
        SELECT 'Password updated successfully' AS Message;
    END
    ELSE
    BEGIN
        -- Return error message if validation fails
        SELECT 'User not found or invalid credentials' AS Message;
    END
END;
