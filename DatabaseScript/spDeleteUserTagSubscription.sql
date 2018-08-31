/****** Object:  StoredProcedure [tallal78_8].[spDeleteUserTagSubscription]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spDeleteUserTagSubscription]
GO
/****** Object:  StoredProcedure [tallal78_8].[spDeleteUserTagSubscription]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [tallal78_8].[spDeleteUserTagSubscription] @TagID INT, @UserID INT
AS
    BEGIN

        DELETE  FROM [User_Tag_Follow]
        WHERE   UserId = @UserID
                AND TagId = @TagID

    END
GO
