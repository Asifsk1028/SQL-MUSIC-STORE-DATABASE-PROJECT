/*Write a Query to return email,first_name,last_name,&genre of all Rock music listener.
Return your list Ordered Alphabetically by email starting with A*/

SELECT DISTINCT
c.email,
c.first_name,
c.last_name,
g.name
FROM dbo.customer AS c
JOIN dbo.invoice AS i ON c.customer_id=i.customer_id
JOIN dbo.invoice_line AS ii ON i.invoice_id=ii.invoice_id
JOIN dbo.track AS t ON ii.track_id=t.track_id 
JOIN dbo.genre AS g ON t.genre_id=g.genre_id
WHERE g.name='Rock'
ORDER BY email 


/* Lets invite the artist who have written most rock music in our dataset.
Write a query that returns the Artist name and total track count of top 10 rock band*/

SELECT TOP 10
aa.name,
COUNT(t.track_id) AS track_count, 
g.name
FROM dbo.track AS t
INNER JOIN dbo.genre AS g
ON g.genre_id=t.genre_id
INNER JOIN dbo.album AS a
ON t.album_id=a.album_id
INNER JOIN dbo.artist AS aa
ON aa.artist_id=a.artist_id
WHERE g.name='rock'
GROUP BY aa.name,g.name
ORDER BY track_count DESC


/*Return all the track name that have a song longer than the average song length .
Return the Name and Milliseconds for each track.Order by the song length with the longest
song listed first*/
SELECT name,milliseconds FROM(
SELECT 
name,
milliseconds,
AVG(milliseconds) OVER() AS Avg_length
FROM dbo.track)t 
WHERE milliseconds>Avg_length
ORDER BY milliseconds DESC
/*ALTERNATE ANSWER*/
SELECT 
name,
milliseconds
FROM dbo.track
WHERE milliseconds>(SELECT AVG(milliseconds) FROM dbo.track)
ORDER BY milliseconds DESC


