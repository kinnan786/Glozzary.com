ALTER Procedure GetRateableemotionPlugin --'6167e365-0b7b-4436-b46d-76b67b9775c6','KinnanNawaz','http://work4sale.tumblr.com/post/87523490471',21
	@RateabletagId varchar(50),
	@websiteName varchar(50),
	@Premalink varchar(max),
	@CurrentUserId bigint
As
Begin

--EmotionId
--EmotionName
--EmotionCount
--currentuserflaged

DECLARE @PremalinkId BIGINT = 0
DECLARE @WebsiteId BIGINT = 0
DECLARE @EmotionId BIGINT = 0
DECLARE @totalcount BIGINT = 0
DECLARE @index BIGINT = 0 
       
SELECT  @WebsiteId = id
FROM    Website
WHERE   Name = @websiteName

IF NOT EXISTS ( SELECT  Id
                FROM    Premalink
                WHERE   Link = @Premalink
                        AND Website_Id = @WebsiteId ) 
    BEGIN
                 
        INSERT  INTO [Premalink]
                ( [Link], [Website_Id], [CreatedOn] )
        VALUES  ( @Premalink, @WebsiteId, GETDATE() )

        SET @PremalinkId = SCOPE_IDENTITY()

    END
ELSE 
    BEGIN

        SELECT  @PremalinkId = Id
        FROM    Premalink
        WHERE   Link = @Premalink
                AND Website_Id = @WebsiteId 

    END

SELECT  @totalcount = COUNT(*)
FROM    Emotions
WHERE   id IN ( SELECT  EmotionId
                FROM    EmotionGroup_Emotion
                WHERE   EmotionGroupId = ( SELECT   id
                                           FROM     EmotionGroup
                                           WHERE    UniqueID = @RateabletagId
                                         ) )          
WHILE @totalcount > @index 
    BEGIN   

        SET @index = @index + 1
       
        SELECT  @EmotionId = Id
        FROM    ( SELECT    Id ,
                            ROW_NUMBER() OVER ( ORDER BY id ) AS Number
                  FROM      Emotions
                  WHERE     id IN (
                            SELECT  EmotionId
                            FROM    EmotionGroup_Emotion
                            WHERE   EmotionGroupId = ( SELECT id
                                                       FROM   EmotionGroup
                                                       WHERE  UniqueID = @RateabletagId
                                                     ) )
                ) AS temptable
        WHERE   temptable.Number = @index

        IF NOT EXISTS ( SELECT  *
                        FROM    Premalink_Emotions
                        WHERE   EmotionId = @EmotionId
                                AND PremalinkId = @PremalinkId ) 
            BEGIN  

                INSERT  INTO [Premalink_Emotions]
                        ( [PremalinkId] ,
                          [EmotionId] ,
                          [Date]
                        )
                VALUES  ( @PremalinkId ,
                          @EmotionId ,
                          GETDATE()
                        )
            END
    END

SELECT  T1.EmotionId AS Id ,
        T1.EmotionName AS Name ,
        ISNULL(T1.EmotionCount,0) AS Counts ,
        ISNULL(( SELECT peuu.Id
                 FROM   Premalink_Emotions_User peuu
                 WHERE  peuu.UserId = @CurrentUserId
                        AND peuu.Premalink_Emotions_Id = ( SELECT
                                                              id
                                                           FROM
                                                              Premalink_Emotions
                                                           WHERE
                                                              PremalinkId = @PremalinkId
                                                              AND EmotionId = T1.EmotionId
                                                         )
               ), 0) AS flag
FROM    ( SELECT    T.EmotionId ,
                    T.EmotionName ,
                    COUNT(T.EmotionId) AS EmotionCount
          FROM      ( SELECT    e.Id AS EmotionId ,
                                e.Name AS EmotionName ,
                                pe.Id AS PremalinkemotionId
                      FROM      Emotions e
                                INNER JOIN Premalink_Emotions pe ON e.Id = pe.EmotionId
                                                              AND pe.PremalinkId = @PremalinkId
                      WHERE     e.id IN (
                                SELECT  ege.EmotionId
                                FROM    EmotionGroup_Emotion ege
                                WHERE   ege.EmotionGroupId = ( SELECT
                                                              eg.id
                                                              FROM
                                                              EmotionGroup eg
                                                              WHERE
                                                              eg.UniqueID = @RateabletagId
                                                             ) )
                    ) AS T
                    LEFT JOIN Premalink_Emotions_User peu ON peu.Premalink_Emotions_Id = T.PremalinkemotionId
          GROUP BY  T.EmotionId ,
                    T.EmotionName
        ) AS T1

End