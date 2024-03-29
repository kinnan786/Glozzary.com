/****** Object:  StoredProcedure [tallal78_8].[spGetTagId]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetTagId]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetTagId]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetTagId] @TagId INT, @UserID INT
AS
    BEGIN
        SELECT  t.[Id] ,
                [Name] AS TagName,
                t.[Image],
				t.About
        FROM    Tag t
                JOIN User_Tag_Follow utf ON t.Id = utf.TagId
        WHERE   t.Id = @TagId
                OR utf.UserId = @UserID
    END

GO
