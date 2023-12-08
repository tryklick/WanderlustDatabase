-- Skapa databasen
--CREATE DATABASE Reseapplikation;
--GO

-- Använd databasen
USE Reseapplikation;
GO

-- Skapa tabellen Destination
CREATE TABLE Destination (
  DestinationId INT PRIMARY KEY,
  City VARCHAR(50),
  Country VARCHAR(50),
);

-- Lägg till destinationer
INSERT INTO Destination (DestinationId, City, Country)
VALUES
    (1, 'Stockholm', 'Sweden'),
    (2, 'Oslo', 'Norway'),
    (3, 'Helsinki', 'Finland'),
    (4, 'Copenhagen', 'Denmark'),
    (5, 'Reykjavik', 'Iceland');
GO

-- Skapa tabellen Sightseeing
CREATE TABLE Sightseeing (
    SightseeingId INT PRIMARY KEY,
    DestinationId INT,
    Name VARCHAR(50),
    Description VARCHAR(255),
    FOREIGN KEY (DestinationId) REFERENCES Destination(DestinationId)
);
GO

-- Lägg till sevärdheter
INSERT INTO Sightseeing (SightseeingId, DestinationId, Name, Description)
VALUES
    (1, 1, 'Gamla Stan', 'Historic city center'),
    (2, 1, 'Vasa Museum', 'Museum with a 17th-century ship'),
    (3, 2, 'Vigeland Park', 'Sculpture park'),
    (4, 2, 'Holmenkollen', 'Ski jump and museum'),
    (5, 3, 'Helsinki Cathedral', 'Iconic Lutheran cathedral'),
    (6, 3, 'Suomenlinna', 'Sea fortress'),
    (7, 4, 'Tivoli Gardens', 'Amusement park'),
    (8, 4, 'Nyhavn', 'Colorful waterfront district'),
    (9, 5, 'Blue Lagoon', 'Geothermal spa'),
    (10, 5, 'Golden Circle', 'Tourist route with natural wonders');
GO

-- Skapa tabellen [User]
CREATE TABLE [User] (
  UserId INT PRIMARY KEY,
  Username VARCHAR(50),
  Password VARCHAR(50),
  Email VARCHAR(100),
);

-- Lägg till användare
INSERT INTO [User] (UserId, Username, Password, Email)
VALUES
    (1, 'JohnDoe', 'password1', 'john.doe@example.com'),
    (2, 'JaneSmith', 'password2', 'jane.smith@example.com'),
    (3, 'MikeJohnson', 'password3', 'mike.johnson@example.com'),
    (4, 'EmilyBrown', 'password4', 'emily.brown@example.com'),
    (5, 'DavidWilson', 'password5', 'david.wilson@example.com');


-- Skapa tabellen Comment
CREATE TABLE Comment (
    CommentId INT PRIMARY KEY,
    SightseeingId INT,
    UserId INT,
    Comment VARCHAR(255),
    RatingValue DECIMAL(5, 1),
    FOREIGN KEY (SightseeingId) REFERENCES Sightseeing(SightseeingId),
    FOREIGN KEY (UserId) REFERENCES [User](UserId)
);

-- Lägg till kommentarer med betyg
INSERT INTO Comment (CommentId, SightseeingId, UserId, Comment, RatingValue)
VALUES
    -- SightseeingId 1
    (6, 1, 4, 'Loved the charming alleys', 4.5),
    (7, 1, 5, 'A true gem in the city', 4.5),

    -- SightseeingId 2
    (8, 2, 1, 'The Vasa ship is amazing', 5),
    (9, 2, 3, 'I learned a lot about Swedish history', 4),

    -- SightseeingId 3
    (10, 3, 2, 'The sculptures are so creative', 4),
    (11, 3, 4, 'I could spend hours here', 4),

    -- SightseeingId 4
    (12, 4, 3, 'What a thrilling experience', 4),
    (13, 4, 5, 'The museum is very informative', 4),

    -- SightseeingId 5
    (14, 5, 1, 'The view is breathtaking', 2),
    (15, 5, 2, 'I was scared at first, but it was so worth it', 5);

-- Lägg till kommentarer utan betyg
INSERT INTO Comment (CommentId, SightseeingId, UserId, Comment)
VALUES
    -- SightseeingId 1
    (46, 1, 3, 'The alleys are so picturesque'),
    (47, 1, 4, 'Charming atmosphere in the city'),
    (48, 1, 5, 'Great local shops to explore'),

    -- SightseeingId 2
    (49, 2, 2, 'Impressive historical ship'),
    (50, 2, 3, 'A must-visit for history enthusiasts'),
    (51, 2, 5, 'The Vasa ship tells a fascinating story'),

    -- SightseeingId 3
    (52, 3, 1, 'Artistic sculptures all around'),
    (53, 3, 4, 'Perfect spot for photography'),
    (54, 3, 5, 'Unique and creative artworks'),

    -- SightseeingId 4
    (55, 4, 2, 'Thrilling adventure at great heights'),
    (56, 4, 3, 'Breathtaking views from the top'),
    (57, 4, 4, 'An adrenaline rush like no other'),

    -- SightseeingId 5
    (58, 5, 1, 'Unforgettable panoramic view'),
    (59, 5, 3, 'Worth the hike for the stunning scenery'),
    (60, 5, 5, 'Nature at its finest');
    DROP TABLE dbo.Rating

-- Skapa index på Sightseeing-tabellen
CREATE INDEX IX_Sightseeing_DestinationId ON Sightseeing (DestinationId);
GO

-- Skapa index på Rating-tabellen
CREATE INDEX IX_Rating_SightseeingId ON Rating (SightseeingId);
CREATE INDEX IX_Rating_UserId ON Rating (UserId);


--DROP DATABASE IF EXISTS Reseapplikation;
