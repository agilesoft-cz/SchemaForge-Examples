CREATE FUNCTION [dbo].[fn_FilterVehicles]
(
    @UserId INT,
    @IsService BIT,
    @VehicleUserId INT,
    @IsDeleted BIT
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
    SELECT 1 AS [AccessAllowed]
    WHERE
        -- CLIENT: only own not deleted vehicles
        (
            @IsDeleted = 0
            AND @VehicleUserId = @UserId
            AND EXISTS (
                SELECT 1
                FROM [sec].[RoleAssignment] ra
                WHERE ra.UserId = @UserId
                  AND ra.RoleId = 2 -- Client
            )
        )
        -- SERVICE: only not deleted records
        OR (
            @IsService = 1
            AND @IsDeleted = 0
        );
GO
