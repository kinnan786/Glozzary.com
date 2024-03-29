/****** Object:  StoredProcedure [tallal78_8].[spUpdateUser]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spUpdateUser]
GO
/****** Object:  StoredProcedure [tallal78_8].[spUpdateUser]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [tallal78_8].[spUpdateUser]
    @Email VARCHAR(MAX) ,
    @FirstName VARCHAR(MAX) ,
    @LastName VARCHAR(MAX) ,
    @UserID BIGINT
AS
    BEGIN
        DECLARE @return INT

        IF NOT EXISTS ( SELECT  *
                        FROM    [User]
                        WHERE   Id <> @UserID
                                AND Email = @Email )
            BEGIN

                UPDATE  [User]
                SET     [Email] = @Email ,
                        [FirstName] = @FirstName ,
                        [LastName] = @LastName
                WHERE   id = @UserID
                SET @return = 0

            END
        ELSE
            SET @return = -1
    END

GO
