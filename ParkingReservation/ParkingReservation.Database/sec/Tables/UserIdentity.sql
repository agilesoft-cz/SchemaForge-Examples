CREATE TABLE [sec].[UserIdentity]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [CustomerId] INT NOT NULL,
    [TenantId] UNIQUEIDENTIFIER NOT NULL,
    [ObjectId] UNIQUEIDENTIFIER NOT NULL,
    [Provider] NVARCHAR(50) NOT NULL
        CONSTRAINT [DF_UserIdentity_Provider] DEFAULT (N'Entra'),
    [IsActive] BIT NOT NULL
        CONSTRAINT [DF_UserIdentity_IsActive] DEFAULT (1),

    [Author] NVARCHAR(255) NOT NULL,
    [Created] DATETIME2 NOT NULL,
    [Editor] NVARCHAR(255) NULL,
    [Modified] DATETIME2 NULL,
    [IsDeleted] BIT NOT NULL
        CONSTRAINT [DF_UserIdentity_IsDeleted] DEFAULT (0),

    CONSTRAINT [PK_UserIdentity]
        PRIMARY KEY ([Id]),

    CONSTRAINT [FK_UserIdentity_Customer]
        FOREIGN KEY ([CustomerId])
        REFERENCES [dbo].[Customer] ([Id]),

    CONSTRAINT [UQ_UserIdentity_Tenant_Object]
        UNIQUE ([TenantId], [ObjectId])
);