/****** Object:  StoredProcedure [tallal78_8].[spAddPremalinkimages]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spAddPremalinkimages]
GO
/****** Object:  StoredProcedure [tallal78_8].[spAddPremalinkimages]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spAddPremalinkimages]
    @premalink VARCHAR(MAX) ,
    @imageurl VARCHAR(MAX)
AS
    BEGIN

        UPDATE  [Premalink]
        SET     [Image] = @imageurl
        WHERE   Link = @premalink

		SELECT 1
    END

GO
