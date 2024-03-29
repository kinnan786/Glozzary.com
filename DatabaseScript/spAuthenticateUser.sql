ALTER PROCEDURE [spAuthenticateUser]
    @Email VARCHAR(MAX) ,
    @Password VARCHAR(MAX) ,
    @IsUser BIT
AS 
    BEGIN
        DECLARE @returnvalue INT = 0

        IF EXISTS ( SELECT  *
                    FROM    [User]
                    WHERE   Email = @Email
                            AND Password = @Password
                            AND isUser = @IsUser ) 
            BEGIN
                IF EXISTS ( SELECT  *
                            FROM    [User]
                            WHERE   Email = @Email
                                    AND EmailVerified = 1 ) 
                    SELECT  @returnvalue = id
                    FROM    [user]
                    WHERE   Email = @Email
                            AND [Password] = @Password
                            AND EmailVerified = 1
                ELSE 
                    SET @returnvalue = -2     
            END
        ELSE 
            SET @returnvalue = -1 

        SELECT  @returnvalue
    END
GO