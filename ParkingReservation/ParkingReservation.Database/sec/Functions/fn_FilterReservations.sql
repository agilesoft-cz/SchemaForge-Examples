CREATE FUNCTION [dbo].[fn_FilterReservations]
(
    @UserId INT,
    @IsService BIT,
    @CompanyId INT,
    @ReservationUserId INT,
    @IsDeleted BIT
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
    SELECT 1 AS [AccessAllowed]
    WHERE
        -- RESERVATION MANAGER: all not deleted reservations in assigned companies
        (
            @IsDeleted = 0
            AND EXISTS (
                SELECT 1
                FROM [sec].[RoleAssignment] ra
                WHERE ra.UserId = @UserId
                  AND ra.CompanyId = @CompanyId
                  AND ra.RoleId = 3 -- Reservation Manager
            )
        )
        -- CLIENT: only own not deleted reservations in assigned companies
        OR (
            @IsDeleted = 0
            AND @ReservationUserId = @UserId
            AND EXISTS (
                SELECT 1
                FROM [sec].[RoleAssignment] ra
                WHERE ra.UserId = @UserId
                  AND ra.CompanyId = @CompanyId
                  AND ra.RoleId = 2 -- Client
            )
        )
        -- SERVICE: only not deleted records
        OR (
            @IsService = 1
            AND @IsDeleted = 0
        );
GO
