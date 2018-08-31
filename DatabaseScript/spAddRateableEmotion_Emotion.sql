CREATE PROCEDURE spAddRateableEmotion_Emotion
    @EmotionGroupId BIGINT ,
    @EmotionId BIGINT
AS
    BEGIN

        INSERT  INTO [EmotionGroup_Emotion]
                ( [EmotionGroupId], [EmotionId] )
        VALUES  ( @EmotionGroupId, @EmotionId )

        SELECT  SCOPE_IDENTITY()

    END