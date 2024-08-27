CREATE TABLE [dbo].[User] (
    [UserID]   INT          IDENTITY (1, 1) NOT NULL,
    [Name]     VARCHAR (50) NULL,
    [Password] VARCHAR (50) NULL,
    [IsAdmin] BIT NULL, 
    PRIMARY KEY CLUSTERED ([UserID] ASC)
);

