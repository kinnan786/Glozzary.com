/****** Object:  StoredProcedure [tallal78_8].[spGetWebsiteByName]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetWebsiteByName]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetWebsiteByName]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetWebsiteByName]
    @WebsiteName VARCHAR(50)
AS
    BEGIN

        SELECT  [Id] ,
                [AddTag] ,
                [RateTag] ,
                [AddEmotion] ,
                [Emotion] ,
                [Tag]
        FROM    [Website]
        WHERE   Name = @WebsiteName

    END
GO
