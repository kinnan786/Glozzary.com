/****** Object:  StoredProcedure [tallal78_8].[spGetPremalinkById]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetPremalinkById]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetPremalinkById]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetPremalinkById] @PremalinkId BIGINT
AS
    BEGIN
        SELECT  [Id] AS PremalinkID ,
                [Link] ,
                [Website_Id] ,
                ( SELECT    Name
                  FROM      Website
                  WHERE     id = Website_Id
                ) AS Site_Name ,
                ISNULL([Title], '') AS Title ,
                ISNULL([Description], '') AS Description ,
                ISNULL([Image], '') AS [Image] ,
                ISNULL([Type], 5) AS [Type] ,
                ISNULL([CreatedOn], GETDATE()) AS CreatedOn
        FROM    [Premalink]
        WHERE   id = @PremalinkId
    END
GO
