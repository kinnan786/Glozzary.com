/****** Object:  StoredProcedure [tallal78_8].[spExplorehNewsFeed]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spExplorehNewsFeed]
GO
/****** Object:  StoredProcedure [tallal78_8].[spExplorehNewsFeed]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spExplorehNewsFeed]
    @Search VARCHAR(MAX) ,
    @UserId BIGINT ,
    @PageNumber BIGINT ,
    @RowsPerPage BIGINT
AS
    BEGIN
        WITH    CTE
                  AS ( SELECT   PTs.Premalink_Id AS Id ,
                                ( DENSE_RANK() OVER ( ORDER BY PTs.Premalink_Id ) ) AS RankNumber
                       FROM     PremalinkTags PTs
                       WHERE    PTs.Tag_Id in ( SELECT   id
                                               FROM     Tag
                                               WHERE    Name LIKE '%'+@Search+'%'
                                             )
                     ),
                CTE1
                  AS ( SELECT   ISNULL(p.Id, 0) AS PremalinkId ,
                                pt.Tag_Id ,
                                ( SELECT TOP 1
                                            RankNumber
                                  FROM      CTE e
                                  WHERE     e.Id = p.Id
                                ) AS RankNumber ,
                                ( SELECT    t.Name
                                  FROM      Tag t
                                  WHERE     t.Id = pt.Tag_Id
                                ) AS TagName ,
                                ( SELECT    SUM(ptu.UpVote)
                                  FROM      PremalinkTag_User ptu
                                  WHERE     ptu.PremalinkTagId = pt.Id
                                ) AS UpVote ,
                                ( SELECT    SUM(ptu.DownVote)
                                  FROM      PremalinkTag_User ptu
                                  WHERE     ptu.PremalinkTagId = pt.Id
                                ) AS DownVote ,
                                ( ISNULL(( SELECT   SUM(ptu.UpVote)
                                           FROM     PremalinkTag_User ptu
                                           WHERE    ptu.PremalinkTagId = pt.Id
                                         ), 0)
                                  - ISNULL(( SELECT SUM(ptu.DownVote)
                                             FROM   PremalinkTag_User ptu
                                             WHERE  ptu.PremalinkTagId = pt.Id
                                           ), 0) ) AS TotalVote ,
                                p.Link ,
                                ISNULL(p.Website_Id, 0) AS Website_Id ,
                                ( SELECT    Name
                                  FROM      Website
                                  WHERE     id = p.Website_Id
                                ) AS WebsiteName ,
                                p.Title ,
                                p.Description ,
                                p.Image ,
                                ISNULL(pt.Date, GETDATE()) AS CreatedOn ,
                                CASE WHEN ( SELECT  ptu.UserId
                                            FROM    PremalinkTag_User ptu
                                            WHERE   ptu.PremalinkTagId = pt.Id
                                                    AND ptu.UserId = @UserId
                                          ) = @UserId THEN 'true'
                                     ELSE 'false'
                                END TaggedByUser
                       FROM     Premalink p
                                INNER JOIN PremalinkTags pt ON p.id = pt.Premalink_id
                       WHERE    P.id IN ( SELECT    DISTINCT
                                                    c.Id
                                          FROM      CTE c )
                     ),
                CTE2
                  AS ( SELECT   ISNULL(PE.EmotionId, 0) AS EmotionId ,
                                PE.PremalinkId ,
                                ( SELECT TOP 1
                                            RankNumber
                                  FROM      CTE e
                                  WHERE     e.Id = PE.PremalinkId
                                ) AS RankNumber ,
                                ( SELECT    ISNULL(E.Name, '')
                                  FROM      Emotions E
                                  WHERE     E.id = PE.EmotionId
                                ) AS EmotionName ,
                                ( SELECT    COUNT(PEU.Id)
                                  FROM      Premalink_Emotions_User PEU
                                  WHERE     Premalink_Emotions_Id = PE.Id
                                ) AS TotalCount ,
                                ISNULL(( SELECT ISNULL(PEU.Id, 0)
                                         FROM   Premalink_Emotions_User PEU
                                         WHERE  PEU.Premalink_Emotions_Id = PE.Id
                                                AND PEU.UserId = @UserId
                                       ), 0) AS UserEmotion
                       FROM     Premalink_Emotions PE
                                INNER JOIN Premalink_Emotions_User PEU ON PEU.Premalink_Emotions_Id = PE.Id
                       WHERE    PE.PremalinkId IN ( SELECT  Id
                                                    FROM    CTE )
                     )
            SELECT  PremalinkId ,
                    WebsiteName ,
                    Tag_Id ,
                    RankNumber ,
                    TagName ,
                    UpVote ,
                    DownVote ,
                    TotalVote ,
                    Link ,
                    Website_Id ,
                    Title ,
                    Description ,
                    Image ,
                    CreatedOn ,
                    TaggedByUser ,
                    0 AS EmotionId ,
                    0 AS PremalinkId ,
                    '' AS EmotionName ,
                    0 AS TotalCount ,
                    0 AS UserEmotion
            FROM    CTE1
            WHERE   RankNumber BETWEEN ( ( @PageNumber - 1 ) * @RowsPerPage )
                                       + 1
                               AND     @RowsPerPage * ( @PageNumber )
            UNION
            SELECT  PremalinkId ,
                    '' AS WebsiteName ,
                    0 AS Tag_Id ,
                    RankNumber ,
                    '' AS TagName ,
                    0 AS UpVote ,
                    0 AS DownVote ,
                    0 AS TotalVote ,
                    '' AS Link ,
                    0 AS Website_Id ,
                    '' AS Title ,
                    '' AS Description ,
                    '' AS Image ,
                    '' AS CreatedOn ,
                    'false' AS TaggedByUser ,
                    EmotionId ,
                    PremalinkId ,
                    EmotionName ,
                    TotalCount ,
                    UserEmotion
            FROM    CTE2 c2
            WHERE   RankNumber BETWEEN ( ( @PageNumber - 1 ) * @RowsPerPage )
                                       + 1
                               AND     @RowsPerPage * ( @PageNumber )
            
    END

GO
