/****** Object:  StoredProcedure [tallal78_8].[spGetUserEmotion]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetUserEmotion]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetUserEmotion]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetUserEmotion]
    @CurrentUserID BIGINT ,
    @LoggedInUser BIGINT = 0
AS
    BEGIN

        DECLARE @index BIGINT = 0
        DECLARE @count BIGINT = 0
        DECLARE @ReturnTable TABLE
            (
              EmotionID BIGINT ,
              EmotionName VARCHAR(50) ,
              EmotionUserId BIGINT ,
              LoggedUserEmotion BIGINT ,
              TotalCount BIGINT
            );

        DECLARE @TempTable TABLE
            (
              RowNumber BIGINT ,
              EmotionID BIGINT ,
              EmotionName VARCHAR(50) ,
              EmotionUserId BIGINT ,
              TotalCount BIGINT
            );
        
        WITH    MyCTE
                  AS ( SELECT   EmotionId ,
                                ( SELECT    Name
                                  FROM      Emotions
                                  WHERE     id = EmotionId
                                ) AS EmotionName ,
                                COUNT(EmotionId) AS TotalCount
                       FROM     [EmotionUser]
                       WHERE    UserID = @CurrentUserID
                       GROUP BY EmotionId
                     )
            INSERT  INTO @TempTable
                    ( RowNumber ,
                      EmotionId ,
                      EmotionName ,
                      TotalCount ,
                      EmotionUserId				
                    )
                    SELECT  ROW_NUMBER() OVER ( ORDER BY C.TotalCount DESC ) AS RowNumber ,
                            C.EmotionId ,
                            C.EmotionName ,
                            C.TotalCount ,
                            E.EmotionUserId
                    FROM    MyCTE C
                            LEFT JOIN EmotionUser E ON E.EmotionId = C.EmotionId
		
        SELECT  @count = COUNT(ISNULL(EmotionId, 0))
        FROM    @TempTable

        DECLARE @EmotionID BIGINT = 0 
        DECLARE @EmotionName VARCHAR(MAX)
        DECLARE @EmotionUserId BIGINT = 0 
        DECLARE @LoggedUserEmotion BIGINT = 0 
        DECLARE @TotalCount BIGINT = 0 
				

        WHILE @index < @count
            BEGIN

                SET @index += 1;

                SELECT  @EmotionID = EmotionID
                FROM    @TempTable
                WHERE   RowNumber = @index 

                SELECT  @EmotionName = EmotionName
                FROM    @TempTable
                WHERE   RowNumber = @index 

                SELECT  @EmotionUserId = ISNULL(EmotionUserId, 0)
                FROM    @TempTable
                WHERE   RowNumber = @index
            
                IF EXISTS ( SELECT  EmotionID
                            FROM    @TempTable
                            WHERE   EmotionUserId = @LoggedInUser
                                    AND EmotionID = @EmotionID )
                    SET @LoggedUserEmotion = 1
                ELSE
                    SET @LoggedUserEmotion = 0
		
                SELECT  @TotalCount = TotalCount
                FROM    @TempTable
                WHERE   RowNumber = @index 

                IF NOT EXISTS ( SELECT  *
                                FROM    @ReturnTable
                                WHERE   EmotionID = ( SELECT  EmotionID
                                                      FROM    @TempTable
                                                      WHERE   RowNumber = @index
                                                    ) )
                    BEGIN
	
	
                        INSERT  @ReturnTable
                                ( EmotionId ,
                                  EmotionName ,
                                  EmotionUserId ,
                                  LoggedUserEmotion ,
                                  TotalCount
							
                                )
                        VALUES  ( @EmotionID ,
                                  @EmotionName ,
                                  @EmotionUserId ,
                                  @LoggedUserEmotion ,
                                  @TotalCount						
                                )
                    END
            END

        SELECT  C.EmotionID ,
                C.EmotionName ,
                C.EmotionUserId ,
                C.LoggedUserEmotion ,
                C.TotalCount
        FROM    @ReturnTable C

    END
GO
