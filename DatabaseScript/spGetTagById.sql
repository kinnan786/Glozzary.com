/****** Object:  StoredProcedure [tallal78_8].[spGetTagById]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetTagById]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetTagById]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetTagById] @TagId BIGINT
AS
    BEGIN

        SELECT  Name ,
                About
        FROM    Tag
        WHERE   Id = @TagId

    END
GO
