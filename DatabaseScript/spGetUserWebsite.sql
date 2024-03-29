ALTER PROCEDURE [tallal78_8].[spGetUserWebsite] @UserID INT
AS 
    BEGIN
        IF EXISTS ( SELECT  *
                    FROM    [user]
                    WHERE   Id = @userID
                            AND isUser <> 1 ) 
            BEGIN
                SELECT  [Id] AS WebsiteID ,
                        [Name] AS WebSiteName ,
                        [URL] AS WebsiteURL ,
                        [Description] ,
                        [userId] AS UserID ,
                        ISNULL([AddTag], 'false') AS AddTag ,
                        ISNULL([RateTag], 'false') AS RateTag ,
                        ISNULL([AddEmotion], 'false') AS AddEmotion ,
                        ISNULL([Emotion], 'false') AS Emotion ,
                        ISNULL([Tag], 'false') AS Tag ,
                        ISNULL([Image], '') AS [Image]
                FROM    [Website]
                WHERE   userId = @UserID
            END
    END
GO