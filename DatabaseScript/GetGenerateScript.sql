ALTER PROCEDURE GetGenerateScript
    @GroupId BIGINT ,
    @userId BIGINT
AS 
    BEGIN

        DECLARE @websiteId BIGINT
        SELECT  @websiteId = WebsiteId
        FROM    EmotionGroup
        WHERE   id = @Groupid


        IF EXISTS ( SELECT  *
                    FROM    Website
                    WHERE   UserId = @userid
                            AND id = @websiteId ) 
            BEGIN

                SELECT  UniqueID ,
                        ( SELECT    Name
                          FROM      Website
                          WHERE     id = WebsiteId
                        ) AS Name
                FROM    EmotionGroup
                WHERE   Id = @GroupId

            END


    END