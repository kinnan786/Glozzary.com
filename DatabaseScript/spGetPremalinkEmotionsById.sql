
alter PROCEDURE [spGetPremalinkEmotionsById] @PremaLinkID INT
AS
    BEGIN
        SELECT  e.[Id] AS EmotionId ,
                e.[Name] AS EmotionName
        FROM    Emotions e
                JOIN premalink_emotions pe ON e.Id = pe.EmotionId
        WHERE   pe.PremalinkId = @PremaLinkID
    END
GO

