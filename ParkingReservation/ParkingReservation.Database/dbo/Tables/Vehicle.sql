CREATE TABLE [dbo].[Vehicle]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [CustomerId] INT NOT NULL,
    [RegistrationNumber] NVARCHAR(50) NOT NULL,
    [Make] NVARCHAR(100) NULL,
    [Model] NVARCHAR(100) NULL,

    [Author] NVARCHAR(255) NOT NULL,
    [Created] DATETIME2 NOT NULL,
    [Editor] NVARCHAR(255) NULL,
    [Modified] DATETIME2 NULL,
    [IsDeleted] BIT NOT NULL CONSTRAINT [DF_Vehicle_IsDeleted] DEFAULT (0),

    CONSTRAINT [PK_Vehicle]
        PRIMARY KEY ([Id]),

    CONSTRAINT [FK_Vehicle_Customer]
        FOREIGN KEY ([CustomerId])
        REFERENCES [dbo].[Customer] ([Id]),

    CONSTRAINT [UQ_Vehicle_RegistrationNumber]
        UNIQUE ([RegistrationNumber])
);