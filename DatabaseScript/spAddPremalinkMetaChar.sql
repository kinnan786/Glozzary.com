/****** Object:  StoredProcedure [tallal78_8].[spAddPremalinkMetaChar]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spAddPremalinkMetaChar]
GO
/****** Object:  StoredProcedure [tallal78_8].[spAddPremalinkMetaChar]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spAddPremalinkMetaChar]
    @description VARCHAR(MAX) = '' ,
    @url VARCHAR(MAX) = '' ,
    @image VARCHAR(MAX) = '' ,
    @title VARCHAR(MAX) = '' ,
    @keywords VARCHAR(MAX) = '' ,
    @site_name VARCHAR(MAX) = '' ,
    @published_time VARCHAR(MAX) = '' ,
    @emotion VARCHAR(MAX) = '' ,
    @type VARCHAR(MAX) = '' ,
    @pricecurrency VARCHAR(MAX) = '' ,
    @availability VARCHAR(MAX) = '' ,
    @priceamount VARCHAR(MAX) = '' ,
    @rating VARCHAR(MAX) = '' ,
    @gender VARCHAR(MAX) = '' ,
    @pricestartdate VARCHAR(MAX) = '' ,
    @priceenddate VARCHAR(MAX) = '' ,
    @ingredients VARCHAR(MAX) = '' ,
    @avilabilitydestinations VARCHAR(MAX) = '' ,
    @cooktime VARCHAR(MAX) = '' ,
    @preptime VARCHAR(MAX) = '' ,
    @totaltime VARCHAR(MAX) = '' ,
    @recipeyield VARCHAR(MAX) = '' ,
    @aggregaterating VARCHAR(MAX) = '' ,
    @duration VARCHAR(MAX) = '' ,
    @genre VARCHAR(MAX) = '' ,
    @actor VARCHAR(MAX) = '' ,
    @director VARCHAR(MAX) = '' ,
    @contentrating VARCHAR(MAX) = '' ,
    @author VARCHAR(MAX) = '' ,
    @section VARCHAR(MAX) = '' ,
    @locationlatitude VARCHAR(MAX) = '' ,
    @locationlongitude VARCHAR(MAX) = '' ,
    @street_address VARCHAR(MAX) = '' ,
    @locality VARCHAR(MAX) = '' ,
    @region VARCHAR(MAX) = '' ,
    @postal_code VARCHAR(MAX) = '' ,
    @brand VARCHAR(MAX) = '' ,
    @AllMetachar_Link VARCHAR(MAX) = '' ,
    @WebsiteUrl VARCHAR(MAX) = '' ,
    @WebsiteLogo VARCHAR(MAX)
AS
    BEGIN

        DECLARE @Premalinkid BIGINT = 0
        DECLARE @Websiteid BIGINT = 0
        DECLARE @return BIGINT= 0

        IF @published_time <> ''
            SET @published_time = GETDATE()

        SELECT  @Websiteid = ISNULL(Id, 0)
        FROM    Website
        WHERE   Name = @site_name
                OR URL = @WebsiteUrl

        SELECT  @Premalinkid = ISNULL(Id, 0)
        FROM    Premalink
        WHERE   Link = @url
        

        IF NOT EXISTS ( SELECT  *
                        FROM    Website
                        WHERE   Name = @site_name
                                OR URL = @WebsiteUrl )
            BEGIN
		
                INSERT  INTO [Website]
                        ( [Name] ,
                          [URL] ,
                          [Description] ,
                          [UserId] ,
                          [Type] ,
                          [AddTag] ,
                          [RateTag] ,
                          [AddEmotion] ,
                          [Tag] ,
                          [Emotion] ,
                          [Image]
                        )
                VALUES  ( @site_name ,
                          @WebsiteUrl ,
                          'Added Through Parser.' ,
                          1 ,
                          2 ,
                          1 ,
                          1 ,
                          1 ,
                          1 ,
                          1 ,
                          @WebsiteLogo
                        )

                SET @Websiteid = SCOPE_IDENTITY()

            END


        IF NOT EXISTS ( SELECT  *
                        FROM    Premalink
                        WHERE   Link = @url )
            BEGIN

                INSERT  INTO [Premalink]
                        ( [Link] ,
                          [Website_Id] ,
                          [Title] ,
                          [Site_name] ,
                          [Description] ,
                          [Image] ,
                          [Published_time] ,
                          [Keywords] ,
                          [Type] ,
                          [CreatedOn] ,
                          [Emotions] ,
                          [MetaTagCheck] ,
                          [AllMetchars_Link]
                        )
                VALUES  ( @url ,
                          @Websiteid ,
                          @title ,
                          @Site_name ,
                          @Description ,
                          @Image ,
                          @Published_time ,
                          @Keywords ,
                          @Type ,
                          GETDATE() ,
                          @Emotion ,
                          1 ,
                          @AllMetachar_Link
                        )

                SELECT  @Premalinkid = SCOPE_IDENTITY()

                SET @return = @Premalinkid

            END
        ELSE
            BEGIN

                IF EXISTS ( SELECT  *
                            FROM    Premalink
                            WHERE   Link = @url
                                    AND Id = @Premalinkid
                                    AND Website_Id = 2 )
                    BEGIN
                        UPDATE  Premalink
                        SET     Website_Id = @Websiteid
                        WHERE   Link = @url
                                AND Id = @Premalinkid
                                AND Website_Id = 2
                    END

                UPDATE  [Premalink]
                SET     [Title] = CASE WHEN ( SELECT    ISNULL(Title, '')
                                              FROM      Premalink
                                              WHERE     id = @Premalinkid
                                            ) = '' THEN @title
                                       ELSE ( SELECT    Title
                                              FROM      Premalink
                                              WHERE     id = @Premalinkid
                                            )
                                  END ,
                        [Site_name] = CASE WHEN ( SELECT    ISNULL(Site_name,
                                                              '')
                                                  FROM      Premalink
                                                  WHERE     id = @Premalinkid
                                                ) = '' THEN @site_name
                                           ELSE ( SELECT    Site_name
                                                  FROM      Premalink
                                                  WHERE     id = @Premalinkid
                                                )
                                      END ,
                        [Description] = CASE WHEN ( SELECT  ISNULL([Description],
                                                              '')
                                                    FROM    Premalink
                                                    WHERE   id = @Premalinkid
                                                  ) = '' THEN @description
                                             ELSE ( SELECT  Description
                                                    FROM    Premalink
                                                    WHERE   id = @Premalinkid
                                                  )
                                        END ,
                        [Image] = CASE WHEN ( SELECT    ISNULL(Image, '')
                                              FROM      Premalink
                                              WHERE     id = @Premalinkid
                                            ) = '' THEN @image
                                       ELSE ( SELECT    Image
                                              FROM      Premalink
                                              WHERE     id = @Premalinkid
                                            )
                                  END ,
                        [Published_time] = CASE WHEN ( SELECT ISNULL(Published_time,
                                                              '')
                                                       FROM   Premalink
                                                       WHERE  id = @Premalinkid
                                                     ) = ''
                                                THEN @Published_time
                                                ELSE ( SELECT Published_time
                                                       FROM   Premalink
                                                       WHERE  id = @Premalinkid
                                                     )
                                           END ,
                        [Keywords] = CASE WHEN ( SELECT ISNULL(Keywords, '')
                                                 FROM   Premalink
                                                 WHERE  id = @Premalinkid
                                               ) = '' THEN @Keywords
                                          ELSE ( SELECT Keywords
                                                 FROM   Premalink
                                                 WHERE  id = @Premalinkid
                                               )
                                     END ,
                        [Type] = CASE WHEN ( SELECT ISNULL([Type], '')
                                             FROM   Premalink
                                             WHERE  id = @Premalinkid
                                           ) = '' THEN @Type
                                      ELSE ( SELECT Type
                                             FROM   Premalink
                                             WHERE  id = @Premalinkid
                                           )
                                 END ,
                        [Emotions] = CASE WHEN ( SELECT ISNULL(Emotions, '')
                                                 FROM   Premalink
                                                 WHERE  id = @Premalinkid
                                               ) = '' THEN @Emotion
                                          ELSE ( SELECT Emotions
                                                 FROM   Premalink
                                                 WHERE  id = @Premalinkid
                                               )
                                     END ,
                        [AllMetchars_Link] = CASE WHEN ( SELECT
                                                              ISNULL(AllMetchars_Link,
                                                              '')
                                                         FROM Premalink
                                                         WHERE
                                                              id = @Premalinkid
                                                       ) = ''
                                                  THEN @AllMetachar_Link
                                                  ELSE ( SELECT
                                                              AllMetchars_Link
                                                         FROM Premalink
                                                         WHERE
                                                              id = @Premalinkid
                                                       )
                                             END ,
                        MetaTagCheck = 1
                WHERE   Link = @url
                        AND id = @Premalinkid

				
                IF @keywords <> ''
                    OR @author <> ''
                    OR @site_name <> ''
                    EXEC spAddMetaCharTags @return, @site_name, @author
					
                SET @return = @Premalinkid
            END

        IF LOWER(@type) = 'article'
            BEGIN

                INSERT  INTO [Article]
                        ( [PremalinkId] ,
                          [Published_time] ,
                          [Author] ,
                          [Section]

                        )
                VALUES  ( @Premalinkid ,
                          @published_time ,
                          @author ,
                          @section

                        )
                SET @return = SCOPE_IDENTITY()
            END

        IF LOWER(@type) = 'movie'
            BEGIN

                INSERT  INTO [Movie]
                        ( [PremalinkId] ,
                          [Duration] ,
                          [Genre] ,
                          [Actor] ,
                          [Director] ,
                          [ContentRating] ,
                          [DatePublished] ,
                          [AggregateRating]

                        )
                VALUES  ( @Premalinkid ,
                          @duration ,
                          @Genre ,
                          @Actor ,
                          @Director ,
                          @ContentRating ,
                          @Published_time ,
                          @AggregateRating

                        )

                SET @return = SCOPE_IDENTITY()
            END

        IF LOWER(@type) = 'place'
            BEGIN

                INSERT  INTO [Place]
                        ( [PremalinkId] ,
                          [Location_latitude] ,
                          [Location_longitude] ,
                          [Street_address] ,
                          [Locality] ,
                          [Region] ,
                          [Postal_code]

                        )
                VALUES  ( @PremalinkId ,
                          @locationlatitude ,
                          @locationlongitude ,
                          @Street_address ,
                          @Locality ,
                          @Region ,
                          @Postal_code
                        )
                SET @return = SCOPE_IDENTITY()
            END

        IF LOWER(@type) = 'product'
            BEGIN

                INSERT  INTO [Product]
                        ( [PremalinkId] ,
                          [Price_amount] ,
                          [Price_currency] ,
                          [Availability_destinations] ,
                          [Brand] ,
                          [Gender] ,
                          [Rating] ,
                          [Price_startdate] ,
                          [Price_Enddate]

                        )
                VALUES  ( @PremalinkId ,
                          @Priceamount ,
                          @Pricecurrency ,
                          @avilabilitydestinations ,
                          @brand ,
                          @Gender ,
                          @Rating ,
                          @Pricestartdate ,
                          @PriceEnddate
                        )
                SET @return = SCOPE_IDENTITY()
            END

        IF LOWER(@type) = 'recipe'
            BEGIN

                INSERT  INTO [Recipe]
                        ( [PremalinkId] ,
                          [Ingredients] ,
                          [CookTime] ,
                          [PrepTime] ,
                          [TotalTime] ,
                          [RecipeYield] ,
                          [AggregateRating]

                        )
                VALUES  ( @PremalinkId ,
                          @Ingredients ,
                          @CookTime ,
                          @PrepTime ,
                          @TotalTime ,
                          @RecipeYield ,
                          @AggregateRating
                        )
                SET @return = SCOPE_IDENTITY()
            END
        SELECT  @return
    END
GO
