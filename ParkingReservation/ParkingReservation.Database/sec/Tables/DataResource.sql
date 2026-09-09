CREATE TABLE [sec].[DataResource]
(
    [Id]                   INT IDENTITY(1, 1) NOT NULL,
    [ResourceName]         NVARCHAR(100)       NOT NULL,

    [ResourceTypeId]       INT                 NOT NULL,
    [SystemId]             INT                 NOT NULL,
    [GdprCategoryId]       INT                 NOT NULL,
    [RetentionClassId]     INT                 NOT NULL,
    [SensitivityId]        INT                 NOT NULL,
    [OwnerTypeId]          INT                 NOT NULL,

    [ContainsPersonalData] BIT                 NOT NULL DEFAULT(0),
    [ContainsBankData]     BIT                 NOT NULL DEFAULT(0),
    [AggregationOnly]      BIT                 NOT NULL DEFAULT(0),

    [Author]               NVARCHAR(100)       NOT NULL,
    [Created]              DATETIME            NOT NULL DEFAULT GETDATE(),
    [Editor]               NVARCHAR(100)           NULL,
    [Modified]             DATETIME                NULL,
    [IsDeleted]            BIT                 NOT NULL
        CONSTRAINT [DF_DataResource_IsDeleted] DEFAULT (0),
    [RowVersion]           ROWVERSION          NOT NULL,

    CONSTRAINT [PK_DataResource_Id]
        PRIMARY KEY CLUSTERED ([Id] ASC),

    CONSTRAINT [FK_DataResource_ResourceTypeId]
        FOREIGN KEY ([ResourceTypeId])
        REFERENCES [sec].[ReferenceCode]([Id]),

    CONSTRAINT [FK_DataResource_SystemId]
        FOREIGN KEY ([SystemId])
        REFERENCES [sec].[ReferenceCode]([Id]),

    CONSTRAINT [FK_DataResource_GdprCategoryId]
        FOREIGN KEY ([GdprCategoryId])
        REFERENCES [sec].[ReferenceCode]([Id]),

    CONSTRAINT [FK_DataResource_RetentionClassId]
        FOREIGN KEY ([RetentionClassId])
        REFERENCES [sec].[ReferenceCode]([Id]),

    CONSTRAINT [FK_DataResource_SensitivityId]
        FOREIGN KEY ([SensitivityId])
        REFERENCES [sec].[ReferenceCode]([Id]),

    CONSTRAINT [FK_DataResource_OwnerTypeId]
        FOREIGN KEY ([OwnerTypeId])
        REFERENCES [sec].[ReferenceCode]([Id]),

    CONSTRAINT [CK_DataResource_ResourceName_NotEmpty]
        CHECK (LTRIM(RTRIM([ResourceName])) <> '')
);
GO

CREATE UNIQUE INDEX [UX_DataResource_ResourceName]
    ON [sec].[DataResource]([ResourceName])
    WHERE [IsDeleted] = 0;
GO