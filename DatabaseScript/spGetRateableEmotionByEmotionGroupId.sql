ALTER PROCEDURE spGetRateableEmotionByEmotionGroupId
    @EmotionGroupId BIGINT
AS 
    BEGIN
        SELECT  e.Id ,
                Name ,
                ege.EmotionGroupId ,
                ( SELECT    eg.GroupName
                  FROM      EmotionGroup eg
                  WHERE     eg.Id = @EmotionGroupId
                ) AS GroupName
        FROM    EmotionGroup_Emotion ege
                Left JOIN Emotions e ON e.Id = ege.EmotionId
        WHERE   ege.EmotionGroupId = @EmotionGroupId
    END