CREATE TABLE [sec].[ReferenceCode]
(
    [Id]            INT IDENTITY(1, 1) NOT NULL,
    [ReferenceType] NVARCHAR(80)       NOT NULL,
    [Code]          NVARCHAR(80)       NOT NULL,
    [Name]          NVARCHAR(120)      NOT NULL,
    [Description]   NVARCHAR(500)          NULL,
    [SortOrder]     INT                NOT NULL DEFAULT(0),
    [IsActive]      BIT                NOT NULL DEFAULT(1),

    [Author]        NVARCHAR(100)      NOT NULL,
    [Created]       DATETIME           NOT NULL DEFAULT GETDATE(),
    [Editor]        NVARCHAR(100)          NULL,
    [Modified]      DATETIME               NULL,
    [RowVersion]    ROWVERSION         NOT NULL,

    CONSTRAINT [PK_ReferenceCode_Id]
        PRIMARY KEY CLUSTERED ([Id] ASC),

    CONSTRAINT [CK_ReferenceCode_ReferenceType_NotEmpty]
        CHECK (LTRIM(RTRIM([ReferenceType])) <> ''),

    CONSTRAINT [CK_ReferenceCode_Code_NotEmpty]
        CHECK (LTRIM(RTRIM([Code])) <> ''),

    CONSTRAINT [CK_ReferenceCode_Name_NotEmpty]
        CHECK (LTRIM(RTRIM([Name])) <> '')
);
GO

CREATE UNIQUE INDEX [UX_ReferenceCode_ReferenceType_Code]
    ON [sec].[ReferenceCode]
    (
        [ReferenceType],
        [Code]
    );
GO