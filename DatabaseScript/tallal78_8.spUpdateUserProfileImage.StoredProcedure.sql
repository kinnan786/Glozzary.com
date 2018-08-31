/****** Object:  StoredProcedure [tallal78_8].[spUpdateUserProfileImage]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spUpdateUserProfileImage]
GO
/****** Object:  StoredProcedure [tallal78_8].[spUpdateUserProfileImage]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [tallal78_8].[spUpdateUserProfileImage]
    @UserId BIGINT ,
    @ImageUrl VARCHAR(MAX)
AS
    BEGIN

        UPDATE  [USER]
        SET     ProfileImage = @ImageUrl
        WHERE   id = @UserId

        SELECT  1
    END

GO
