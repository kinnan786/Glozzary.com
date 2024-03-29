/****** Object:  StoredProcedure [tallal78_8].[spGetUserTags]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetUserTags]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetUserTags]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetUserTags]
    @CurrentUserID BIGINT ,
    @LoggedInUser BIGINT = 0
AS
    BEGIN

		--DECLARE @CurrentUserID BIGINT =1
		--DECLARE @LoggedInUser BIGINT = 1
        DECLARE @index BIGINT = 0
        DECLARE @count BIGINT = 0


        DECLARE @ReturnTable TABLE
            (
              TagID BIGINT ,
              TagName VARCHAR(50) ,
              TaggedBy BIGINT ,
              [COUNT] BIGINT ,
              LoggedUserTag BIGINT
            );

        DECLARE @TempTable TABLE
            (
              RowNumber BIGINT ,
              TagID BIGINT ,
              TagName VARCHAR(50) ,
              TaggedBy BIGINT
            );

        INSERT  INTO @TempTable
                ( RowNumber ,
                  TagID ,
                  TagName ,
                  TaggedBy 
                )
                SELECT  ROW_NUMBER() OVER ( ORDER BY TagID ASC ) AS RowNumber ,
                        [TagID] ,
                        ( SELECT    Name
                          FROM      Tag
                          WHERE     Id = TagID
                        ) AS TagName ,
                        [TaggedBy]
                FROM    [TaggedUsers] A
                WHERE   UserID = @CurrentUserID

        SELECT  @count = COUNT(ISNULL(TagId, 0))
        FROM    @TempTable

        DECLARE @TagID BIGINT = 0 
        DECLARE @TagName VARCHAR(MAX)
        DECLARE @TaggedBy BIGINT = 0 
        DECLARE @Vote INT = 0
        DECLARE @LoggedUserTag BIGINT = 0

        WHILE @index < @count
            BEGIN

                SET @index += 1;

                SELECT  @TagName = TagName
                FROM    @TempTable
                WHERE   RowNumber = @index 
          
                SELECT  @TagID = TagID
                FROM    @TempTable
                WHERE   RowNumber = @index 
          
                SELECT  @TaggedBy = TaggedBy
                FROM    @TempTable
                WHERE   RowNumber = @index 

                IF EXISTS ( SELECT  *
                            FROM    @TempTable
                            WHERE   TaggedBy = @LoggedInUser
                                    AND TagID = @TagID )
                    SET @LoggedUserTag = 1
                ELSE
                    SET @LoggedUserTag = 0
		
                SELECT  @Vote = ( SUM(ISNULL(upvote, 0)) - SUM(ISNULL(downvote,
                                                              0)) )
                FROM    TaggedUsers_Votes
                WHERE   TagID = @TagID
                        AND userid = @CurrentUserID

				
                IF NOT EXISTS ( SELECT  *
                                FROM    @ReturnTable
                                WHERE   TagID = ( SELECT    TagID
                                                  FROM      @TempTable
                                                  WHERE     RowNumber = @index
                                                ) )
                    BEGIN
                        INSERT  @ReturnTable
                                ( TagID ,
                                  TagName ,
                                  TaggedBy ,
                                  [COUNT] ,
                                  LoggedUserTag
                                )
                        VALUES  ( @TagID , -- TagID - bigint
                                  @TagName , -- TagName - varchar(50)
                                  @TaggedBy , -- TaggedBy - bigint
                                  CASE WHEN @Vote = 0 THEN 1
                                       ELSE @Vote
                                  END ,
                                  @LoggedUserTag
                                )
                    END
            END
    
        SELECT  TagID ,
                TagName ,
                [Count] ,
                LoggedUserTag
        FROM    @ReturnTable;

    END
GO
