CREATE TABLE [sec].[Role]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(500) NULL,

    [Author]        NVARCHAR(100)      NOT NULL,
    [Created]       DATETIME           NOT NULL DEFAULT GETDATE(),
    [Editor]        NVARCHAR(100)          NULL,
    [Modified]      DATETIME               NULL,
    [RowVersion]    ROWVERSION         NOT NULL,
    [IsDeleted] BIT NOT NULL
        CONSTRAINT [DF_Role_IsDeleted] DEFAULT (0),

    CONSTRAINT [PK_Role]
        PRIMARY KEY ([Id]),

    CONSTRAINT [UQ_Role_Name]
        UNIQUE ([Name])
);