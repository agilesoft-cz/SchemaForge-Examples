CREATE PROCEDURE [sec].[p_SyncEntraUsers]
    @TenantId UNIQUEIDENTIFIER,
    @Users [sec].[EntraUserType] READONLY
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        MERGE [sec].[UserIdentity] WITH (HOLDLOCK) AS target
        USING @Users AS source
            ON target.[TenantId] = @TenantId
           AND target.[ObjectId] = source.[ObjectId]

        WHEN MATCHED AND (
                target.[Name] COLLATE DATABASE_DEFAULT <> source.[Name] COLLATE DATABASE_DEFAULT
             OR target.[Email] COLLATE DATABASE_DEFAULT <> source.[Email] COLLATE DATABASE_DEFAULT
             OR target.[UserPrincipalName] COLLATE DATABASE_DEFAULT <> source.[UserPrincipalName] COLLATE DATABASE_DEFAULT
             OR target.[MobilePhone] COLLATE DATABASE_DEFAULT <> source.[MobilePhone] COLLATE DATABASE_DEFAULT
             OR target.[JobTitle] COLLATE DATABASE_DEFAULT <> source.[JobTitle] COLLATE DATABASE_DEFAULT
             OR target.[Department] COLLATE DATABASE_DEFAULT <> source.[Department] COLLATE DATABASE_DEFAULT
             OR target.[PreferredLanguage] COLLATE DATABASE_DEFAULT <> source.[PreferredLanguage] COLLATE DATABASE_DEFAULT
             OR target.[AccountEnabled] <> source.[AccountEnabled]
             OR target.[IsDeleted] = 1
            )
            THEN UPDATE SET
                [Name]              = source.[Name],
                [Email]             = source.[Email],
                [UserPrincipalName] = source.[UserPrincipalName],
                [MobilePhone]       = source.[MobilePhone],
                [JobTitle]          = source.[JobTitle],
                [Department]        = source.[Department],
                [PreferredLanguage] = source.[PreferredLanguage],
                [AccountEnabled]    = source.[AccountEnabled],
                [IsDeleted]         = 0,
                [Editor]            = N'import',
                [Modified]          = SYSUTCDATETIME()

        WHEN NOT MATCHED BY TARGET
            THEN INSERT (
                [TenantId],
                [ObjectId],
                [Name],
                [Email],
                [UserPrincipalName],
                [MobilePhone],
                [JobTitle],
                [Department],
                [PreferredLanguage],
                [AccountEnabled],
                [IsDeleted],
                [Author],
                [Created])
            VALUES (
                @TenantId,
                source.[ObjectId],
                source.[Name],
                source.[Email],
                source.[UserPrincipalName],
                source.[MobilePhone],
                source.[JobTitle],
                source.[Department],
                source.[PreferredLanguage],
                source.[AccountEnabled],
                0,
                N'import',
                SYSUTCDATETIME())

        WHEN NOT MATCHED BY SOURCE
             AND target.[TenantId] = @TenantId
             AND target.[IsDeleted] = 0
            THEN UPDATE SET
                [IsDeleted] = 1,
                [Editor]     = N'import',
                [Modified]   = SYSUTCDATETIME()
        ;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO