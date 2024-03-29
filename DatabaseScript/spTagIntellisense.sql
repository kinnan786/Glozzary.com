
create PROCEDURE [tallal78_8].[spTagIntellisense]
    @Premalink VARCHAR(MAX) ,
    @PrefixText VARCHAR(MAX)
AS
    DECLARE @filter VARCHAR(MAX) = ''
    SET @filter = @PrefixText + '%'

    BEGIN
        SELECT  [Id] ,
                [Name] ,
                [TagTypeId] ,
                [Image] ,
                [About]
        FROM    [Tag]
        WHERE   Name LIKE @filter
                AND Id NOT IN (
                SELECT  Tag_Id
                FROM    PremalinkTags
                WHERE   Premalink_Id = ( SELECT TOP 1
                                                Id
                                         FROM   Premalink
                                         WHERE  Link = @Premalink
                                       ) )

    END
