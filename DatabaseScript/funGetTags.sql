/****** Object:  UserDefinedFunction [tallal78_8].[funGetTags]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP FUNCTION [tallal78_8].[funGetTags]
GO
/****** Object:  UserDefinedFunction [tallal78_8].[funGetTags]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [tallal78_8].[funGetTags]
    (
      @PremaLinkId BIGINT ,
      @UserID BIGINT
    )
RETURNS VARCHAR(MAX)
AS
    BEGIN
        DECLARE @tagname VARCHAR(MAX) = ''
        SELECT  @tagname = @tagname + CAST(t.Id AS VARCHAR) + ',' + t.Name
                + ','
                + CAST(( ISNULL(( SELECT    SUM(ptu1.UpVote)
                                  FROM      PremalinkTag_User ptu1
                                  WHERE     ptu1.PremalinkTagId = pt.Id
                                ), 0)
                         - ISNULL(( SELECT  SUM(ptu1.DownVote)
                                    FROM    PremalinkTag_User ptu1
                                    WHERE   ptu1.PremalinkTagId = pt.Id
                                  ), 0) ) AS VARCHAR) + ','
                + CAST(( SELECT ISNULL(ptu1.UserId, 0)
                         FROM   PremalinkTag_User ptu1
                         WHERE  ptu1.PremalinkTagId = pt.Id
                                AND ptu1.UserId = @UserID
                       ) AS VARCHAR) + '|'
        FROM    Tag t
                INNER JOIN PremalinkTags PT ON t.Id = PT.Tag_Id
                INNER JOIN PremalinkTag_User PTU ON PT.Id = PTU.PremalinkTagId
        WHERE   PT.Premalink_Id = @PremaLinkId
        RETURN @tagname
    END

GO
