/****** Object:  StoredProcedure [tallal78_8].[spAddMetaCharTags]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spAddMetaCharTags]
GO
/****** Object:  StoredProcedure [tallal78_8].[spAddMetaCharTags]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spAddMetaCharTags] --21,'',''
    @PremalinkId BIGINT ,
    @SiteName VARCHAR(MAX) = '' ,
    @Author VARCHAR(MAX) = ''
AS
    BEGIN
        DECLARE @Str VARCHAR(MAX)

        IF EXISTS ( SELECT  *
                    FROM    Premalink
                    WHERE   id = @PremalinkId )
            BEGIN

                SELECT  @str = Keywords
                FROM    Premalink
                WHERE   id = @PremalinkId

                CREATE TABLE #TempTable
                    (
                      Id INT ,
                      TagName VARCHAR(50)
                    )

                INSERT  INTO #TempTable
                        ( Id ,
                          TagName
                        )
                        SELECT  ROW_NUMBER() OVER ( ORDER BY Splitdata ) AS Id ,
                                REPLACE(tallal78_8.fun_InitCap(RTRIM(LTRIM(Splitdata))),
                                        '-', ' ') AS TagName
                        FROM    tallal78_8.fun_SplitString(@str, ',')

                DECLARE @thisid INT = 0

                IF @Author <> ''
                    BEGIN
                        
                        SELECT  @thisid = COUNT(*)
                        FROM    #TempTable

                        INSERT  INTO #TempTable
                                ( Id, TagName )
                        VALUES  ( @thisid + 1, @Author )
                    END

                IF @SiteName <> ''
                    BEGIN
                        SET @thisid = 0

                        SELECT  @thisid = COUNT(*)
                        FROM    #TempTable

                        INSERT  INTO #TempTable
                                ( Id, TagName )
                        VALUES  ( @thisid + 1, @SiteName )
                    END

                DECLARE @TagId BIGINT = 0
                DECLARE @Count INT = 0
                DECLARE @index INT = 0

                SELECT  @Count = ISNULL(COUNT(*), 0)
                FROM    #TempTable
						
                WHILE @index < @Count
                    BEGIN
                
                        SET @index += 1
                        
                        IF EXISTS ( SELECT  *
                                    FROM    Tag
                                    WHERE   Name = ( SELECT TagName
                                                     FROM   #TempTable
                                                     WHERE  Id = @index
                                                   ) )
                            BEGIN
                                
                                SELECT  @TagId = Id
                                FROM    Tag
                                WHERE   Name = ( SELECT TagName
                                                 FROM   #TempTable
                                                 WHERE  Id = @index
                                               )

                            END
                        ELSE
                            BEGIN
                                
                                INSERT  INTO Tag
                                        ( Name ,
                                          Date
                                        )
                                        SELECT  TagName ,
                                                GETDATE()
                                        FROM    #TempTable
                                        WHERE   Id = @index


                                SELECT  @TagId = SCOPE_IDENTITY()
										
                            END

                        IF NOT EXISTS ( SELECT  *
                                        FROM    PremalinkTags
                                        WHERE   Premalink_Id = @PremalinkId
                                                AND Tag_Id = @TagId )
                            BEGIN
				 
                                DECLARE @PremalinkTagId BIGINT = 0

                                INSERT  INTO PremalinkTags
                                        ( Premalink_Id, Tag_Id, Date )
                                VALUES  ( @PremalinkId, @TagId, GETDATE() )

                                SELECT  @PremalinkTagId = SCOPE_IDENTITY()

                                INSERT  INTO PremalinkTag_User
                                        ( UserId ,
                                          UpVote ,
                                          DownVote ,
                                          PremalinkTagId ,
                                          Date		
                                        )
                                VALUES  ( 21 ,
                                          1 ,
                                          0 ,
                                          @PremalinkTagId ,
                                          GETDATE()
                                        )
                            END
                    END
            END
    END
GO
