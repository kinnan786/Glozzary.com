/****** Object:  StoredProcedure [tallal78_8].[spGetWebsiteTags]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetWebsiteTags]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetWebsiteTags]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetWebsiteTags] @Id BIGINT
AS
    BEGIN
        SELECT  COUNT(T.Id) AS [Count] ,
                T.Name ,
                T.Id ,
                w.Name AS WebsiteName
        FROM    Website w
                INNER JOIN Premalink P ON P.Website_Id = w.Id
                INNER JOIN PremalinkTags PT ON P.Id = PT.Premalink_Id
                INNER JOIN Tag T ON T.Id = PT.Tag_Id
        WHERE   w.Id = @Id
        GROUP BY T.Name ,
                T.Id ,
                w.Name
        ORDER BY COUNT(T.Id) DESC
    END
GO
