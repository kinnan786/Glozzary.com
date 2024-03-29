/****** Object:  StoredProcedure [tallal78_8].[spDecrementTaggedEmotion]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spDecrementTaggedEmotion]
GO
/****** Object:  StoredProcedure [tallal78_8].[spDecrementTaggedEmotion]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spDecrementTaggedEmotion]
    @TagId BIGINT ,
    @EmotionId INT ,
    @UserId BIGINT
AS
    BEGIN

        DECLARE @Reurnvalue INT
        DECLARE @TaggedEmotionId BIGINT
		
        SELECT  @TaggedEmotionId = TE.Id
        FROM    TaggedEmotion TE
        WHERE   TE.EmotionId = @EmotionId
                AND TE.TagId = @TagId

        IF EXISTS ( SELECT  *
                        FROM    Tag_Emotion_User
                        WHERE   UserId = @UserId
                                AND TaggedEmotionId = @TaggedEmotionId )
            BEGIN

                DELETE  FROM Tag_Emotion_User
                WHERE   UserId = @UserId
                        AND TaggedEmotionId = @TaggedEmotionId

                SELECT  @Reurnvalue = SCOPE_IDENTITY()
            END
        ELSE
            SET @Reurnvalue = 0

        SELECT  @Reurnvalue
   
    END
GO
