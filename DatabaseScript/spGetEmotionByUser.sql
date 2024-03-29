/****** Object:  StoredProcedure [tallal78_8].[spGetEmotionByUser]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetEmotionByUser]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetEmotionByUser]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [tallal78_8].[spGetEmotionByUser] @UserID BIGINT
AS
    SELECT  PE.EmotionId AS EmotionId ,
            ( SELECT    Name
              FROM      Emotions
              WHERE     Id = PE.EmotionId
            ) AS EmotionName ,
            COUNT(PE.EmotionId) AS TotalCount
    FROM    Premalink_Emotions_User PEU
            INNER JOIN Premalink_Emotions PE ON PEU.Premalink_Emotions_Id = PE.Id
    WHERE   UserId = @UserID
    GROUP BY PE.EmotionId

GO
