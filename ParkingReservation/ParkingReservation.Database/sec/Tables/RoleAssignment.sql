CREATE TABLE [sec].[RoleAssignment]
(
    [Id]            INT IDENTITY(1,1)   NOT NULL,
    [UserId]        INT                 NOT NULL,
    [CompanyId]     INT                     NULL,
    [RoleId]        INT                 NOT NULL,

    [Author]        NVARCHAR(255)       NOT NULL,
    [Created]       DATETIME2           NOT NULL,
    [Editor]        NVARCHAR(255)           NULL,
    [Modified]      DATETIME2               NULL,
    [IsDeleted]     BIT                 NOT NULL,

    CONSTRAINT [PK_RoleAssignment]
        PRIMARY KEY ([Id]),

    CONSTRAINT [FK_RoleAssignment_User]
        FOREIGN KEY ([UserId])
        REFERENCES [sec].[User] ([Id]),

    CONSTRAINT [FK_RoleAssignment_Company]
        FOREIGN KEY ([CompanyId])
        REFERENCES [dbo].[Company] ([Id]),

    CONSTRAINT [FK_RoleAssignment_Role]
        FOREIGN KEY ([RoleId])
        REFERENCES [sec].[Role] ([Id]),

    CONSTRAINT [UQ_RoleAssignment_User_Company_Role]
        UNIQUE ([UserId], [CompanyId], [RoleId])
);