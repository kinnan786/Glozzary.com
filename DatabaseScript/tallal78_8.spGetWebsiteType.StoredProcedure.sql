/****** Object:  StoredProcedure [tallal78_8].[spGetWebsiteType]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetWebsiteType]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetWebsiteType]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetWebsiteType]
AS
    BEGIN

        SELECT  [Id] ,
                [Type]
        FROM    [WebsiteType]

    END
GO
