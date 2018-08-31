/****** Object:  StoredProcedure [tallal78_8].[spUpdateUsercoverphoto]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spUpdateUsercoverphoto]
GO
/****** Object:  StoredProcedure [tallal78_8].[spUpdateUsercoverphoto]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spUpdateUsercoverphoto]
    @userId BIGINT ,
    @ImageUrl VARCHAR(MAX)
AS
    BEGIN

        UPDATE  [User]
        SET     [CoverPhoto] = @ImageUrl
        WHERE   id = @userId

		SELECT 1
    END

GO
