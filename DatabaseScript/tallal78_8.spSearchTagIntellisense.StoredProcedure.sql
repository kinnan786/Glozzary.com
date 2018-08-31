/****** Object:  StoredProcedure [tallal78_8].[spSearchTagIntellisense]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spSearchTagIntellisense]
GO
/****** Object:  StoredProcedure [tallal78_8].[spSearchTagIntellisense]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spSearchTagIntellisense] @TagName VARCHAR(MAX)
AS
    BEGIN
        DECLARE @filter VARCHAR(MAX) = ''
        SET @filter = '%' + @TagName + '%'

        BEGIN
            SELECT  TOP 50 [Id] AS TagId ,
                    [Name] AS TagName
            FROM    [Tag]
            WHERE   Name LIKE @filter
               
        END
    END
GO
