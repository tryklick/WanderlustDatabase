-- Create AddSightseeing stored procedure
CREATE OR ALTER PROCEDURE AddSightseeing
    @SightseeingId INT,
    @DestinationId INT,
    @Name VARCHAR(50),
    @Description VARCHAR(255)
AS
BEGIN
    INSERT INTO Sightseeing (SightseeingId ,DestinationId, Name, Description)
    VALUES (@SightseeingId,@DestinationId, @Name, @Description);
END;
GO

BEGIN TRANSACTION
-- Kör AddSightseeing-proceduren
SELECT * FROM dbo.Sightseeing
EXEC AddSightseeing @SightseeingId = 11 ,@DestinationId = 5, @Name = 'Royal Palace', @Description = 'Historic royal residence';
SELECT * FROM dbo.Sightseeing
ROLLBACK

-- Create AddComment stored procedure
CREATE OR ALTER  PROCEDURE AddComment
    @CommentId INT, 
    @SightseeingId INT,
    @UserId INT,
    @Comment VARCHAR(255)
AS
BEGIN
    INSERT INTO Comment ( CommentId, SightseeingId, UserId, Comment)
    VALUES (@CommentId, @SightseeingId, @UserId, @Comment);
END;
GO

BEGIN TRANSACTION
-- Kör AddComment-proceduren 
SELECT * FROM dbo.Comment
EXEC AddComment @CommentId= 61 , @Comment = 'VERI VERI NICE' , @SightseeingId = 10, @UserId  = 4 ;
SELECT * FROM dbo.Comment
ROLLBACK



-- Create AddRating stored procedure
CREATE OR ALTER PROCEDURE AddRating
    @RatingValue DECIMAL(3, 1),
    @CommentId INT
AS
BEGIN
    UPDATE Comment
    SET RatingValue = @RatingValue
    WHERE CommentId = @CommentId
END;
GO
 
BEGIN TRANSACTION
-- Kör AddRating-proceduren
SELECT * FROM dbo.Comment
EXEC AddRating @CommentId = 60 , @RatingValue = 3 ;
SELECT * FROM dbo.Comment
ROLLBACK



-- Create AddUser stored procedure
CREATE OR ALTER PROCEDURE AddUser
     @UserId INT, 
    @Username VARCHAR(50),
    @Password VARCHAR(50),
    @Email VARCHAR(100)
AS
BEGIN
    INSERT INTO [User] (UserId, Username, Password, Email)
    VALUES ( @UserId , @Username, @Password, @Email);
END;
GO

BEGIN TRANSACTION
-- Kör AddUser-proceduren
SELECT * FROM dbo.[User]
EXEC AddUser  @UserId = 6 , @Username = 'Daniella' , @Password = 'password123' , @Email = 'Daniella.bwedne@gmail.com' ;
SELECT * FROM dbo.[User]
ROLLBACK


    --DROP PROCEDURE IF EXISTS AddSightseeing;
    --DROP PROCEDURE IF EXISTS AddComment;
   -- DROP PROCEDURE IF EXISTS AddRating;
   -- DROP PROCEDURE IF EXISTS AddUser;
