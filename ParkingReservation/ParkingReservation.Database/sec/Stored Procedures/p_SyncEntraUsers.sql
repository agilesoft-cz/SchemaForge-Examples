CREATE PROCEDURE [sec].[p_SyncEntraUsers]
    @Users [sec].[EntraUserType] READONLY
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        MERGE [sec].[UserIdentity] WITH (HOLDLOCK) AS target
        USING @Users AS source
            ON target.[SourceId] COLLATE DATABASE_DEFAULT = source.[SourceId] COLLATE DATABASE_DEFAULT
           AND target.[SourceId] <> N''   -- ignore legacy rows with empty SourceId

        -- Existing user: update only if something actually changed
        WHEN MATCHED AND (
                target.[Name] COLLATE DATABASE_DEFAULT             <> source.[Name] COLLATE DATABASE_DEFAULT
             OR target.[Email] COLLATE DATABASE_DEFAULT            <> source.[Email] COLLATE DATABASE_DEFAULT
             OR target.[UserPrincipalName] COLLATE DATABASE_DEFAULT <> source.[UserPrincipalName] COLLATE DATABASE_DEFAULT
             OR target.[MobilePhone] COLLATE DATABASE_DEFAULT      <> source.[MobilePhone] COLLATE DATABASE_DEFAULT
             OR target.[JobTitle] COLLATE DATABASE_DEFAULT          <> source.[JobTitle] COLLATE DATABASE_DEFAULT
             OR target.[Department] COLLATE DATABASE_DEFAULT        <> source.[Department] COLLATE DATABASE_DEFAULT
             OR target.[PreferredLanguage] COLLATE DATABASE_DEFAULT <> source.[PreferredLanguage] COLLATE DATABASE_DEFAULT
             OR target.[AccountEnabled]    <> source.[AccountEnabled]
             OR target.[IsDeleted] = 1   -- user came back / was un-deleted in Entra
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

        -- New user: insert
        WHEN NOT MATCHED BY TARGET
            THEN INSERT (
                [SourceId], [Name], [Email], [UserPrincipalName],
                [MobilePhone], [JobTitle], [Department], [PreferredLanguage],
                [AccountEnabled], [IsDeleted], [Author], [Created])
            VALUES (
                source.[SourceId], source.[Name], source.[Email], source.[UserPrincipalName],
                source.[MobilePhone], source.[JobTitle], source.[Department], source.[PreferredLanguage],
                source.[AccountEnabled], 0, N'import', SYSUTCDATETIME())

        -- User no longer in Entra: soft-delete (skip rows already soft-deleted)
        WHEN NOT MATCHED BY SOURCE
              AND target.[IsDeleted] = 0
            THEN UPDATE SET
                [IsDeleted] = 1,
                [Editor]    = N'import',
                [Modified]  = SYSUTCDATETIME()
        ;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO