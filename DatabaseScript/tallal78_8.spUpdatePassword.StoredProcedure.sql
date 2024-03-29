/****** Object:  StoredProcedure [tallal78_8].[spUpdatePassword]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spUpdatePassword]
GO
/****** Object:  StoredProcedure [tallal78_8].[spUpdatePassword]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spUpdatePassword]
    @OldPassword VARCHAR(MAX) ,
    @NewPassword VARCHAR(MAX) ,
    @UserId BIGINT
AS
    BEGIN
        DECLARE @returnval BIGINT = 0

        IF NOT EXISTS ( SELECT  *
                        FROM    [User]
                        WHERE   id = @UserId
                                AND [Password] = @OldPassword )
            SET @returnval = -1
        ELSE
            BEGIN
                UPDATE  [User]
                SET     [Password] = @NewPassword
                WHERE   Id = @UserId
        
                SET @returnval = 1
            END
        SELECT  @returnval
    END
GO
