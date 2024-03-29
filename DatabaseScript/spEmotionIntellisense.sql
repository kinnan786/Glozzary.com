/****** Object:  StoredProcedure [tallal78_8].[spEmotionIntellisense]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spEmotionIntellisense]
GO
/****** Object:  StoredProcedure [tallal78_8].[spEmotionIntellisense]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [tallal78_8].[spEmotionIntellisense]
    @Emotion VARCHAR(MAX) ,
    @Premalink VARCHAR(MAX)
AS
    BEGIN
        
        DECLARE @Query VARCHAR(50)
        SET @Query = @Emotion + '%'

        SELECT  E.[Id] ,
                E.[Name]
        FROM    [Emotions] E
        WHERE   E.Id NOT IN (
                SELECT  PE.EmotionId
                FROM    Premalink_Emotions PE
                        INNER JOIN Premalink P ON PE.PremalinkId = P.Id
                WHERE   p.Link = @Premalink )
                AND Name LIKE @Query

    END


GO
