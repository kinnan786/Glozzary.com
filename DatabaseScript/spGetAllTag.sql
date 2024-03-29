/****** Object:  StoredProcedure [tallal78_8].[spGetAllTag]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetAllTag]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetAllTag]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spGetAllTag]
    @WebSiteName VARCHAR(MAX) = '' ,
    @Premalink VARCHAR(MAX) ,
    @UserId BIGINT
AS
    BEGIN
        DECLARE @PremalinkId BIGINT = 0
        DECLARE @WebsiteId BIGINT = 0

        SELECT  @WebsiteId = ISNULL(w.id, 2)
        FROM    Website w
        WHERE   w.Name = @WebSiteName

        IF @WebsiteId = ''
            SET @WebsiteId = 2

        IF @WebSiteName <> ''
            BEGIN
                IF NOT EXISTS ( SELECT  *
                                FROM    Premalink p
                                        JOIN Website w ON w.Id = p.Website_Id
                                WHERE   w.Id = @WebsiteId
                                        OR Link = @Premalink )
                    BEGIN
                        INSERT  INTO [Premalink]
                                ( [Link] ,
                                  [Website_Id] ,
                                  [Site_name] ,
                                  [MetaTagCheck] ,
                                  [CreatedOn]

                                )
                        VALUES  ( @Premalink ,
                                  @WebsiteId ,
                                  @WebSiteName ,
                                  0 ,
                                  GETDATE()
                                )

                    END
            END

        SELECT  t.Id AS Tagid ,
                t.NAME AS TagName ,
                ( SELECT    SUM(ptu.UpVote)
                  FROM      PremalinkTag_User ptu
                  WHERE     ptu.PremalinkTagId = pt.Id
                ) AS UpVote ,
                ( SELECT    SUM(ptu.DownVote)
                  FROM      PremalinkTag_User ptu
                  WHERE     ptu.PremalinkTagId = pt.Id
                ) AS DownVote ,
                ( ISNULL(( SELECT   SUM(ptu.UpVote)
                           FROM     PremalinkTag_User ptu
                           WHERE    ptu.PremalinkTagId = pt.Id
                         ), 0) - ISNULL(( SELECT    SUM(ptu.DownVote)
                                          FROM      PremalinkTag_User ptu
                                          WHERE     ptu.PremalinkTagId = pt.Id
                                        ), 0) ) AS TotalVote ,
                p.MetaTagCheck ,
                CASE WHEN ISNULL(( SELECT   ptu.UserId
                                   FROM     PremalinkTag_User ptu
                                   WHERE    ptu.PremalinkTagId = pt.Id
                                 ), 0) = @userId THEN 'true'
                     ELSE 'false'
                END IsActive ,
                p.Link
        FROM    Premalink p
                INNER JOIN premalinkTags pt ON p.id = pt.Premalink_Id
                INNER JOIN tag t ON pt.Tag_Id = t.Id
        WHERE   p.Link = @Premalink
    END

GO
