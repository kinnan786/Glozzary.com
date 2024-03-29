
alter PROCEDURE [tallal78_8].[spGetWebsitePremalink]
    @WebSiteID INT ,
    @Link VARCHAR(MAX) = ''
AS
    BEGIN
        IF @Link <> ''
            BEGIN
                SELECT  p.[Id] AS PremalinkID ,
                        p.[Link] ,
                        ( SELECT    COUNT(*)
                          FROM      PremalinkTags pt
                          WHERE     pt.Premalink_Id = p.Id
                        ) AS TagCount
                FROM    Premalink p
                WHERE   p.Website_Id = @WebSiteID
                        AND Link = @Link 
            END     
        ELSE
            BEGIN
                SELECT  p.[Id] AS PremalinkID ,
                        p.[Link] ,
                        ( SELECT    COUNT(*)
                          FROM      PremalinkTags pt
                          WHERE     pt.Premalink_Id = p.Id
                        ) AS TagCount
                FROM    Premalink p
                WHERE   p.Website_Id = @WebSiteID
            END  
    END
GO
