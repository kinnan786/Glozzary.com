/****** Object:  StoredProcedure [tallal78_8].[spDecrementUserEmotion]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spDecrementUserEmotion]
GO
/****** Object:  StoredProcedure [tallal78_8].[spDecrementUserEmotion]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spDecrementUserEmotion]
    @EmotionId INT ,
    @CurrentUserID BIGINT ,
    @LoggedInUser BIGINT = 0
AS
    BEGIN

        IF EXISTS ( SELECT  *
                    FROM    EmotionUser
                    WHERE   EmotionId = @EmotionId
                            AND UserID = @CurrentUserID
                            AND EmotionUserId = @LoggedInUser )
            BEGIN
       
                DELETE  FROM EmotionUser
                WHERE   EmotionId = @EmotionId
                        AND UserID = @CurrentUserID
                        AND EmotionUserId = @LoggedInUser 
            END

    END

GO
