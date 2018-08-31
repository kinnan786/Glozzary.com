alter PROCEDURE spUpdateRateableEmotion
    @EmotionGroupId bigint ,
    @GroupName VARCHAR(50)
AS 
    BEGIN
        DECLARE @returnval INT = 0
        IF EXISTS ( SELECT  Id
                    FROM    EmotionGroup
                    WHERE   Id = @EmotionGroupId ) 
            BEGIN
   
                UPDATE  EmotionGroup
                SET     GroupName = GroupName
                WHERE   id = @EmotionGroupId 

                SET @returnval = 1
            END 

        SELECT  @returnval
   
    END