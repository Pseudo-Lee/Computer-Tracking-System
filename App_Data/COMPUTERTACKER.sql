CREATE TABLE [dbo].[Component_Type] (
    [CompTypeID]  INT PRIMARY KEY NOT NULL,
    [Description] TEXT NULL,
   
);
CREATE TABLE [dbo].[Component] (
    [ComponentID] INT   IDENTITY(1, 1) PRIMARY KEY,    
    [Name]        VARCHAR (50) NULL,
    [Description] TEXT         NULL,
    [CompTypeID]  INT          NOT NULL,
   FOREIGN KEY REFERENCES Component_Type(CompTypeID),
);

CREATE TABLE [dbo].[Computer] (
    [ComputerID]   INT    PRIMARY KEY      NOT NULL,
    [Serial_no]    VARCHAR (50) NULL,
    [Name]         VARCHAR (50) NULL,
    [Description]  TEXT         NULL,
    [ConditionID]  INT          NOT NULL,
    [DateOfIssue]  DATE         NULL,
    [DateOfReturn] DATE         NULL,
   FOREIGN KEY REFERENCES Computer_Condition(ConditionID),
      FOREIGN KEY REFERENCES Student(LearnerID),
);

CREATE TABLE [dbo].[Computer_Condition] (
    [ConditionID] INT PRIMARY KEY NOT NULL,
    [Description] TEXT NULL,
   
);


CREATE TABLE [dbo].[Student] (
    [LearnerID]     INT   PRIMARY KEY       NOT NULL,
    [FirstName]     VARCHAR (50) NULL,
    [LastName]      VARCHAR (50) NULL,
    [DateOfBirth]   DATE         NULL,
    [University]    VARCHAR (50) NULL,
    [TelephoneNo]   VARCHAR (50) NULL,
    [EmailAddress]  VARCHAR (50) NULL,
    [ComputerID]    INT          NOT NULL,
	   FOREIGN KEY REFERENCES Computer(ComputerID),
);


CREATE TABLE [dbo].[Update] (
    [ComputerID]   INT PRIMARY KEY NOT NULL,
    [ComponentID]  INT  NOT NULL,
    [DateOfUpdate] DATE NULL,
   
    FOREIGN KEY ([ComputerID]) REFERENCES [dbo].[Computer] ([ComputerID]),
    FOREIGN KEY ([ComponentID]) REFERENCES [dbo].[Component] ([ComponentID])
);


CREATE TABLE [dbo].[User] (
    [UserID]   INT     Primary     NOT NULL,
    [Name]     VARCHAR (50) NULL,
    [Password] VARCHAR (50) NULL,

   
);
