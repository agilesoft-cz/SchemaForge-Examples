CREATE TABLE [sec].[RoleAssignment]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [CustomerId] INT NOT NULL,
    [CompanyId] INT NOT NULL,
    [RoleId] INT NOT NULL,

    [Author] NVARCHAR(255) NOT NULL,
    [Created] DATETIME2 NOT NULL,
    [Editor] NVARCHAR(255) NULL,
    [Modified] DATETIME2 NULL,
    [IsDeleted] BIT NOT NULL,

    CONSTRAINT [PK_RoleAssignment]
        PRIMARY KEY ([Id]),

    CONSTRAINT [FK_RoleAssignment_Customer]
        FOREIGN KEY ([CustomerId])
        REFERENCES [dbo].[Customer] ([Id]),

    CONSTRAINT [FK_RoleAssignment_Company]
        FOREIGN KEY ([CompanyId])
        REFERENCES [dbo].[Company] ([Id]),

    CONSTRAINT [FK_RoleAssignment_Role]
        FOREIGN KEY ([RoleId])
        REFERENCES [sec].[Role] ([Id]),

    CONSTRAINT [UQ_RoleAssignment_Customer_Company_Role]
        UNIQUE ([CustomerId], [CompanyId], [RoleId])
);