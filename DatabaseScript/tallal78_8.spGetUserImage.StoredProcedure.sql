/****** Object:  StoredProcedure [tallal78_8].[spGetUserImage]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetUserImage]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetUserImage]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetUserImage] @UserId BIGINT
AS
    BEGIN

        SELECT  ISNULL([ProfileImage], '') AS ProfileImage ,
                ISNULL([CoverPhoto], '') AS CoverPhoto
        FROM    [User]
        WHERE   id = @UserId

    END
GO
