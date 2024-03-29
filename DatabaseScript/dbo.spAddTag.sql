/****** Object:  StoredProcedure [dbo].[spAddTag]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [dbo].[spAddTag]
GO
/****** Object:  StoredProcedure [dbo].[spAddTag]    Script Date: 10/13/2014 10:18:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spAddTag]
    @TagName VARCHAR(MAX) ,
    @UserId BIGINT ,
    @Link VARCHAR(MAX) ,
    @WebsiteName VARCHAR(MAX) = ''
AS
    BEGIN

        DECLARE @WebsiteID BIGINT = 0
        DECLARE @PremalinkID BIGINT = 0
        DECLARE @TagIDs BIGINT = 0
        DECLARE @PremalinkTagId BIGINT = 0

        SELECT  @WebsiteID = Id
        FROM    Website
        WHERE   NAME = @WebsiteName

        IF @WebsiteID = ''
            OR @WebsiteID IS  NULL
            OR @WebsiteID = 0
            SET @WebsiteID = 6
		
        SELECT  @PremalinkID = ISNULL(Id, 0)
        FROM    premalink
        WHERE   Link = @Link

        SELECT  @TagIDs = ISNULL(Id, 0)
        FROM    Tag
        WHERE   Name = @TagName

        IF @TagIDs = 0
            BEGIN
                INSERT  INTO Tag
                        ( Name, Date )
                VALUES  ( @TagName, GETDATE() )

                SET @TagIDs = SCOPE_IDENTITY()
            END


        IF @PremalinkID = 0
            BEGIN
                IF @WebsiteID = ''
                    BEGIN
                        SET @WebsiteID = NULL;
                    END
                
                INSERT  INTO [Premalink]
                        ( [Link] ,
                          [Website_Id] ,
                          [MetaTagCheck] ,
                          CreatedOn
                        )
                VALUES  ( @Link ,
                          @WebsiteID ,
                          0 ,
                          GETDATE()
                        )

                SET @PremalinkID = SCOPE_IDENTITY()
            END

        INSERT  INTO [PremalinkTags]
                ( [Premalink_Id], [Tag_Id], [Date] )
        VALUES  ( @PremalinkID, @TagIDs, GETDATE() )

        SET @PremalinkTagId = SCOPE_IDENTITY()

        INSERT  INTO [PremalinkTag_User]
                ( [UserId] ,
                  [UpVote] ,
                  [DownVote] ,
                  [PremalinkTagId] ,
                  [Date]
                )
        VALUES  ( @userID ,
                  1 ,
                  0 ,
                  @PremalinkTagId ,
                  GETDATE()
                )

    END

GO
