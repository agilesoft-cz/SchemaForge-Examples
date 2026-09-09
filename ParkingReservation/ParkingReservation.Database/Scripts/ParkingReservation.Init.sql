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
    INSERT INTO [meta].[EnumDefinition]
    (
        [Name],
        [UnderlyingType],
        [Description]
    )
    VALUES
    (
        'DataAccess',
        'byte',
        'Defines the level of access to a resource.'
    );

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
    INSERT INTO [meta].[EnumValue]
    (
        [EnumDefinitionId],
        [Name],
        [Value],
        [SortOrder]
    )
    VALUES
    (
        @DataAccessId,
        'NoAccess',
        0,
        0
    );
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [meta].[EnumValue]
    WHERE [EnumDefinitionId] = @DataAccessId
      AND [Name] = 'Read'
)
BEGIN
    INSERT INTO [meta].[EnumValue]
    (
        [EnumDefinitionId],
        [Name],
        [Value],
        [SortOrder]
    )
    VALUES
    (
        @DataAccessId,
        'Read',
        1,
        10
    );
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [meta].[EnumValue]
    WHERE [EnumDefinitionId] = @DataAccessId
      AND [Name] = 'Write'
)
BEGIN
    INSERT INTO [meta].[EnumValue]
    (
        [EnumDefinitionId],
        [Name],
        [Value],
        [SortOrder]
    )
    VALUES
    (
        @DataAccessId,
        'Write',
        2,
        20
    );
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
    INSERT INTO [meta].[EnumColumn]
    (
        [EnumDefinitionId],
        [SchemaName],
        [TableName],
        [ColumnName]
    )
    VALUES
    (
        @DataAccessId,
        'sec',
        'RolePermissionAccess',
        'DataAccess'
    );
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
    INSERT INTO [sec].[ReferenceCode]
    (
        [ReferenceType],
        [Code],
        [Name],
        [Description],
        [SortOrder],
        [Author],
        [Created]
    )
    VALUES
    (
        'RESOURCE_TYPE',
        'ENTITY',
        'Entity',
        'Application entity or API resource.',
        10,
        'SchemaForge',
        GETDATE()
    );
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'RESOURCE_TYPE'
      AND [Code] = 'SCHEMA'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode]
    (
        [ReferenceType],
        [Code],
        [Name],
        [Description],
        [SortOrder],
        [Author],
        [Created]
    )
    VALUES
    (
        'RESOURCE_TYPE',
        'SCHEMA',
        'Schema',
        'Database schema resource.',
        20,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[ReferenceCode]
    (
        [ReferenceType],
        [Code],
        [Name],
        [Description],
        [SortOrder],
        [Author],
        [Created]
    )
    VALUES
    (
        'SYSTEM',
        'PARKING_RESERVATION',
        'Parking Reservation',
        'ParkingReservation application.',
        10,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[ReferenceCode]
    (
        [ReferenceType],
        [Code],
        [Name],
        [Description],
        [SortOrder],
        [Author],
        [Created]
    )
    VALUES
    (
        'GDPR_CATEGORY',
        'NONE',
        'None',
        'No specific GDPR category assigned.',
        0,
        'SchemaForge',
        GETDATE()
    );
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[ReferenceCode]
    WHERE [ReferenceType] = 'GDPR_CATEGORY'
      AND [Code] = 'PERSONAL'
)
BEGIN
    INSERT INTO [sec].[ReferenceCode]
    (
        [ReferenceType],
        [Code],
        [Name],
        [Description],
        [SortOrder],
        [Author],
        [Created]
    )
    VALUES
    (
        'GDPR_CATEGORY',
        'PERSONAL',
        'Personal Data',
        'Resource contains personal data.',
        10,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[ReferenceCode]
    (
        [ReferenceType],
        [Code],
        [Name],
        [Description],
        [SortOrder],
        [Author],
        [Created]
    )
    VALUES
    (
        'RETENTION_CLASS',
        'STANDARD',
        'Standard',
        'Standard application retention policy.',
        10,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[ReferenceCode]
    (
        [ReferenceType],
        [Code],
        [Name],
        [Description],
        [SortOrder],
        [Author],
        [Created]
    )
    VALUES
    (
        'SENSITIVITY',
        'INTERNAL',
        'Internal',
        'Internal application data.',
        10,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[ReferenceCode]
    (
        [ReferenceType],
        [Code],
        [Name],
        [Description],
        [SortOrder],
        [Author],
        [Created]
    )
    VALUES
    (
        'OWNER_TYPE',
        'APPLICATION',
        'Application',
        'Resource owned by the application.',
        10,
        'SchemaForge',
        GETDATE()
    );
END;

------------------------------------------------------------
-- Roles
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[Role]
    WHERE [Name] = 'Admin'
)
BEGIN
    INSERT INTO [sec].[Role]
    (
        [Name],
        [Author],
        [Created]
    )
    VALUES
    (
        'Admin',
        'SchemaForge',
        GETDATE()
    );
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[Role]
    WHERE [Name] = 'Client'
)
BEGIN
    INSERT INTO [sec].[Role]
    (
        [Name],
        [Author],
        [Created]
    )
    VALUES
    (
        'Client',
        'SchemaForge',
        GETDATE()
    );
END;

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
    INSERT INTO [sec].[PermissionGroup]
    (
        [Code],
        [Name],
        [Description],
        [Author],
        [Created]
    )
    VALUES
    (
        'ReferenceData',
        'Reference Data',
        'Common reference and customer data.',
        'SchemaForge',
        GETDATE()
    );
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[PermissionGroup]
    WHERE [Code] = 'Parking'
)
BEGIN
    INSERT INTO [sec].[PermissionGroup]
    (
        [Code],
        [Name],
        [Description],
        [Author],
        [Created]
    )
    VALUES
    (
        'Parking',
        'Parking',
        'Parking lots and parking spaces.',
        'SchemaForge',
        GETDATE()
    );
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[PermissionGroup]
    WHERE [Code] = 'Reservations'
)
BEGIN
    INSERT INTO [sec].[PermissionGroup]
    (
        [Code],
        [Name],
        [Description],
        [Author],
        [Created]
    )
    VALUES
    (
        'Reservations',
        'Reservations',
        'Reservations, reservation statuses and vehicles.',
        'SchemaForge',
        GETDATE()
    );
END;

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[PermissionGroup]
    WHERE [Code] = 'Security'
)
BEGIN
    INSERT INTO [sec].[PermissionGroup]
    (
        [Code],
        [Name],
        [Description],
        [Author],
        [Created]
    )
    VALUES
    (
        'Security',
        'Security',
        'Security administration.',
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[DataResource]
    (
        [ResourceName],
        [ResourceTypeId],
        [SystemId],
        [GdprCategoryId],
        [RetentionClassId],
        [SensitivityId],
        [OwnerTypeId],
        [ContainsPersonalData],
        [ContainsBankData],
        [AggregationOnly],
        [Author],
        [Created]
    )
    VALUES
    (
        'Company',
        @EntityResourceTypeId,
        @SystemId,
        @GdprNoneId,
        @RetentionStandardId,
        @SensitivityInternalId,
        @OwnerApplicationId,
        0,
        0,
        0,
        'SchemaForge',
        GETDATE()
    );
END;

------------------------------------------------------------
-- Customer
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'Customer'
)
BEGIN
    INSERT INTO [sec].[DataResource]
    (
        [ResourceName],
        [ResourceTypeId],
        [SystemId],
        [GdprCategoryId],
        [RetentionClassId],
        [SensitivityId],
        [OwnerTypeId],
        [ContainsPersonalData],
        [ContainsBankData],
        [AggregationOnly],
        [Author],
        [Created]
    )
    VALUES
    (
        'Customer',
        @EntityResourceTypeId,
        @SystemId,
        @GdprPersonalId,
        @RetentionStandardId,
        @SensitivityInternalId,
        @OwnerApplicationId,
        1,
        0,
        0,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[DataResource]
    (
        [ResourceName],
        [ResourceTypeId],
        [SystemId],
        [GdprCategoryId],
        [RetentionClassId],
        [SensitivityId],
        [OwnerTypeId],
        [ContainsPersonalData],
        [ContainsBankData],
        [AggregationOnly],
        [Author],
        [Created]
    )
    VALUES
    (
        'ParkingLot',
        @EntityResourceTypeId,
        @SystemId,
        @GdprNoneId,
        @RetentionStandardId,
        @SensitivityInternalId,
        @OwnerApplicationId,
        0,
        0,
        0,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[DataResource]
    (
        [ResourceName],
        [ResourceTypeId],
        [SystemId],
        [GdprCategoryId],
        [RetentionClassId],
        [SensitivityId],
        [OwnerTypeId],
        [ContainsPersonalData],
        [ContainsBankData],
        [AggregationOnly],
        [Author],
        [Created]
    )
    VALUES
    (
        'ParkingSpace',
        @EntityResourceTypeId,
        @SystemId,
        @GdprNoneId,
        @RetentionStandardId,
        @SensitivityInternalId,
        @OwnerApplicationId,
        0,
        0,
        0,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[DataResource]
    (
        [ResourceName],
        [ResourceTypeId],
        [SystemId],
        [GdprCategoryId],
        [RetentionClassId],
        [SensitivityId],
        [OwnerTypeId],
        [ContainsPersonalData],
        [ContainsBankData],
        [AggregationOnly],
        [Author],
        [Created]
    )
    VALUES
    (
        'Reservation',
        @EntityResourceTypeId,
        @SystemId,
        @GdprPersonalId,
        @RetentionStandardId,
        @SensitivityInternalId,
        @OwnerApplicationId,
        1,
        0,
        0,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[DataResource]
    (
        [ResourceName],
        [ResourceTypeId],
        [SystemId],
        [GdprCategoryId],
        [RetentionClassId],
        [SensitivityId],
        [OwnerTypeId],
        [ContainsPersonalData],
        [ContainsBankData],
        [AggregationOnly],
        [Author],
        [Created]
    )
    VALUES
    (
        'ReservationStatus',
        @EntityResourceTypeId,
        @SystemId,
        @GdprNoneId,
        @RetentionStandardId,
        @SensitivityInternalId,
        @OwnerApplicationId,
        0,
        0,
        0,
        'SchemaForge',
        GETDATE()
    );
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
    INSERT INTO [sec].[DataResource]
    (
        [ResourceName],
        [ResourceTypeId],
        [SystemId],
        [GdprCategoryId],
        [RetentionClassId],
        [SensitivityId],
        [OwnerTypeId],
        [ContainsPersonalData],
        [ContainsBankData],
        [AggregationOnly],
        [Author],
        [Created]
    )
    VALUES
    (
        'Vehicle',
        @EntityResourceTypeId,
        @SystemId,
        @GdprPersonalId,
        @RetentionStandardId,
        @SensitivityInternalId,
        @OwnerApplicationId,
        1,
        0,
        0,
        'SchemaForge',
        GETDATE()
    );
END;

------------------------------------------------------------
-- Security Schema
------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM [sec].[DataResource]
    WHERE [ResourceName] = 'Security'
)
BEGIN
    INSERT INTO [sec].[DataResource]
    (
        [ResourceName],
        [ResourceTypeId],
        [SystemId],
        [GdprCategoryId],
        [RetentionClassId],
        [SensitivityId],
        [OwnerTypeId],
        [ContainsPersonalData],
        [ContainsBankData],
        [AggregationOnly],
        [Author],
        [Created]
    )
    VALUES
    (
        'Security',
        @SchemaResourceTypeId,
        @SystemId,
        @GdprNoneId,
        @RetentionStandardId,
        @SensitivityInternalId,
        @OwnerApplicationId,
        0,
        0,
        0,
        'SchemaForge',
        GETDATE()
    );
END;

------------------------------------------------------------
-- Permission Group -> Data Resource
------------------------------------------------------------

------------------------------------------------------------
-- ReferenceData
------------------------------------------------------------

INSERT INTO [sec].[PermissionGroupResource]
(
    [PermissionGroupId],
    [DataResourceId],
    [Author],
    [Created]
)
SELECT
    pg.[Id],
    dr.[Id],
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
INNER JOIN [sec].[DataResource] dr
    ON dr.[ResourceName] IN
    (
        'Company',
        'Customer'
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

INSERT INTO [sec].[PermissionGroupResource]
(
    [PermissionGroupId],
    [DataResourceId],
    [Author],
    [Created]
)
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

INSERT INTO [sec].[PermissionGroupResource]
(
    [PermissionGroupId],
    [DataResourceId],
    [Author],
    [Created]
)
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

INSERT INTO [sec].[PermissionGroupResource]
(
    [PermissionGroupId],
    [DataResourceId],
    [Author],
    [Created]
)
SELECT
    pg.[Id],
    dr.[Id],
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
INNER JOIN [sec].[DataResource] dr
    ON dr.[ResourceName] = 'Security'
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

DECLARE @AdminRoleId INT =
(
    SELECT [Id]
    FROM [sec].[Role]
    WHERE [Name] = 'Admin'
);

DECLARE @ClientRoleId INT =
(
    SELECT [Id]
    FROM [sec].[Role]
    WHERE [Name] = 'Client'
);

------------------------------------------------------------
-- Admin - Write All
------------------------------------------------------------

UPDATE rpa
SET
    rpa.[DataAccess] = 2,
    rpa.[Editor] = 'SchemaForge',
    rpa.[Modified] = GETDATE()
FROM [sec].[RolePermissionAccess] rpa
INNER JOIN [sec].[PermissionGroup] pg
    ON pg.[Id] = rpa.[PermissionGroupId]
WHERE rpa.[RoleId] = @AdminRoleId
  AND pg.[IsDeleted] = 0
  AND rpa.[DataAccess] <> 2;

INSERT INTO [sec].[RolePermissionAccess]
(
    [RoleId],
    [PermissionGroupId],
    [DataAccess],
    [Author],
    [Created]
)
SELECT
    @AdminRoleId,
    pg.[Id],
    2,
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
WHERE pg.[IsDeleted] = 0
  AND NOT EXISTS
  (
      SELECT 1
      FROM [sec].[RolePermissionAccess] rpa
      WHERE rpa.[RoleId] = @AdminRoleId
        AND rpa.[PermissionGroupId] = pg.[Id]
  );

------------------------------------------------------------
-- Client - ReferenceData Read
------------------------------------------------------------

UPDATE rpa
SET
    rpa.[DataAccess] = 1,
    rpa.[Editor] = 'SchemaForge',
    rpa.[Modified] = GETDATE()
FROM [sec].[RolePermissionAccess] rpa
INNER JOIN [sec].[PermissionGroup] pg
    ON pg.[Id] = rpa.[PermissionGroupId]
WHERE rpa.[RoleId] = @ClientRoleId
  AND pg.[Code] = 'ReferenceData'
  AND rpa.[DataAccess] <> 1;

INSERT INTO [sec].[RolePermissionAccess]
(
    [RoleId],
    [PermissionGroupId],
    [DataAccess],
    [Author],
    [Created]
)
SELECT
    @ClientRoleId,
    pg.[Id],
    1,
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
WHERE pg.[Code] = 'ReferenceData'
  AND NOT EXISTS
  (
      SELECT 1
      FROM [sec].[RolePermissionAccess] rpa
      WHERE rpa.[RoleId] = @ClientRoleId
        AND rpa.[PermissionGroupId] = pg.[Id]
  );

------------------------------------------------------------
-- Client - Parking Read
------------------------------------------------------------

UPDATE rpa
SET
    rpa.[DataAccess] = 1,
    rpa.[Editor] = 'SchemaForge',
    rpa.[Modified] = GETDATE()
FROM [sec].[RolePermissionAccess] rpa
INNER JOIN [sec].[PermissionGroup] pg
    ON pg.[Id] = rpa.[PermissionGroupId]
WHERE rpa.[RoleId] = @ClientRoleId
  AND pg.[Code] = 'Parking'
  AND rpa.[DataAccess] <> 1;

INSERT INTO [sec].[RolePermissionAccess]
(
    [RoleId],
    [PermissionGroupId],
    [DataAccess],
    [Author],
    [Created]
)
SELECT
    @ClientRoleId,
    pg.[Id],
    1,
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
WHERE pg.[Code] = 'Parking'
  AND NOT EXISTS
  (
      SELECT 1
      FROM [sec].[RolePermissionAccess] rpa
      WHERE rpa.[RoleId] = @ClientRoleId
        AND rpa.[PermissionGroupId] = pg.[Id]
  );

------------------------------------------------------------
-- Client - Reservations Write
------------------------------------------------------------

UPDATE rpa
SET
    rpa.[DataAccess] = 2,
    rpa.[Editor] = 'SchemaForge',
    rpa.[Modified] = GETDATE()
FROM [sec].[RolePermissionAccess] rpa
INNER JOIN [sec].[PermissionGroup] pg
    ON pg.[Id] = rpa.[PermissionGroupId]
WHERE rpa.[RoleId] = @ClientRoleId
  AND pg.[Code] = 'Reservations'
  AND rpa.[DataAccess] <> 2;

INSERT INTO [sec].[RolePermissionAccess]
(
    [RoleId],
    [PermissionGroupId],
    [DataAccess],
    [Author],
    [Created]
)
SELECT
    @ClientRoleId,
    pg.[Id],
    2,
    'SchemaForge',
    GETDATE()
FROM [sec].[PermissionGroup] pg
WHERE pg.[Code] = 'Reservations'
  AND NOT EXISTS
  (
      SELECT 1
      FROM [sec].[RolePermissionAccess] rpa
      WHERE rpa.[RoleId] = @ClientRoleId
        AND rpa.[PermissionGroupId] = pg.[Id]
  );

GO