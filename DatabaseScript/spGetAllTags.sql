/****** Object:  StoredProcedure [tallal78_8].[spGetAllTags]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spGetAllTags]
GO
/****** Object:  StoredProcedure [tallal78_8].[spGetAllTags]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spGetAllTags]
    @TagName VARCHAR(MAX) = '' ,
    @UserID BIGINT ,
    @PageNo INT ,
    @PageSize INT ,
    @Flow VARCHAR(MAX) = ''
AS
    BEGIN

        IF @Flow = 'search'
            BEGIN
                DECLARE @SearchTag VARCHAR(MAX)
				
                IF ISNULL(@TagName, '') <> ''
                    AND @TagName <> ''
                    BEGIN
                        SET @SearchTag = '%' + @TagName + '%'
					
                        SELECT  t.[Id] AS TagId ,
                                t.[Name] AS TagName ,
                                0 AS TotalPage ,
                                ISNULL(( SELECT TOP 1
                                                UTF.UserId
                                         FROM   User_Tag_Follow UTF
                                         WHERE  UTF.UserId = @UserID
                                                AND UTF.TagId = t.id
                                       ), 0) AS UserId ,
                                ( SELECT    COUNT(*)
                                  FROM      User_Tag_Follow
                                  WHERE     UserId = @UserID
                                ) AS userFollow
                        FROM    [Tag] t
                        WHERE   t.Name LIKE @SearchTag
                        ORDER BY t.id DESC
                                OFFSET ( @PageNo - 1 ) * @PageSize ROWS
				FETCH NEXT @PageSize ROWS ONLY
		
                    END
                ELSE
                    BEGIN
	
                        SET @SearchTag = '%' + @TagName + '%'
                
                        SELECT  t.[Id] AS TagId ,
                                t.[Name] AS TagName ,
                                0 AS TotalPage ,
                                ISNULL(( SELECT TOP 1
                                                UTF.UserId
                                         FROM   User_Tag_Follow UTF
                                         WHERE  UTF.UserId = @UserID
                                                AND UTF.TagId = t.id
                                       ), 0) AS UserId ,
                                ( SELECT    COUNT(*)
                                  FROM      User_Tag_Follow
                                  WHERE     UserId = @UserID
                                ) AS userFollow
                        FROM    [Tag] t
                        WHERE   t.Name LIKE @SearchTag
                        ORDER BY t.id DESC
                                OFFSET ( @PageNo - 1 ) * @PageSize ROWS
				FETCH NEXT @PageSize ROWS ONLY
	
                    END
            END
        ELSE
            BEGIN
            
                SELECT  t.[Id] AS TagId ,
                        t.[Name] AS TagName ,
                        0 AS TotalPage ,
                        @UserID AS UserId ,
                        ( SELECT    COUNT(*)
                          FROM      User_Tag_Follow
                          WHERE     UserId = @UserID
                        ) AS userFollow
                FROM    [Tag] t
                        INNER JOIN User_Tag_Follow UTF ON t.id = UTF.TagId
                WHERE   utf.UserId = @UserID
                ORDER BY t.id DESC
                        OFFSET ( @PageNo - 1 ) * @PageSize ROWS
				FETCH NEXT @PageSize ROWS ONLY
	
            END
    END

GO
