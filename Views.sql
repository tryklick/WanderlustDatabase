-- Visa en sammanställning av antalet sevärdheter per ort och land
CREATE VIEW View_SightseeingCount
AS
SELECT d.City, d.Country, COUNT(*) AS SightseeingCount
FROM Destination d
INNER JOIN Sightseeing s ON d.DestinationId = s.DestinationId
GROUP BY d.City, d.Country;

-- Exempel: Visa antalet sevärdheter per ort och land
SELECT * FROM View_SightseeingCount;

-- Visa alla sevärdheter på en ort och/eller land och deras medelrating sorterade efter avtagande medelbetyg
CREATE OR ALTER VIEW View_SightseeingRatings
AS
SELECT s.Name, s.Description, d.City, d.Country, AVG(r.RatingValue) AS AverageRating
FROM Sightseeing s
INNER JOIN Destination d ON s.DestinationId = d.DestinationId
LEFT JOIN Comment r ON s.SightseeingId = r.SightseeingId
GROUP BY s.Name, s.Description, d.City, d.Country;

SELECT *
FROM View_SightseeingRatings
ORDER BY AverageRating DESC;

-- Visa alla sevärdheter som inte har någon kommentar och/eller betyg
CREATE OR ALTER VIEW View_SightseeingWithoutCommentRating
AS
SELECT s.Name, s.Description, d.City, d.Country
FROM Sightseeing s
INNER JOIN Destination d ON s.DestinationId = d.DestinationId
LEFT JOIN Comment c ON s.SightseeingId = c.SightseeingId
WHERE c.Comment IS NULL AND c.RatingValue IS NULL;


-- Exempel: Visa sevärdheter utan kommentar och/eller betyg
SELECT * FROM View_SightseeingWithoutCommentRating;


--Visar alla kommentarer till en viss sevärdhet

CREATE VIEW View_SightseeingComments AS
SELECT c.CommentId, s.Name AS SightseeingName, u.Username, c.Comment
FROM Comment c
JOIN Sightseeing s ON c.SightseeingId = s.SightseeingId
JOIN [User] u ON c.UserId = u.UserId;


-- Visa alla kommentarer till en viss sevärdhet
SELECT * FROM View_SightseeingComments WHERE SightseeingName = 'Gamla Stan';

--Visar medelvärdet av alla betyg för en viss sevärdhet
CREATE OR ALTER VIEW View_SightseeingAverageRating AS
SELECT s.SightseeingId, s.Name AS SightseeingName, AVG(r.RatingValue) AS AverageRating
FROM Sightseeing s
LEFT JOIN Comment r ON s.SightseeingId = r.SightseeingId
GROUP BY s.SightseeingId, s.Name;

-- Visa medelvärdet av alla betyg för en viss sevärdhet
SELECT * FROM View_SightseeingAverageRating WHERE SightseeingName = 'Gamla Stan';


--Visar medelvärdet av alla betyg för alla sevärdheter
CREATE OR ALTER VIEW View_AllSightseeingAverageRating AS
SELECT s.SightseeingId, s.Name AS SightseeingName, AVG(r.RatingValue) AS AverageRating
FROM Sightseeing s
LEFT JOIN Comment r ON s.SightseeingId = r.SightseeingId
GROUP BY s.SightseeingId, s.Name;

-- Visa medelvärdet av alla betyg för alla sevärdheter
SELECT * FROM View_AllSightseeingAverageRating;


--Visar medelvärdet av alla betyg för alla sevärdheter på en ort
CREATE OR ALTER VIEW View_SightseeingAverageRatingByCity AS
SELECT d.City, s.SightseeingId, s.Name AS SightseeingName, AVG(r.RatingValue) AS AverageRating
FROM Sightseeing s
JOIN Destination d ON s.DestinationId = d.DestinationId
LEFT JOIN Comment r ON s.SightseeingId = r.SightseeingId
GROUP BY d.City, s.SightseeingId, s.Name;


-- Visa medelvärdet av alla betyg för alla sevärdheter på en ort
SELECT * FROM View_SightseeingAverageRatingByCity WHERE City = 'Stockholm';

--Visar en sammanställning av användare och antal kommentarer och antal betyg en användare har gjort
CREATE  OR ALTER VIEW View_UserCommentAndRatingCount AS
SELECT u.UserId, u.Username, COUNT(DISTINCT c.CommentId) AS CommentCount, COUNT(DISTINCT c.RatingValue) AS RatingCount
FROM [User] u
LEFT JOIN Comment c ON u.UserId = c.UserId
GROUP BY u.UserId, u.Username;

SELECT * FROM View_UserCommentAndRatingCount;




