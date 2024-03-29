/****** Object:  StoredProcedure [tallal78_8].[spGetWebsiteFeed]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetWebsiteFeed]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetWebsiteFeed]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spGetWebsiteFeed]
    @WebsiteID BIGINT ,
    @TagId VARCHAR(MAX) = '' ,
    @EmoId VARCHAR(MAX) = '' ,
    @PageNumber BIGINT ,
    @RowsPerPage BIGINT ,
    @UserID BIGINT
AS
    BEGIN
        WITH    CTE1
                  AS ( SELECT   PE.PremalinkId AS Id ,
                                PE.EmotionId
                       FROM     Premalink_Emotions PE
                                INNER JOIN Premalink_Emotions_User PEU ON PEU.Premalink_Emotions_Id = PE.Id
                                INNER JOIN Premalink P ON P.Id = PE.PremalinkId
                                INNER JOIN Website w ON w.Id = P.Website_Id
                       WHERE    w.Id = @WebsiteID
                                AND PE.EmotionId IN (
                                SELECT  Number
                                FROM    fnu_Split_Numbers_to_Tbl(@EmoId) )
                     ),
                CTE2
                  AS ( SELECT   PT.Premalink_Id AS Id ,
                                PT.Tag_Id
                       FROM     PremalinkTags PT
                                INNER JOIN PremalinkTag_User ptu ON ptu.PremalinkTagId = PT.Id
                                INNER JOIN Premalink P ON P.Id = PT.Premalink_Id
                                INNER JOIN Website w ON w.Id = P.Website_Id
                       WHERE    w.Id = @WebsiteID
                                AND PT.Tag_Id IN (
                                SELECT  Number
                                FROM    fnu_Split_Numbers_to_Tbl(@TagId) )
                     ),
                CTE3
                  AS ( SELECT   DENSE_RANK() OVER ( ORDER BY Id DESC ) AS RankNumber ,
                                Id ,
                                Tag_Id ,
                                EmotionId
                       FROM     ( SELECT    c1.Id ,
                                            c1.EmotionId ,
                                            0 AS Tag_Id
                                  FROM      CTE1 c1
                                  UNION
                                  SELECT    c2.Id ,
                                            0 AS EmotionId ,
                                            c2.Tag_Id
                                  FROM      CTE2 c2
                                ) AS UnionTable
                     )
            SELECT  DISTINCT
                    ut.RankNumber ,
                    ( SELECT    ISNULL(w.Image, '')
                      FROM      Website w
                      WHERE     w.Id = ( SELECT Website_Id
                                         FROM   Premalink
                                         WHERE  Id = p.Id
                                       )
                    ) AS WebsiteImage ,
                    ( SELECT    ISNULL(w.Name, '')
                      FROM      Website w
                      WHERE     w.Id = ( SELECT Website_Id
                                         FROM   Premalink
                                         WHERE  Id = p.Id
                                       )
                    ) AS WebsiteName ,
                    ( SELECT    ISNULL(w.URL, '')
                      FROM      Website w
                      WHERE     w.Id = ( SELECT Website_Id
                                         FROM   Premalink
                                         WHERE  Id = p.Id
                                       )
                    ) AS WebsiteUrl ,
                    ISNULL(p.Id, 0) AS PremalinkId ,
                    p.Link ,
                    ISNULL(p.Website_Id, 0) AS Website_Id ,
                    p.Title ,
                    p.Description ,
                    p.Image ,
                    ISNULL(p.CreatedOn, GETDATE()) AS CreatedOn ,
                    tallal78_8.funGetTags(p.Id, @UserID) AS TagString ,
                    tallal78_8.funGetEmotion(p.Id, @UserID) AS EmoString
            FROM    Premalink p
                    INNER JOIN CTE3 ut ON p.id = ut.Id
            WHERE   P.id IN ( SELECT    DISTINCT
                                        c3.Id
                              FROM      CTE3 c3 )
                    AND ut.RankNumber BETWEEN ( ( @PageNumber - 1 )
                                                * @RowsPerPage ) + 1
                                      AND     @RowsPerPage * ( @PageNumber )
            ORDER BY ut.RankNumber ASC
    END
GO
