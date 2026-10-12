SET NOCOUNT ON;

------------------------------------------------------------
-- Enum: DataAccess
------------------------------------------------------------

DECLARE @DataAccessId INT;

SELECT @DataAccessId = [Id]
FROM [meta].[EnumDefinition]
WHERE [Name] = 'DataAccess';

IF @DataAccessId IS NULL
BEGIN
    INSERT INTO [meta].[EnumDefinition] ([Name], [UnderlyingType], [Description])
    VALUES ('DataAccess', 'byte', 'Defines the level of access to a resource.');

    SET @DataAccessId = SCOPE_IDENTITY();
END;

------------------------------------------------------------
-- DataAccess values
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [meta].[EnumValue]
    WHERE [EnumDefinitionId] = @DataAccessId
      AND [Name] = 'NoAccess'
)
BEGIN
    INSERT INTO [meta].[EnumValue] ([EnumDefinitionId], [Name], [Value], [SortOrder])
    VALUES (@DataAccessId, 'NoAccess', 0, 0);
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [meta].[EnumValue]
    WHERE [EnumDefinitionId] = @DataAccessId
      AND [Name] = 'Read'
)
BEGIN
    INSERT INTO [meta].[EnumValue] ([EnumDefinitionId], [Name], [Value], [SortOrder])
    VALUES (@DataAccessId, 'Read', 1, 10);
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [meta].[EnumValue]
    WHERE [EnumDefinitionId] = @DataAccessId
      AND [Name] = 'Write'
)
BEGIN
    INSERT INTO [meta].[EnumValue] ([EnumDefinitionId], [Name], [Value], [SortOrder])
    VALUES (@DataAccessId, 'Write', 2, 20);
END;

------------------------------------------------------------
-- Map RolePermissionAccess.DataAccess
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [meta].[EnumColumn]
    WHERE [SchemaName] = 'sec'
      AND [TableName] = 'RolePermissionAccess'
      AND [ColumnName] = 'DataAccess'
)
BEGIN
    INSERT INTO [meta].[EnumColumn] ([EnumDefinitionId], [SchemaName], [TableName], [ColumnName])
    VALUES (@DataAccessId, 'sec', 'RolePermissionAccess', 'DataAccess');
END;

------------------------------------------------------------
-- Reference Codes
------------------------------------------------------------

------------------------------------------------------------
-- RESOURCE_TYPE
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'RESOURCE_TYPE'
      AND [Code] = 'ENTITY'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode] ([ReferenceType], [Code], [Name], [Description], [SortOrder], [Author], [Created])
    VALUES ('RESOURCE_TYPE', 'ENTITY', 'Entity', 'Application entity or API resource.', 10, 'SchemaForge', GETDATE());
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'RESOURCE_TYPE'
      AND [Code] = 'SCHEMA'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode] ([ReferenceType], [Code], [Name], [Description], [SortOrder], [Author], [Created])
    VALUES ('RESOURCE_TYPE', 'SCHEMA', 'Schema', 'Database schema resource.', 20, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- SYSTEM
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'SYSTEM'
      AND [Code] = 'PARKING_RESERVATION'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode] ([ReferenceType], [Code], [Name], [Description], [SortOrder], [Author], [Created])
    VALUES ('SYSTEM', 'PARKING_RESERVATION', 'Parking Reservation', 'ParkingReservation application.', 10, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- GDPR_CATEGORY
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'GDPR_CATEGORY'
      AND [Code] = 'NONE'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode] ([ReferenceType], [Code], [Name], [Description], [SortOrder], [Author], [Created])
    VALUES ('GDPR_CATEGORY', 'NONE', 'None', 'No specific GDPR category assigned.', 0, 'SchemaForge', GETDATE());
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'GDPR_CATEGORY'
      AND [Code] = 'PERSONAL'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode] ([ReferenceType], [Code], [Name], [Description], [SortOrder], [Author], [Created])
    VALUES ('GDPR_CATEGORY', 'PERSONAL', 'Personal Data', 'Resource contains personal data.', 10, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- RETENTION_CLASS
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'RETENTION_CLASS'
      AND [Code] = 'STANDARD'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode] ([ReferenceType], [Code], [Name], [Description], [SortOrder], [Author], [Created])
    VALUES ('RETENTION_CLASS', 'STANDARD', 'Standard', 'Standard application retention policy.', 10, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- SENSITIVITY
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'SENSITIVITY'
      AND [Code] = 'INTERNAL'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode] ([ReferenceType], [Code], [Name], [Description], [SortOrder], [Author], [Created])
    VALUES ('SENSITIVITY', 'INTERNAL', 'Internal', 'Internal application data.', 10, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- OWNER_TYPE
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'OWNER_TYPE'
      AND [Code] = 'APPLICATION'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode] ([ReferenceType], [Code], [Name], [Description], [SortOrder], [Author], [Created])
    VALUES ('OWNER_TYPE', 'APPLICATION', 'Application', 'Resource owned by the application.', 10, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- Roles
------------------------------------------------------------

SET IDENTITY_INSERT [sec].[Role] ON;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[Role]
    WHERE [Id] = 1
)
BEGIN
    INSERT INTO [sec].[Role] ([Id], [Name], [Author], [Created])
    VALUES (1, 'Admin', 'SchemaForge', GETDATE());
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[Role]
    WHERE [Id] = 2
)
BEGIN
    INSERT INTO [sec].[Role] ([Id], [Name], [Author], [Created])
    VALUES (2, 'Client', 'SchemaForge', GETDATE());
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[Role]
    WHERE [Id] = 3
)
BEGIN
    INSERT INTO [sec].[Role] ([Id], [Name], [Author], [Created])
    VALUES (3, 'Reservation Manager', 'SchemaForge', GETDATE());
END;

SET IDENTITY_INSERT [sec].[Role] OFF;


------------------------------------------------------------
-- Permission Groups
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[PermissionGroup]
    WHERE [Code] = 'ReferenceData'
)
BEGIN
    INSERT INTO [sec].[PermissionGroup] ([Code], [Name], [Description], [Author], [Created])
    VALUES ('ReferenceData', 'Reference Data', 'Common reference and user data.', 'SchemaForge', GETDATE());
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[PermissionGroup]
    WHERE [Code] = 'Parking'
)
BEGIN
    INSERT INTO [sec].[PermissionGroup] ([Code], [Name], [Description], [Author], [Created])
    VALUES ('Parking', 'Parking', 'Parking lots and parking spaces.', 'SchemaForge', GETDATE());
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[PermissionGroup]
    WHERE [Code] = 'Reservations'
)
BEGIN
    INSERT INTO [sec].[PermissionGroup] ([Code], [Name], [Description], [Author], [Created])
    VALUES ('Reservations', 'Reservations', 'Reservations, reservation statuses and vehicles.', 'SchemaForge', GETDATE());
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[PermissionGroup]
    WHERE [Code] = 'Security'
)
BEGIN
    INSERT INTO [sec].[PermissionGroup] ([Code], [Name], [Description], [Author], [Created])
    VALUES ('Security', 'Security', 'Security administration.', 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- Resolve Reference Code IDs
------------------------------------------------------------

DECLARE @EntityResourceTypeId INT =
(
    SELECT [Id]
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'RESOURCE_TYPE'
      AND [Code] = 'ENTITY'
);

DECLARE @SchemaResourceTypeId INT =
(
    SELECT [Id]
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'RESOURCE_TYPE'
      AND [Code] = 'SCHEMA'
);

DECLARE @SystemId INT =
(
    SELECT [Id]
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'SYSTEM'
      AND [Code] = 'PARKING_RESERVATION'
);

DECLARE @GdprNoneId INT =
(
    SELECT [Id]
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'GDPR_CATEGORY'
      AND [Code] = 'NONE'
);

DECLARE @GdprPersonalId INT =
(
    SELECT [Id]
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'GDPR_CATEGORY'
      AND [Code] = 'PERSONAL'
);

DECLARE @RetentionStandardId INT =
(
    SELECT [Id]
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'RETENTION_CLASS'
      AND [Code] = 'STANDARD'
);

DECLARE @SensitivityInternalId INT =
(
    SELECT [Id]
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'SENSITIVITY'
      AND [Code] = 'INTERNAL'
);

DECLARE @OwnerApplicationId INT =
(
    SELECT [Id]
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'OWNER_TYPE'
      AND [Code] = 'APPLICATION'
);

------------------------------------------------------------
-- Data Resources
------------------------------------------------------------

------------------------------------------------------------
-- Company
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'Company'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('Company', @EntityResourceTypeId, @SystemId, @GdprNoneId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 0, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- ParkingLot
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'ParkingLot'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('ParkingLot', @EntityResourceTypeId, @SystemId, @GdprNoneId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 0, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- ParkingSpace
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'ParkingSpace'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('ParkingSpace', @EntityResourceTypeId, @SystemId, @GdprNoneId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 0, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- Reservation
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'Reservation'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('Reservation', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- ReservationStatus
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'ReservationStatus'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('ReservationStatus', @EntityResourceTypeId, @SystemId, @GdprNoneId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 0, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- Vehicle
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'Vehicle'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('Vehicle', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- DataResource
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'DataResource'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('DataResource', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- PermissionGroup
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'PermissionGroup'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('PermissionGroup', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- PermissionGroupResource
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'PermissionGroupResource'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('PermissionGroupResource', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- ReferenceCode
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'ReferenceCode'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('ReferenceCode', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- Role
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'Role'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('Role', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- RoleAssignment
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'RoleAssignment'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('RoleAssignment', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- RolePermissionAccess
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'RolePermissionAccess'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('RolePermissionAccess', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- User
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'User'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('User', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- UserIdentity
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'UserIdentity'
)
BEGIN
    INSERT INTO [sec].[DataResource] ([ResourceName], [ResourceTypeId], [SystemId], [GdprCategoryId], [RetentionClassId], [SensitivityId], [OwnerTypeId], [ContainsPersonalData], [ContainsBankData], [AggregationOnly], [Author], [Created])
    VALUES ('UserIdentity', @EntityResourceTypeId, @SystemId, @GdprPersonalId, @RetentionStandardId, @SensitivityInternalId, @OwnerApplicationId, 1, 0, 0, 'SchemaForge', GETDATE());
END;

------------------------------------------------------------
-- Permission Group -> Data Resource
------------------------------------------------------------

------------------------------------------------------------
-- ReferenceData
------------------------------------------------------------

INSERT INTO [sec].[PermissionGroupResource] ([PermissionGroupId], [DataResourceId], [Author], [Created])
SELECT
    pg.[Id],
    dr.[Id],
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
INNER JOIN [sec].[DataResource] dr
    ON dr.[ResourceName] IN
    (
        'Company'
    )
WHERE pg.[Code] = 'ReferenceData'
  AND NOT EXISTS
  (
      SELECT 1
      FROM [sec].[PermissionGroupResource] pgr
      WHERE pgr.[PermissionGroupId] = pg.[Id]
        AND pgr.[DataResourceId] = dr.[Id]
  );

------------------------------------------------------------
-- Parking
------------------------------------------------------------

INSERT INTO [sec].[PermissionGroupResource] ([PermissionGroupId], [DataResourceId], [Author], [Created])
SELECT
    pg.[Id],
    dr.[Id],
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
INNER JOIN [sec].[DataResource] dr
    ON dr.[ResourceName] IN
    (
        'ParkingLot',
        'ParkingSpace'
    )
WHERE pg.[Code] = 'Parking'
  AND NOT EXISTS
  (
      SELECT 1
      FROM [sec].[PermissionGroupResource] pgr
      WHERE pgr.[PermissionGroupId] = pg.[Id]
        AND pgr.[DataResourceId] = dr.[Id]
  );

------------------------------------------------------------
-- Reservations
------------------------------------------------------------

INSERT INTO [sec].[PermissionGroupResource] ([PermissionGroupId], [DataResourceId], [Author], [Created])
SELECT
    pg.[Id],
    dr.[Id],
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
INNER JOIN [sec].[DataResource] dr
    ON dr.[ResourceName] IN
    (
        'Reservation',
        'ReservationStatus',
        'Vehicle'
    )
WHERE pg.[Code] = 'Reservations'
  AND NOT EXISTS
  (
      SELECT 1
      FROM [sec].[PermissionGroupResource] pgr
      WHERE pgr.[PermissionGroupId] = pg.[Id]
        AND pgr.[DataResourceId] = dr.[Id]
  );

------------------------------------------------------------
-- Security
------------------------------------------------------------

INSERT INTO [sec].[PermissionGroupResource] ([PermissionGroupId], [DataResourceId], [Author], [Created])
SELECT
    pg.[Id],
    dr.[Id],
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
INNER JOIN [sec].[DataResource] dr
    ON dr.[ResourceName] IN
    (
        'DataResource',
        'PermissionGroup',
        'PermissionGroupResource',
        'ReferenceCode',
        'Role',
        'RoleAssignment',
        'RolePermissionAccess',
        'User',
        'UserIdentity'
    )
WHERE pg.[Code] = 'Security'
  AND NOT EXISTS
  (
      SELECT 1
      FROM [sec].[PermissionGroupResource] pgr
      WHERE pgr.[PermissionGroupId] = pg.[Id]
        AND pgr.[DataResourceId] = dr.[Id]
  );

------------------------------------------------------------
-- Role Permission Access
------------------------------------------------------------

-- DataAccess:
-- 1 = Read
-- 2 = Write

DECLARE @RolePermissions TABLE
(
    [RoleId] INT,
    [PermissionGroupCode] NVARCHAR(100),
    [DataAccess] TINYINT
);

INSERT INTO @RolePermissions ([RoleId], [PermissionGroupCode], [DataAccess])
VALUES
    (1, 'Security',      2),
    (1, 'Parking',       2),
    (1, 'ReferenceData', 2),

    (2, 'Parking',       1),
    (2, 'ReferenceData', 1),
    (2, 'Reservations',  2),

    (3, 'Parking',       1),
    (3, 'ReferenceData', 1),
    (3, 'Reservations',  2);

------------------------------------------------------------
-- Update Existing Permissions
------------------------------------------------------------

IF EXISTS
(
    SELECT 1
    FROM [sec].[RolePermissionAccess] rpa
    INNER JOIN [sec].[PermissionGroup] pg
        ON pg.[Id] = rpa.[PermissionGroupId]
    INNER JOIN @RolePermissions rp
        ON rp.[RoleId] = rpa.[RoleId]
        AND rp.[PermissionGroupCode] = pg.[Code]
    WHERE rpa.[DataAccess] <> rp.[DataAccess]
)
BEGIN
    UPDATE rpa
    SET
        rpa.[DataAccess] = rp.[DataAccess],
        rpa.[Editor] = 'SchemaForge',
        rpa.[Modified] = GETDATE()
    FROM [sec].[RolePermissionAccess] rpa
    INNER JOIN [sec].[PermissionGroup] pg
        ON pg.[Id] = rpa.[PermissionGroupId]
    INNER JOIN @RolePermissions rp
        ON rp.[RoleId] = rpa.[RoleId]
        AND rp.[PermissionGroupCode] = pg.[Code]
    WHERE rpa.[DataAccess] <> rp.[DataAccess];
END;

------------------------------------------------------------
-- Insert Missing Permissions
------------------------------------------------------------

IF EXISTS
(
    SELECT 1
    FROM @RolePermissions rp
    INNER JOIN [sec].[PermissionGroup] pg
        ON pg.[Code] = rp.[PermissionGroupCode]
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM [sec].[RolePermissionAccess] rpa
        WHERE rpa.[RoleId] = rp.[RoleId]
          AND rpa.[PermissionGroupId] = pg.[Id]
    )
)
BEGIN
    INSERT INTO [sec].[RolePermissionAccess] ([RoleId], [PermissionGroupId], [DataAccess], [Author], [Created])
    SELECT
        rp.[RoleId],
        pg.[Id],
        rp.[DataAccess],
        'SchemaForge',
        GETDATE()
    FROM @RolePermissions rp
    INNER JOIN [sec].[PermissionGroup] pg
        ON pg.[Code] = rp.[PermissionGroupCode]
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM [sec].[RolePermissionAccess] rpa
        WHERE rpa.[RoleId] = rp.[RoleId]
          AND rpa.[PermissionGroupId] = pg.[Id]
    );
END;