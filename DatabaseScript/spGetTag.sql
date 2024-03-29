/****** Object:  StoredProcedure [tallal78_8].[spGetTag]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetTag]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetTag]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [tallal78_8].[spGetTag]
    @Premalink VARCHAR(MAX)
AS
    SELECT  t.Id AS Tagid ,
            t.NAME AS TagName ,
            ( ISNULL(ptu.UpVote, 0) - ISNULL(ptu.DownVote, 0) ) AS TotalVote ,
            p.MetaTagCheck
    FROM    Premalink p
            INNER JOIN premalinkTags pt ON p.id = pt.Premalink_Id
            INNER JOIN PremalinkTag_User ptu ON ptu.PremalinkTagId = pt.Id
            INNER JOIN tag t ON pt.Tag_Id = t.Id
    WHERE   p.Link = @Premalink
            AND ( ISNULL(ptu.UpVote, 0) - ISNULL(ptu.DownVote, 0) ) <> 0

GO
