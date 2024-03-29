/****** Object:  StoredProcedure [tallal78_8].[spGetUserPassword]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetUserPassword]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetUserPassword]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [tallal78_8].[spGetUserPassword] @Email VARCHAR(MAX)
AS
    BEGIN
        DECLARE @returnval VARCHAR(MAX) = ''

        IF EXISTS ( SELECT  *
                    FROM    [USER]
                    WHERE   Email = @Email )
            BEGIN
                SELECT  @returnval = [Password]
                FROM    [User]
                WHERE   Email = @Email 
            END
        ELSE
            BEGIN
                SET @returnval = -1
            END
        SELECT  @returnval
    END

GO
