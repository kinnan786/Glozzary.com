/****** Object:  StoredProcedure [tallal78_8].[spDeleteUserImage]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spDeleteUserImage]
GO
/****** Object:  StoredProcedure [tallal78_8].[spDeleteUserImage]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spDeleteUserImage] @UserID BIGINT
AS
    BEGIN

        UPDATE  [USER]
        SET     ProfileImage = ''
        WHERE   Id = @UserID

        SELECT  1
    END
GO
