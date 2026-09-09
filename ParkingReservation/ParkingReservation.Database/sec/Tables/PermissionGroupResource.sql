CREATE TABLE [sec].[PermissionGroupResource]
(
    [Id]                INT IDENTITY(1, 1) NOT NULL,
    [PermissionGroupId] INT                NOT NULL,
    [DataResourceId]    INT                NOT NULL,

    [Author]            NVARCHAR(100)      NOT NULL,
    [Created]           DATETIME           NOT NULL DEFAULT GETDATE(),
    [Editor]            NVARCHAR(100)          NULL,
    [Modified]          DATETIME               NULL,
    [RowVersion]        ROWVERSION         NOT NULL,

    CONSTRAINT [PK_PermissionGroupResource_Id]
        PRIMARY KEY CLUSTERED ([Id] ASC),

    CONSTRAINT [UX_PermissionGroupResource_PermissionGroupId_DataResourceId]
        UNIQUE
        (
            [PermissionGroupId],
            [DataResourceId]
        ),

    CONSTRAINT [FK_PermissionGroupResource_PermissionGroupId]
        FOREIGN KEY ([PermissionGroupId])
        REFERENCES [sec].[PermissionGroup]([Id]),

    CONSTRAINT [FK_PermissionGroupResource_DataResourceId]
        FOREIGN KEY ([DataResourceId])
        REFERENCES [sec].[DataResource]([Id])
);
GO