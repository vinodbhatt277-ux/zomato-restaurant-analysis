--Q1 — Find the total number of rows in the Zomato_Raw table.
SELECT
	COUNT(*) AS TotalNumberOfRows
FROM Zomato_Raw;

--Q2 - Write a query to display the first 10 rows of the table.
SELECT
	TOP 10 *
FROM Zomato_Raw;

--Q3 - Find the number of NULL values in the rate column.
SELECT
	COUNT(*) AS RateColumnNullValues
FROM Zomato_Raw
WHERE rate IS NULL;

--Q4 - What percentage of the 51,717 rows have a NULL rate?
SELECT
	CAST((SELECT COUNT(*)*100.00 FROM Zomato_Raw WHERE rate IS NULL)
	/
	(SELECT COUNT(*) FROM Zomato_Raw) AS decimal(4,2)) AS NullRatePercentage;

--Q5 - Find the number of restaurants that offer both online ordering and table booking?
SELECT
	COUNT(*) AS NumberOfRestaurants
FROM Zomato_Raw
WHERE online_order=1 AND book_table=1;

--Q6 - Find the average rating of restaurants that offer online ordering?
SELECT
	CAST(AVG(TRY_CAST(REPLACE(rate,'/5','') AS decimal(4,2))) AS decimal(3,2)) AS AverageRating
FROM Zomato_Raw
WHERE online_order=1;

--Q7 - Find the number of restaurants available in each city (listed_in_city) 
--and display the results in descending order of the number of restaurants.
SELECT
	listed_in_city,
	COUNT(*) AS NumberOfRestaurants
FROM Zomato_Raw
GROUP BY listed_in_city
ORDER BY NumberOfRestaurants DESC,
listed_in_city ASC;

--Q8 - Find the average rating of restaurants in each listed_in_city
--and display the cities from highest average rating to lowest average rating.
SELECT
	listed_in_city,
	CAST(AVG(TRY_CAST(REPLACE(rate,'/5','') AS decimal(3,2))) AS decimal(3,2)) AS AverageRating
FROM Zomato_Raw
GROUP BY listed_in_city
ORDER BY AverageRating DESC;
	
--Q9 - For each listed_in_city, calculate:1. Total number of restaurants. 2. Number of restaurants that offer online ordering
--3. Percentage of restaurants that offer online ordering. --Display only cities where at least 500 restaurants are present,
--and sort by the online-order percentage from highest to lowest.
SELECT
	listed_in_city,
	COUNT(*) AS TotalNoOfRestaurants,
	SUM(CASE 
			WHEN online_order=1 THEN 1 
			ELSE 0 
		END
	)AS OnlineOrderRestaurants,
	CAST(
		SUM(
			CASE 
				WHEN online_order=1 THEN 1 
				ELSE 0 
			END)*100.00
			/
		COUNT(*) 
		AS decimal(5,2)
	) AS OnlineOrderPercentage
FROM Zomato_Raw
GROUP BY listed_in_city
HAVING COUNT(*)>=500
ORDER BY OnlineOrderPercentage DESC,
listed_in_city ASC;

--Q10 - For each restaurant type (rest_type), find:
--1.The total number of restaurants
--2.The average rating
--3.The number of restaurants that offer online ordering
--Display the results in descending order of the number of restaurants.
SELECT
	rest_type,
	COUNT(*) AS TotalNoOfRestaurants,
	CAST(AVG(TRY_CAST(REPLACE(rate,'/5','') AS decimal(5,2))) AS decimal(5,2)) AS AverageRating,
	SUM(CASE WHEN online_order=1 THEN 1 ELSE 0 END) AS OnlineOrderRestaurants
FROM Zomato_Raw
GROUP BY rest_type
ORDER BY TotalNoOfRestaurants DESC,
rest_type ASC;

--Q11 - Find the top 10 listed_in_city locations having the highest number of restaurants.
SELECT
	TOP 10 listed_in_city,
	COUNT(*) AS NumberOfRestaurants
FROM Zomato_Raw
GROUP BY listed_in_city
ORDER BY NumberOfRestaurants DESC,
listed_in_city ASC;

--Q12 - For each listed_in_city, find the number of distinct cuisines available.
--Display the cities with the highest number of distinct cuisines first.
SELECT
	listed_in_city,
	COUNT(DISTINCT cuisines) AS UniqueCuisines
FROM Zomato_Raw
GROUP BY listed_in_city
ORDER BY UniqueCuisines DESC,
listed_in_city ASC;

--Q13 - For each listed_in_city, find the number of restaurants that do not have a valid rating.
SELECT
	listed_in_city,
	COUNT(*) AS UnratedRestaurants
FROM Zomato_Raw
WHERE rate IS NULL OR LTRIM(RTRIM(rate)) IN ('', 'New')
GROUP BY listed_in_city
ORDER BY UnratedRestaurants DESC,
listed_in_city ASC;

--Q14 - Find the top 10 restaurants with the highest number of votes.
--Display: Restaurant name, Number of votes. Sort from highest votes to lowest votes.
SELECT
	TOP 10 name AS RestaurantName,
	listed_in_city,
	SUM(votes) AS TotalVotes
FROM Zomato_Raw
GROUP BY name, listed_in_city
ORDER BY TotalVotes DESC,
listed_in_city ASC,
name ASC;

--Q15 - For each rest_type, find the average number of votes received by restaurants.
--Display the restaurant type and average votes, and sort from highest average votes to lowest average votes.
SELECT
	rest_type AS Restaurant_Type,
	CAST(AVG(votes*1.0) AS decimal(10,2)) AS AverageNoOfVotes
FROM Zomato_Raw
GROUP BY rest_type
ORDER BY AverageNoOfVotes DESC,
rest_type ASC;

--Q16 - For each rest_type, calculate the average rating. 
--Display only those restaurant types whose average rating is greater than 4.0.
SELECT
	rest_type,
	CAST(AVG(TRY_CAST(REPLACE(rate,'/5','') AS decimal(5,2))) AS decimal(5,2)) AS AverageRating
FROM Zomato_Raw
GROUP BY rest_type
HAVING AVG(TRY_CAST(REPLACE(rate,'/5','') AS decimal(5,2)))>4.0
ORDER BY AverageRating DESC, rest_type ASC;

--Q17 — For each rest_type, find the highest rating achieved by any restaurant of that type.Display: rest_type, Highest rating.
--Sort from highest rating to lowest rating.
SELECT
	rest_type AS RestaurantType,
	MAX(TRY_CAST(REPLACE(rate,'/5','') AS decimal(5,2))) AS HighestRating
FROM Zomato_Raw
GROUP BY rest_type
ORDER BY HighestRating DESC,
rest_type ASC;

--Q18 — Find all restaurants whose number of votes is greater than the overall average number of votes across all restaurants.
--Display:Restaurant name, Number of votes. Sort by number of votes from highest to lowest.
SELECT
	name AS RestaurantName,
	votes AS NoOfVotes
FROM Zomato_Raw
WHERE votes>(
		SELECT	
			AVG(votes*1.0)
		FROM Zomato_Raw)
ORDER BY NoOfVotes DESC,
RestaurantName ASC;

--Q19 — For each rest_type, find:
--1)The average rating.
--2)The average number of votes.
--3)Display only restaurant types where the average rating is greater than 4.0.
--4)Sort the results by average number of votes from highest to lowest.
	SELECT
		rest_type AS RestaurantType,
		CAST(AVG(TRY_CAST(REPLACE(rate,'/5','') AS decimal(5,2))) AS decimal(5,2)) AvgRating,
		CAST(AVG(votes*1.0) AS decimal(10,2)) AS AvgVotes
	FROM Zomato_Raw
	GROUP BY rest_type
	HAVING AVG(TRY_CAST(REPLACE(rate,'/5','') AS decimal(3,2)))>4.0
	ORDER BY AvgVotes DESC,
	rest_type ASC;

--Q20 — For each rest_type, find:1)Total number of restaurants. 
--2)Number of restaurants offering online ordering
--3)Percentage of restaurants offering online ordering. 
--4)Average rating. Display only restaurant types with at least 100 restaurants.
--Sort by percentage of online-ordering restaurants from highest to lowest.
SELECT
	rest_type as RestaurantType,
	COUNT(*) AS NoOfRestaurants,
	SUM(CASE 
			WHEN online_order=1 THEN 1 
				ELSE 0
			END
		) AS OnlineOrderRestaurants,
	CAST((SUM	
		(CASE
			WHEN online_order=1 THEN 1
				ELSE 0
			END
		)*100.0
		/
		COUNT(*)
	) AS decimal(5,2)) AS PercentageOfRestaurants,
	CAST(AVG
			(TRY_CAST(REPLACE(rate,'/5','') AS decimal(5,2)))
			AS decimal(5,2)
		) AS AvgRatings
	FROM Zomato_Raw
	WHERE rest_type IS NOT NULL
	GROUP BY rest_type
	HAVING COUNT(*)>=100
	ORDER BY PercentageOfRestaurants DESC,rest_type ASC;
	
--Q21 — For each listed_in_city, 
--1.find the restaurant with the highest number of votes in that city. Display:
--2.listed_in_city
--3.Restaurant name
--4.Number of votes
--If multiple restaurants have the same highest number of votes in a city, 
--include all tied restaurants.
WITH RankedRestaurants AS
(
    SELECT
        listed_in_city,
        name,
        SUM(votes) AS NumberOfVotes,
        RANK() OVER
        (
            PARTITION BY listed_in_city
            ORDER BY SUM(votes) DESC
        ) AS RankOfRestaurants
    FROM Zomato_Raw
    GROUP BY listed_in_city, name
)
SELECT
    listed_in_city,
    name,
    NumberOfVotes
FROM RankedRestaurants
WHERE RankOfRestaurants = 1
ORDER BY listed_in_city ASC, name ASC;


--Q22 — For each listed_in_city, calculate:
--1.Total number of restaurants
--2.Percentage of restaurants offering online ordering
--Display only cities having at least 500 restaurants, and sort by online-ordering percentage from highest to lowest.
SELECT
	listed_in_city AS Cities,
	COUNT(*) AS TotalNoOfRestaurants,
	CAST((SUM(
		CASE
			WHEN
				online_order=1 THEN 1
				ELSE 0
			END
		)*100.00/
		COUNT(*)
	) AS decimal(5,2)) AS PercentageOfRestaurants
FROM Zomato_Raw
GROUP BY listed_in_city
HAVING COUNT(*)>=500
ORDER BY PercentageOfRestaurants DESC,
listed_in_city ASC;