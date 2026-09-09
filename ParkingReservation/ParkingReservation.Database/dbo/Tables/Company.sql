CREATE TABLE [dbo].[Company]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(200) NOT NULL,
    [Code] NVARCHAR(50) NOT NULL,

    [Author] NVARCHAR(255) NOT NULL,
    [Created] DATETIME2 NOT NULL,
    [Editor] NVARCHAR(255) NULL,
    [Modified] DATETIME2 NULL,
    [IsDeleted] BIT NOT NULL CONSTRAINT [DF_Company_IsDeleted] DEFAULT (0),

    CONSTRAINT [PK_Company]
        PRIMARY KEY ([Id]),

    CONSTRAINT [UQ_Company_Code]
        UNIQUE ([Code])
);