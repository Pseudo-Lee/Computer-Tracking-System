-- Create the Component_Type table
CREATE TABLE [dbo].[Component_Type] (
    [CompTypeID]  INT PRIMARY KEY NOT NULL,
    [Description] TEXT NULL
);

-- Create the Component table
CREATE TABLE [dbo].[Component] (
    [ComponentID] INT IDENTITY(1, 1) PRIMARY KEY,    
    [Name]        VARCHAR(50) NULL,
    [Description] TEXT NULL,
    [CompTypeID]  INT NOT NULL,
    FOREIGN KEY ([CompTypeID]) REFERENCES [dbo].[Component_Type] ([CompTypeID])
);

-- Create the Computer_Condition table
CREATE TABLE [dbo].[Computer_Condition] (
    [ConditionID] INT PRIMARY KEY NOT NULL,
    [Description] TEXT NULL
);

-- Create the Student table
CREATE TABLE [dbo].[Student] (
    [LearnerID]     INT PRIMARY KEY NOT NULL,
    [FirstName]     VARCHAR(50) NULL,
    [LastName]      VARCHAR(50) NULL,
    [DateOfBirth]   DATE NULL,
    [University]    VARCHAR(50) NULL,
    [TelephoneNo]   VARCHAR(50) NULL,
    [EmailAddress]  VARCHAR(50) NULL
);

-- Create the Computer table
CREATE TABLE [dbo].[Computer] (
    [ComputerID]   INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
    [Serial_no]    VARCHAR(50) NULL,
    [Name]         VARCHAR(50) NULL,
    [Description]  TEXT NULL,
    [ConditionID]  INT NOT NULL,
    [DateOfIssue]  DATE NULL,
    [DateOfReturn] DATE NULL,
    [LearnerID]    INT NOT NULL,
    FOREIGN KEY ([ConditionID]) REFERENCES [dbo].[Computer_Condition] ([ConditionID]),
    FOREIGN KEY ([LearnerID]) REFERENCES [dbo].[Student] ([LearnerID])
);

-- Update table to track updates of components in computers
CREATE TABLE [dbo].[Update] (
    [UpdateID]     INT IDENTITY(1, 1) PRIMARY KEY,
    [ComputerID]   INT NOT NULL,
    [ComponentID]  INT NOT NULL,
    [DateOfUpdate] DATE NULL,
    FOREIGN KEY ([ComputerID]) REFERENCES [dbo].[Computer] ([ComputerID]),
    FOREIGN KEY ([ComponentID]) REFERENCES [dbo].[Component] ([ComponentID])
);

-- Create the User table
CREATE TABLE [dbo].[User] (
    [UserID]   INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
    [Name]     VARCHAR(50) NULL,
    [Password] VARCHAR(50) NULL
);
