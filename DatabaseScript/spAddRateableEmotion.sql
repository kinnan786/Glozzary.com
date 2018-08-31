ALTER PROCEDURE spAddRateableEmotion --spAddRateableEmotion 'Test',2,'|Like,1,0,1|Love,2,0,1|lovely,4,0,1|Testing,0,0,1',21
	@GroupName VARCHAR(50) = '' ,
    @EmotionGroupId BIGINT = 0 ,
    @Emotion VARCHAR(MAX) = '' ,
    @UserId INT = 0
AS 
    BEGIN
        
        DECLARE @WebsiteId BIGINT = 0
        DECLARE @Count INT = 0
        DECLARE @Id VARCHAR(MAX) = ''
        DECLARE @Temp VARCHAR(50) = ''
        DECLARE @EmotionId BIGINT = 0
        DECLARE @EmotionName VARCHAR(50) = ''

        IF @UserId <> 0 
            BEGIN

                SELECT  @WebsiteId = Id
                FROM    Website
                WHERE   UserId = @UserId

                IF NOT EXISTS ( SELECT  Id
                                FROM    EmotionGroup
                                WHERE   GroupName = @GroupName
                                        AND @WebsiteId = @WebsiteId ) 
                    BEGIN
            
                        INSERT  INTO [EmotionGroup]
                                ( [GroupName], [WebsiteId] )
                        VALUES  ( @GroupName, @WebsiteId )
   
                        SET @EmotionGroupId = SCOPE_IDENTITY()
            
                    END
                ELSE 
                    BEGIN
     
                        UPDATE  [EmotionGroup]
                        SET     [GroupName] = @GroupName
                        WHERE   Id = @EmotionGroupId
   
                    END

                SELECT  @Count = ROW_NUMBER() OVER ( ORDER BY splitdata DESC )
                FROM    fun_SplitString(@Emotion, '|')

                WHILE ( @Count > 0 ) 
                    BEGIN

                        SET @Temp = ''
                        SET @EmotionId = 0
                        SET @EmotionName = ''
						;WITH    Result
                                  AS ( SELECT   splitdata ,
                                                ROW_NUMBER() OVER ( ORDER BY splitdata DESC ) AS RowNumber
                                       FROM     fun_SplitString(@Emotion, '|')
                                     )
                            SELECT  @Temp = splitdata
                            FROM    Result
                            WHERE   RowNumber = @Count

                        IF @Temp <> '' 
                            BEGIN
       
       ;
                                WITH    Resulta
                                          AS ( SELECT   splitdata ,
                                                        ROW_NUMBER() OVER ( ORDER BY splitdata DESC ) AS RowNumber
                                               FROM     fun_SplitString(@Temp,
                                                              ',')
                                             )
                                    SELECT  @EmotionName = splitdata
                                    FROM    Resulta
                                    WHERE   RowNumber = 1;
                                    WITH    Resultb
                                              AS ( SELECT   splitdata ,
                                                            ROW_NUMBER() OVER ( ORDER BY splitdata DESC ) AS RowNumber
                                                   FROM     fun_SplitString(@Temp,
                                                              ',')
                                                 )
                                    SELECT  @EmotionId = splitdata
                                    FROM    Resultb
                                    WHERE   RowNumber = 2   
   
            
                                IF EXISTS ( SELECT  id
                                            FROM    Emotions
                                            WHERE   id = @EmotionId ) 
                                    BEGIN
    
                                        IF NOT EXISTS ( SELECT
                                                              id
                                                        FROM  EmotionGroup_Emotion
                                                        WHERE EmotionGroupId = @EmotionGroupId
                                                              AND EmotionId = @EmotionId ) 
                                            BEGIN
                                                INSERT  INTO EmotionGroup_Emotion
                                                        ( EmotionGroupId,
                                                          EmotionId )
                                                VALUES  ( @EmotionGroupId,
                                                          @EmotionId )
                                            END
       
                                    END
                                ELSE 
                                    BEGIN

                                        INSERT  INTO Emotions
                                                ( Name )
                                        VALUES  ( @EmotionName )
                    
                                        SET @EmotionId = SCOPE_IDENTITY()

                                        INSERT  INTO EmotionGroup_Emotion
                                                ( EmotionGroupId, EmotionId )
                                        VALUES  ( @EmotionGroupId, @EmotionId )
       
                                    END
  
                                SET @Id += CAST(@EmotionId AS VARCHAR) + ','
                            END
                        SET @Count -= 1
                    END

                DELETE  FROM EmotionGroup_Emotion
                WHERE   EmotionGroupId = 2
                        AND EmotionId NOT IN (
                        SELECT  Number
                        FROM    fnu_Split_Numbers_to_Tbl(@Id) )
            
            END
        SELECT  @EmotionGroupId
    END