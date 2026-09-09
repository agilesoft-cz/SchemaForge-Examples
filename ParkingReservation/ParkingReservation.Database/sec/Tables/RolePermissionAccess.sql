CREATE TABLE [sec].[RolePermissionAccess]
(
    [Id]                INT IDENTITY(1, 1) NOT NULL,
    [RoleId]            INT                 NOT NULL,
    [PermissionGroupId] INT                 NOT NULL,
    [DataAccess]        TINYINT             NOT NULL,

    [Author]            NVARCHAR(100)       NOT NULL,
    [Created]           DATETIME            NOT NULL DEFAULT GETDATE(),
    [Editor]            NVARCHAR(100)           NULL,
    [Modified]          DATETIME                NULL,
    [RowVersion]        ROWVERSION          NOT NULL,

    CONSTRAINT [PK_RolePermissionAccess_Id]
        PRIMARY KEY CLUSTERED ([Id] ASC),

    CONSTRAINT [FK_RolePermissionAccess_RoleId]
        FOREIGN KEY ([RoleId])
        REFERENCES [sec].[Role]([Id]),

    CONSTRAINT [FK_RolePermissionAccess_PermissionGroupId]
        FOREIGN KEY ([PermissionGroupId])
        REFERENCES [sec].[PermissionGroup]([Id]),

    CONSTRAINT [CK_RolePermissionAccess_DataAccess]
        CHECK ([DataAccess] IN (0, 1, 2)),

    CONSTRAINT [UX_RolePermissionAccess_RoleId_PermissionGroupId]
        UNIQUE
        (
            [RoleId],
            [PermissionGroupId]
        )
);
GO