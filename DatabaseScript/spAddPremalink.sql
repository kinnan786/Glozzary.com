/****** Object:  StoredProcedure [tallal78_8].[spAddPremalink]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spAddPremalink]
GO
/****** Object:  StoredProcedure [tallal78_8].[spAddPremalink]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tallal78_8].[spAddPremalink]
    @Description VARCHAR(MAX) = '' ,
    @Link VARCHAR(MAX) ,
    @Image VARCHAR(MAX) = '' ,
    @Title VARCHAR(MAX) = '' ,
    @Keywords VARCHAR(MAX) = '' ,
    @Published_time DATETIME = GETDATE ,
    @WebSiteName VARCHAR(MAX) ,
    @WebSiteURL VARCHAR(MAX) = '' ,
    @ALLMetachars_Link VARCHAR(MAX) = ''
AS
    BEGIN

        DECLARE @returnvalue INT = 0
        DECLARE @Id INT = 0

        SELECT  @Id = ISNULL(w.Id, 0) ,
                @WebSiteName = ISNULL(w.Name, @WebSiteName)
        FROM    Website w
                INNER JOIN Premalink p ON w.Id = p.Website_Id
        WHERE   p.Link = @Link 

        IF NOT EXISTS ( SELECT  *
                        FROM    Premalink
                        WHERE   Link = @Link )
            BEGIN
                INSERT  INTO [Premalink]
                        ( [Link] ,
                          [Website_Id] ,
                          [MetaTagCheck] ,
                          [Title] ,
                          [Keywords] ,
                          [Site_name] ,
                          [Description] ,
                          [Image] ,
                          [CreatedOn] ,
                          [AllMetchars_Link]
                        )
                VALUES  ( @Link ,
                          @Id ,
                          0 ,
                          @Title ,
                          @Keywords ,
                          @WebSiteName ,
                          @Description ,
                          @Image ,
                          @Published_time ,
                          @ALLMetachars_Link
                        )
                SET @returnvalue = SCOPE_IDENTITY()
            END
        ELSE
            BEGIN
                UPDATE  [Premalink]
                SET     [Link] = @Link ,
                        [Website_Id] = @Id ,
                        [MetaTagCheck] = 0 ,
                        [Title] = @Title ,
                        [Site_name] = @WebSiteName ,
                        [Description] = @Description ,
                        [Image] = @Image ,
                        [Published_time] = @Published_time ,
                        [Keywords] = @Keywords ,
                        [CreatedOn] = GETDATE() ,
                        [AllMetchars_Link] = @ALLMetachars_Link
                WHERE   Id = ( SELECT   Id
                               FROM     Premalink
                               WHERE    Link = @Link
                             )
                SET @returnvalue = @Id
  
            END

        SELECT  @returnvalue
    END
GO
