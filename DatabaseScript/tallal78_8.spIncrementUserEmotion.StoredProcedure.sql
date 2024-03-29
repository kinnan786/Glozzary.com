/****** Object:  StoredProcedure [tallal78_8].[spIncrementUserEmotion]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spIncrementUserEmotion]
GO
/****** Object:  StoredProcedure [tallal78_8].[spIncrementUserEmotion]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spIncrementUserEmotion]
    @EmotionId INT ,
    @CurrentUserID BIGINT ,
    @LoggedInUser BIGINT = 0
AS
    BEGIN

        IF NOT EXISTS ( SELECT  *
                        FROM    EmotionUser
                        WHERE   EmotionId = @EmotionId
                                AND UserID = @CurrentUserID
                                AND EmotionUserId = @LoggedInUser )
            BEGIN
    
                INSERT  INTO [EmotionUser]
                        ( [UserID] ,
                          [EmotionId] ,
                          [EmotionUserId] ,
                          [Date]
                        )
                VALUES  ( @CurrentUserID ,
                          @EmotionId ,
                          @LoggedInUser ,
                          GETDATE()
                        )
            END
    END

GO
