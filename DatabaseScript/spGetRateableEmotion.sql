ALTER PROCEDURE spGetRateableEmotion @WebsiteId INT
AS 
    BEGIN

        SELECT  Id ,
                GroupName ,
                WebsiteId
        FROM    tallal78_8.EmotionGroup
        WHERE   WebsiteId = @WebsiteId
    END