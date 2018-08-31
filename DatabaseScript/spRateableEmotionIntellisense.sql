alter PROCEDURE [spRateableEmotionIntellisense]
    @PrefixText VARCHAR(MAX)
AS 
    DECLARE @filter VARCHAR(MAX) = ''
    SET @filter = @PrefixText + '%'

    BEGIN
        SELECT  [Id] ,
                [Name]
        FROM    [Emotions]
        WHERE   Name LIKE @filter
    END