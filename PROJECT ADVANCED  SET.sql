/*Find how much amount spent by each customer on artist? Write a Query
to return customer name, Artist name and total spent*/

WITH best_selling_artist AS 
(SELECT TOP 1
a.name,
a.artist_id,
SUM((il.unit_price)*(il.quantity)) AS total_sales_artist
FROM dbo.invoice_line AS il
JOIN dbo.track AS t ON t.track_id=il.track_id
JOIN dbo.album AS al ON al.album_id=t.album_id
JOIN dbo.artist AS a ON a.artist_id=al.artist_id
GROUP BY a.name,a.artist_id
ORDER BY total_sales_artist DESC
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



