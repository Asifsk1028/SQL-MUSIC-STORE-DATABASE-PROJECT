/*Find how much amount spent by each customer on artist? Write a Query
to return customer name, Artist name and total spent*/

WITH best_selling_artist AS 
(SELECT 
a.name,
a.artist_id,
SUM((il.unit_price)*(il.quantity)) AS total_sales_artist
FROM dbo.invoice_line AS il
JOIN dbo.track AS t ON t.track_id=il.track_id
JOIN dbo.album AS al ON al.album_id=t.album_id
JOIN dbo.artist AS a ON a.artist_id=al.artist_id
GROUP BY a.name,a.artist_id
)
SELECT
c.customer_id,
c.first_name,
c.last_name,
bsa.name,
SUM((il.unit_price)*(il.quantity)) AS total_spent_customer
FROM dbo.customer AS c 
JOIN dbo.invoice AS i ON c.customer_id=i.customer_id
JOIN dbo.invoice_line AS il ON i.invoice_id=il.invoice_id
JOIN dbo.track AS t ON t.track_id=il.track_id 
JOIN dbo.album AS al ON al.album_id=t.album_id
JOIN best_selling_artist AS bsa ON al.artist_id=bsa.artist_id
GROUP BY c.customer_id,c.first_name,c.last_name,bsa.name
ORDER BY total_spent_customer DESC



/*We want to find out the most popular music genre for each country. 
We determine the most popular genre as the genre with the highest amount of purchases.
Write a query that returns each country along with the top genre .
For countries where the maximum number of purchases is shared return all Genre*/
WITH popular_genre AS (
SELECT 
COUNT(il.quantity) AS Purchase,
c.country,
g.name AS Genre_name,
ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity)DESC) AS RNK
FROM 
dbo.invoice AS i 
JOIN dbo.invoice_line AS il ON il.invoice_id=i.invoice_id
JOIN dbo.customer AS c ON c.customer_id=i.customer_id
JOIN dbo.track AS t ON t.track_id=il.track_id
JOIN dbo.genre AS g ON t.genre_id=g.genre_id
GROUP BY c.country,g.name
)
SELECT * FROM popular_genre 
WHERE RNK=1
ORDER BY country ASC,Purchase DESC


/*Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customers and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

WITH most_spent AS (
 SELECT 
 c.customer_id,
 c.first_name,
 c.last_name,
 i.billing_country,
 SUM(i.total) AS total_spent,
 ROW_NUMBER() OVER(PARTITION BY i.billing_country ORDER BY SUM(i.total)	DESC ) AS RNK
 FROM dbo.invoice AS i 
 JOIN dbo.customer AS c ON c.customer_id=i.customer_id
 GROUP BY  c.customer_id,c.first_name,c.last_name,i.billing_country
 )
 SELECT * FROM most_spent
 WHERE RNK<=1


 




