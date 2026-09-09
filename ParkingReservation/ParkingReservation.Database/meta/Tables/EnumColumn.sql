CREATE TABLE [meta].[EnumColumn]
(
    [Id]               INT IDENTITY(1, 1) NOT NULL,
    [EnumDefinitionId] INT                NOT NULL,
    [SchemaName]       NVARCHAR(128)      NOT NULL,
    [TableName]        NVARCHAR(128)      NOT NULL,
    [ColumnName]       NVARCHAR(128)      NOT NULL,

    CONSTRAINT [PK_EnumColumn_Id]
        PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_EnumColumn_EnumDefinitionId]
        FOREIGN KEY ([EnumDefinitionId])
        REFERENCES [meta].[EnumDefinition]([Id]),

    CONSTRAINT [UX_EnumColumn_Column]
        UNIQUE
        (
            [SchemaName],
            [TableName],
            [ColumnName]
        )
);
GO