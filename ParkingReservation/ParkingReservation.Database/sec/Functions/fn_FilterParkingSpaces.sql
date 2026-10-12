CREATE FUNCTION [dbo].[fn_FilterParkingSpaces]
(
    @UserId INT,
    @IsService BIT,
    @ParkingLotId INT,
    @IsDeleted BIT
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
    SELECT 1 AS [AccessAllowed]
    WHERE
        -- ADMIN: all records including deleted
        EXISTS (
            SELECT 1
            FROM [sec].[RoleAssignment] ra
            WHERE ra.UserId = @UserId
              AND ra.RoleId = 1 -- Admin
        )
        -- CLIENT / RESERVATION MANAGER: assigned companies, not deleted
        OR (
            @IsDeleted = 0
            AND EXISTS (
                SELECT 1
                FROM [dbo].[ParkingLot] pl
                INNER JOIN [sec].[RoleAssignment] ra
                    ON ra.CompanyId = pl.CompanyId
                WHERE pl.Id = @ParkingLotId
                  AND pl.IsDeleted = 0
                  AND ra.UserId = @UserId
                  AND ra.RoleId IN (2, 3) -- Client, Reservation Manager
            )
        )
        -- SERVICE: only not deleted records
        OR (
            @IsService = 1
            AND @IsDeleted = 0
        );
GO
