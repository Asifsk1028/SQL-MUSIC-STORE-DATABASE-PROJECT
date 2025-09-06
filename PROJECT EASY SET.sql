
/*1)Who is senior most employee based on job title*/
SELECT TOP 1 * FROM 
dbo.employee
ORDER BY levels DESC

/*2)Which country have most invoices*/
SELECT TOP 1
billing_country,
COUNT(invoice_id) AS inv_count
FROM dbo.invoice
GROUP BY billing_country
ORDER BY inv_count DESC

/*3)What are top 3 values of total invoce*/
SELECT TOP 3
ROUND(total,2) AS total_invoice
FROM 
dbo.invoice
ORDER BY total DESC

/*4)Which city has best customers?We would like to throw a promotional music festival
in city we have made most the money. Write the Query that returns one city that has
highest sum of invoice totals. Return both city name & sum of all invoice total*/

SELECT TOP 1
billing_city,
SUM(total) AS invoice_total
FROM
invoice
GROUP BY billing_city
ORDER BY invoice_total DESC

/*5)Who is best customer?The customer who has spent the most money is considered 
as best customer . Write a query that returns the person who has spent the most money*/
SELECT TOP 1
c.first_name,
c.last_name,
c.customer_id,
SUM (i.total) AS total_spent
FROM 
 dbo.customer AS c
JOIN dbo.invoice AS i
ON c.customer_id=i.customer_id
GROUP BY c.first_name,
c.last_name,
c.customer_id
ORDER BY total_spent DESC




