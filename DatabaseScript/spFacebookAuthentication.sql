/****** Object:  StoredProcedure [tallal78_8].[spFacebookAuthentication]    Script Date: 10/13/2014 10:18:49 PM ******/
DROP PROCEDURE [tallal78_8].[spFacebookAuthentication]
GO
/****** Object:  StoredProcedure [tallal78_8].[spFacebookAuthentication]    Script Date: 10/13/2014 10:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [tallal78_8].[spFacebookAuthentication]
    @Id VARCHAR(MAX) ,
    @Email VARCHAR(MAX) ,
    @VerificationCode VARCHAR(MAX) ,
    @FirstName VARCHAR(50) = '' ,
    @LastName VARCHAR(50) = '' ,
    @ProfileImage VARCHAR(MAX)
AS
    BEGIN

        DECLARE @Returnvalue BIGINT = -1 
        
        IF NOT EXISTS ( SELECT  *
                        FROM    [User]
                        WHERE   Email = @Email
                                AND FaceBookId = @Id )
            BEGIN	
    
                IF EXISTS ( SELECT  *
                            FROM    [User]
                            WHERE   Email = @Email
                                    AND FaceBookId <> @Id )
                    BEGIN
                        SET @Returnvalue = -2 -- Email ASsocitaed to another user
                    END

                IF EXISTS ( SELECT  *
                            FROM    [User]
                            WHERE   Email = @Email
                                    AND FaceBookId = @Id )
                    BEGIN
                        SET @Returnvalue = -3 -- Email Not Verified 
                    END

                IF @Returnvalue = -1
                    BEGIN
                        INSERT  INTO [User]
                                ( [Email] ,
                                  [FaceBookId] ,
                                  FirstName ,
                                  LastName ,
                                  ProfileImage ,
                                  VerificationCode
                                )
                        VALUES  ( @Email ,
                                  @Id ,
                                  @FirstName ,
                                  @LastName ,
                                  @ProfileImage ,
                                  @VerificationCode
                                )
    
                        SET @Returnvalue = 1			-- User Created

                    END
            END

			
        IF EXISTS ( SELECT  *
                    FROM    [User]
                    WHERE   Email = @Email
                            AND FaceBookId = @Id )
            BEGIN
                SELECT  @Returnvalue = Id
                FROM    [User]
                WHERE   Email = @Email
                        AND FaceBookId = @Id
                        AND EmailVerified = 1	-- Succfully Logged in
						
            END 

        SELECT  @Returnvalue
    END


GO
