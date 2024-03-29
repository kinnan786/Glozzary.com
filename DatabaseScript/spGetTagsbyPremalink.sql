/****** Object:  StoredProcedure [tallal78_8].[spGetTagsbyPremalink]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetTagsbyPremalink]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetTagsbyPremalink]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetTagsbyPremalink]
    @Premalink VARCHAR(MAX)
AS
    BEGIN
	
        SELECT  p.[Id] ,
                pt.Tag_Id ,
                ( SELECT    t.Name
                  FROM      Tag t
                  WHERE     t.Id = pt.Tag_Id
                ) AS TagName ,
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
                                        ), 0) ) AS TotalVote
        FROM    [Premalink] p
                INNER	JOIN PremalinkTags pt ON p.id = pt.Premalink_id
        WHERE   Link = @Premalink
    END

GO
