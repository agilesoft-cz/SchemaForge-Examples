CREATE SECURITY POLICY [dbo].[ReservationFilterPolicy]
ADD FILTER PREDICATE [dbo].[fn_FilterReservations](
    CONVERT(INT, SESSION_CONTEXT(N'UserId')),
    CONVERT(BIT, SESSION_CONTEXT(N'IsService')),
    [CompanyId],
    [UserId],
    [IsDeleted])
ON [dbo].[Reservation]
WITH (STATE = ON);
GO