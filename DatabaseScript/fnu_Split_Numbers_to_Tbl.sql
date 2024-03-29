/****** Object:  UserDefinedFunction [tallal78_8].[fnu_Split_Numbers_to_Tbl]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP FUNCTION [tallal78_8].[fnu_Split_Numbers_to_Tbl]
GO
/****** Object:  UserDefinedFunction [tallal78_8].[fnu_Split_Numbers_to_Tbl]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE FUNCTION [tallal78_8].[fnu_Split_Numbers_to_Tbl]
    (
      @stringArray VARCHAR(MAX)
    )
RETURNS @tbl TABLE
    (
      Number BIGINT NOT NULL
    )
AS
    BEGIN
        DECLARE @pos INT ,
            @nextpos INT ,
            @valuelen INT

        SELECT  @pos = 0 ,
                @nextpos = 1

        WHILE @nextpos > 0
            BEGIN
                SELECT  @nextpos = CHARINDEX(',', @stringArray, @pos + 1)
                SELECT  @valuelen = CASE WHEN @nextpos > 0 THEN @nextpos
                                         ELSE LEN(@stringArray) + 1
                                    END - @pos - 1
                INSERT  @tbl
                        ( number
                        )
                VALUES  ( CONVERT(BIGINT, SUBSTRING(@stringArray, @pos + 1,
                                                    @valuelen))
                        )
                SELECT  @pos = @nextpos
            END
        RETURN
    END

GO
