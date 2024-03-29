/****** Object:  StoredProcedure [dbo].[spAssociateTag]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [dbo].[spAssociateTag]
GO
/****** Object:  StoredProcedure [dbo].[spAssociateTag]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spAssociateTag] 
	 @TagId int
	,@Link VARCHAR(MAX)
	,@WebsiteName VARCHAR(MAX)
	,@TagType VARCHAR(50)
AS
BEGIN TRY
	DECLARE @WebsiteID INT = 0
	DECLARE @PremalinkID INT = 0
	DECLARE @TagIDs INT = 0
	DECLARE	@TagtypeId INT = 0

	SELECT @TagtypeId = isnull(Id, 0)
	FROM TagType
	WHERE [Type] = @TagType

	SELECT @WebsiteID = isnull(Id, 0)
	FROM Website
	WHERE NAME = @WebsiteName

	SELECT @PremalinkID = isnull(Id, 0)
	FROM premalink
	WHERE Link = @Link

	SELECT @TagIDs = isnull(Id, 0)
	FROM Tag
	WHERE Id = @TagId

	IF @WebsiteID = 0
		SELECT 0;		
	ELSE IF @TagIDs = 0
		SELECT 0;
	ELSE IF @PremalinkID = 0
	BEGIN
		INSERT INTO [Premalink] (
			[Link]
			,[Website_Id]
			)
		VALUES (
			@Link
			,@WebsiteId
			)

		SET @PremalinkID = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN

		INSERT INTO [PremalinkTags] (
			[Premalink_Id]
			,[Tag_Id]
			,[TagTypeId]
			)
		VALUES (
			@PremalinkID
			,@TagIDs
			,@TagtypeId
			)
	END
	SELECT 1;
END TRY
BEGIN CATCH
	SELECT 0;
END CATCH


GO
