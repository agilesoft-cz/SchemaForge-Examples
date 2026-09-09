CREATE TABLE [sec].[PermissionGroup]
(
    [Id]          INT IDENTITY(1, 1) NOT NULL,
    [Code]        NVARCHAR(100)       NOT NULL,
    [Name]        NVARCHAR(150)       NOT NULL,
    [Description] NVARCHAR(500)           NULL,

    [Author]      NVARCHAR(100)       NOT NULL,
    [Created]     DATETIME            NOT NULL DEFAULT GETDATE(),
    [Editor]      NVARCHAR(100)           NULL,
    [Modified]    DATETIME                NULL,
    [IsDeleted]   BIT                 NOT NULL
        CONSTRAINT [DF_PermissionGroup_IsDeleted] DEFAULT (0),
    [RowVersion]  ROWVERSION          NOT NULL,

    CONSTRAINT [PK_PermissionGroup_Id]
        PRIMARY KEY CLUSTERED ([Id] ASC),

    CONSTRAINT [CK_PermissionGroup_Code_NotEmpty]
        CHECK (LTRIM(RTRIM([Code])) <> ''),

    CONSTRAINT [CK_PermissionGroup_Name_NotEmpty]
        CHECK (LTRIM(RTRIM([Name])) <> '')
);
GO

CREATE UNIQUE INDEX [UX_PermissionGroup_Code]
    ON [sec].[PermissionGroup]([Code])
    WHERE [IsDeleted] = 0;
GO