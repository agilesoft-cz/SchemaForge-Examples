CREATE TABLE [meta].[EnumValue]
(
    [Id]               INT IDENTITY(1, 1) NOT NULL,
    [EnumDefinitionId] INT                NOT NULL,
    [Name]             NVARCHAR(100)      NOT NULL,
    [Value]            INT                NOT NULL,
    [Description]      NVARCHAR(500)          NULL,
    [SortOrder]        INT                NOT NULL DEFAULT 0,

    CONSTRAINT [PK_EnumValue_Id]
        PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_EnumValue_EnumDefinitionId]
        FOREIGN KEY ([EnumDefinitionId])
        REFERENCES [meta].[EnumDefinition]([Id]),

    CONSTRAINT [UX_EnumValue_EnumDefinition_Name]
        UNIQUE ([EnumDefinitionId], [Name]),

    CONSTRAINT [UX_EnumValue_EnumDefinition_Value]
        UNIQUE ([EnumDefinitionId], [Value])
);
GO