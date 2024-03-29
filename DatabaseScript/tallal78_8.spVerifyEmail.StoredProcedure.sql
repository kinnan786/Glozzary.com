/****** Object:  StoredProcedure [tallal78_8].[spVerifyEmail]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spVerifyEmail]
GO
/****** Object:  StoredProcedure [tallal78_8].[spVerifyEmail]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [tallal78_8].[spVerifyEmail]
    @VerificationCode VARCHAR(MAX) ,
    @Email VARCHAR(MAX)
AS
    BEGIN
        DECLARE @ReturnValue INT = -1

        IF NOT EXISTS ( SELECT  *
                        FROM    [User]
                        WHERE   Email = @Email
                                AND @VerificationCode = @VerificationCode )
            SET @ReturnValue = -1
        ELSE
            BEGIN

                UPDATE  [User]
                SET     [EmailVerified] = 1
                WHERE   Email = @Email 

                SELECT  @ReturnValue = ISNULL(id, 0)
                FROM    [User]
                WHERE   Email = @Email

            END

        SELECT  @ReturnValue
    END

GO
