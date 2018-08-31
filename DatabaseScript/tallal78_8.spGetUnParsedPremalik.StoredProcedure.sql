/****** Object:  StoredProcedure [tallal78_8].[spGetUnParsedPremalik]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetUnParsedPremalik]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetUnParsedPremalik]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spGetUnParsedPremalik]
AS
    BEGIN
        SELECT  TOP 1 [Id] AS PremalinkID ,
                [Link] ,
                [Website_Id] ,
                [Site_name]
        FROM    [Premalink]
        WHERE   MetaTagCheck = 0
		ORDER BY CreatedOn ASC
    END
GO
