/****** Object:  StoredProcedure [tallal78_8].[spGetTagByWebsite]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetTagByWebsite]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetTagByWebsite]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spGetTagByWebsite] @WebsiteId BIGINT
AS
    SELECT  Tag_Id ,
            ( SELECT    RTRIM(LTRIM(Name))
              FROM      Tag
              WHERE     id = Tag_Id
            ) AS NAME ,
            COUNT(tag_Id) AS [COUNT]
    FROM    PremalinkTag_User ptu
            INNER JOIN PremalinkTags pt ON ptu.PremalinkTagId = pt.Id
            INNER JOIN Premalink P ON P.Id = pt.Premalink_Id
            INNER JOIN Website w ON w.id = P.Website_Id
    WHERE   w.Id = @WebsiteId
    GROUP BY Tag_Id

    
GO
