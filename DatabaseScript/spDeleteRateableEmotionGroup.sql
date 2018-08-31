CREATE PROCEDURE spDeleteRateableEmotionGroup @Id BIGINT
AS
    BEGIN


        DELETE  FROM [EmotionGroup_Emotion]
        WHERE   [EmotionGroupId] = @ID


        DELETE  FROM EmotionGroup
        WHERE   Id = @ID


    END 