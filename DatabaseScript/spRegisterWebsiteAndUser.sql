ALTER PROCEDURE spRegisterWebsiteAndUser
    @WebSiteName VARCHAR(MAX) ,
    @WebsiteURL VARCHAR(MAX) ,
    @Email VARCHAR(MAX) ,
    @Password VARCHAR(MAX) ,
    @VerificationCode VARCHAR(MAX) ,
    @isUser BIT
AS
    BEGIN

        DECLARE @UserId INT = 0
        DECLARE @return BIGINT
        SET @return = 0

        IF NOT EXISTS ( SELECT  *
                        FROM    [User]
                        WHERE   Email = @Email )
            BEGIN
                IF EXISTS ( SELECT  *
                            FROM    Website
                            WHERE   URL = @WebsiteURL )
                    SET @return = -1 -- website url already exists
                ELSE
                    IF EXISTS ( SELECT  *
                                FROM    Website
                                WHERE   Name = @WebSiteName )
                        SET @return = -2 -- website name already exists
         
                IF ( @return = 0 )
                    BEGIN

                        INSERT  INTO [User]
                                ( [Email] ,
                                  [Password] ,
                                  [VerificationCode] ,
                                  EmailVerified ,
                                  isUser
                                )
                        VALUES  ( @Email ,
                                  @Password ,
                                  @VerificationCode ,
                                  0 ,
                                  @isUser
                                )

                        SET @UserId = SCOPE_IDENTITY()
      
                        INSERT  INTO [Website]
                                ( [Name] ,
                                  [URL] ,
                                  [UserId]
                                )
                        VALUES  ( @WebSiteName ,
                                  @WebsiteURL ,
                                  @UserId
                                )

                        SET @return = SCOPE_IDENTITY()
                    END
                ELSE
                    BEGIN
                        SET @return = -3 --user already exists
                    END

                SELECT  @return
            END
    END