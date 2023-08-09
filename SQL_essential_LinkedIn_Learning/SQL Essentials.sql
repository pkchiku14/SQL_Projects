--###############         Composing Basic query      ##################--
-- SQL Basic querying which will include:
--1. Commenting
--2. Best practices
--3. Alias usage
--4. Sorting and Limiting query results--

/* 
Created by: Prayash Panda
Create Date: 1-08-2023

This is another way of commenting with respect to the one shown above
*/


/*
Description: First and Last names with email address
*/

SELECT 
  FirstName,
  LastName,
  Email
FROM
  Customer
  
--ALIASING--

SELECT 
  FirstName AS [Customer first name],
  LastName AS 'Customer last name',
  Email AS EMAIL
FROM
  Customer
  
--SORTING--
SELECT 
  FirstName AS [Customer first name],
  LastName AS 'Customer last name',
  Email AS EMAIL
FROM
  Customer
ORDER BY
  FirstName ASC,
  LastName DESC   
  
--LIMITING--
SELECT 
  FirstName AS [Customer first name],
  LastName AS 'Customer last name',
  Email AS EMAIL
FROM
  Customer
ORDER BY
  FirstName ASC,
  LastName DESC
LIMIT 25




--#############       Discovering insights in Data       #############--
/*
Created by: Prayash Panda
Create Date: 1-08-2023


Operator types:
1. Arithematic - Addition, Subtraction, Division, Multiplication, Modulo
2. Comparison - =, <>, >=, <=, >, <
3. Logical- AND, OR, IN, LIKE, BETWEEN
*/

--Filter and analyse numeric data--
/*
Description: Customers who purchased two songs at $0.99 each
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  total=1.98
ORDER BY
  InvoiceDate

--Using BETWEEN and IN for numerics--  
/*
Description: How many invoices exist between $1.98 and $5.00
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  total BETWEEN 1.98 AND 5.00
ORDER BY
  InvoiceDate
  
/*
Description: How many invoices are exactly $1.98 or $3.96
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  total IN (1.98, 3.96)
ORDER BY
  InvoiceDate

--Filtering Text Data--  
/*
Description: How many invoices where titled to Brussels
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  BillingCity = 'Brussels'
ORDER BY
  InvoiceDate
  
/*
Description: How many invoices were billed to Brussels, Orlando or Paris
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  BillingCity IN ('Brussels', 'Orlando', 'Paris')
ORDER BY
  InvoiceDate

--Search record without an exact match--
/*
Description: How many invoices were billed in cities that start with B
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  BillingCity LIKE 'B%'
ORDER BY
  InvoiceDate

/*
Description: How many invoices were billed in cities that have B anywhere in their name
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  BillingCity LIKE '%B%'
ORDER BY
  InvoiceDate
  
--Filter and Analyse using Dates--
/*
Description: How many invoices were billed on 2010-05-22 00:00:00
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  InvoiceDate = '2010-05-22 00:00:00'
ORDER BY
  InvoiceDate
  
/*
Description: How many invoices were billed on 2010-05-22 00:00:00 using DATE function
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  DATE(InvoiceDate) = '2010-05-22'
ORDER BY
  InvoiceDate
  
--Filter records based on more than one condition--
/*
Description: get all invoices that were billed after 2010-05-22 and have a total of less than 3:00
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  DATE(InvoiceDate) > '2010-05-22' AND total < 3.00
ORDER BY
  InvoiceDate
  
--Logical operator OR--
/*
Description: get all invoices whose billing cities starts with P or starts with D
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  BillingCity LIKE 'P%' OR BillingCity LIKE 'D%'
ORDER BY
  InvoiceDate
  
--Brackets and orders--
/*
Description: get all invoices that are greater than 1.98 from any cities whose name starts with a P or starts with D

PEMDAS- Paranthesis, Exponents, Multiplication, Division, Addition, Substraction
BEMDAS- Brackets, Exponents, Multiplication, Division, Addition, Substraction
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
  Invoice
WHERE
  total > 1.98 AND (BillingCity LIKE 'P%' OR BillingCity LIKE 'D%')   
ORDER BY
  InvoiceDate
  
--IF THEN logic with CASE--
/*
Description: 
The company wants as many customers as possible to spend between $7.00 and $15.00

Sales Categories:
Baseline purchase - Between 0.99 and 1.99
low purchase - Between 2.00 and 6.99
Target purchase - Between 7.00 and 15.00
Top performer - Above 15.00
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total,
 CASE
 WHEN total < 2.00 THEN 'Baseline purchase'
 WHEN total BETWEEN 2.00 AND 6.99 THEN 'Low Purchase'
 WHEN total BETWEEN 7.00 AND 15.00 THEN 'Target Purchase'
 ELSE 'Top'
 END AS Purchasetype
FROM
  Invoice
WHERE
  Purchasetype = 'Top'
ORDER BY
  InvoiceDate



--#################          JOINS          ###################--  
/*
Created by: Prayash Panda
Create Date: 1-08-2023
Description: Joins
*/

--INNER JOIN--
SELECT *
FROM
 Invoice
INNER JOIN
  Customer
ON
  Invoice.CustomerId = Customer.CustomerId
ORDER BY
  Customer.CustomerId
  
--Simplifying Joins--
SELECT 
 c.LastName,
 c.FirstName,
 i.InvoiceId,
 i.CustomerId,
 i.InvoiceDate,
 i.total
FROM
 Invoice AS i
INNER JOIN
  Customer AS c
ON
  i.CustomerId = c.CustomerId
ORDER BY c.CustomerId

--LEFT OUTER JOIN--
SELECT 
 c.LastName,
 c.FirstName,
 i.InvoiceId,
 i.CustomerId,
 i.InvoiceDate,
 i.total
FROM
 Invoice AS i
LEFT OUTER JOIN
  Customer AS c
ON
  i.CustomerId = c.CustomerId
  
--RIGHT OUTER JOIN--
SELECT 
 c.LastName,
 c.FirstName,
 i.InvoiceId,
 i.CustomerId,
 i.InvoiceDate,
 i.total
FROM
 Invoice AS i
RIGHT OUTER JOIN
  Customer AS c
ON
  i.CustomerId = c.CustomerId

--Multi Joins--
/*
Description: Joins on more than two tables | What employees are responsible for the 10 highest individual sales?
*/
SELECT
  e.FirstName,
  e.LastName,
  e.EmployeeId,
  c.FirstName,
  c.SupportRepId,
  i.CustomerId,
  i.total
FROM 
  Invoice AS i
INNER JOIN 
  Customer AS c
ON
  i.CustomerId = c.CustomerId
INNER JOIN
  Employee as e
ON
  c.SupportRepId = e.EmployeeId
ORDER BY 
  i.total DESC
LIMIT 10




--###########            SQL Functions             ###########--
/*
Created by: Prayash Panda
Create Date: 1-08-2023
Description: Types of Functions
1. aggregate - min(), max(), avg(), count(), sum()
2. string - upper(), substr(), instr(), length(), ltrim(), replace(), trim()
3. date - now, datetime(), date(), julianday(), strftime(), time()
*/

--Connecting strings--
/*
Description: create a mailing list of USA customers
*/
SELECT
  FirstName,
  LastName,
  Address,
  FirstName||' '||LastName||' '||Address||', '||State||' '||PostalCode AS MailingAddress
FROM
  Customer
WHERE 
  Country = 'USA'
  
--Truncate--
SELECT
  FirstName,
  LastName,
  Address,
  FirstName||' '||LastName||' '||Address||', '||State||' '||PostalCode AS MailingAddress,
  LENGTH(PostalCode),
  substr(PostalCode,1,5) AS '5 digit postal code'
FROM
  Customer
WHERE Country = 'USA'

--Upper and Lower function--
SELECT
  FirstName,
  LastName,
  Address,
  FirstName||' '||LastName||' '||Address||', '||State||' '||PostalCode AS MailingAddress,
  LENGTH(PostalCode),
  substr(PostalCode,1,5) AS '5 digit postal code',
  Upper(FirstName) AS [First All caps],
  Lower(LastName) AS [Last All caps]
FROM
  Customer
WHERE
  Country = 'USA'
  
--DATE--
/*
Description: Calculate Age of Employees
*/
SELECT 
  LastName,
  FirstName,
  BirthDate,
  strftime('%Y-%m-%d',BirthDate) AS [Birthdate no timecode],
  strftime('%Y-%m-%d','now') - strftime('%Y-%m-%d',BirthDate) AS Age
FROM
  Employee
  
--Aggregate--
/*
Description: What are our all time global sales?
*/
SELECT
 Sum(total) AS [TotalSales],
 avg(total) AS [AverageSales],
 max(total) AS [MaximumSale],
 min(total) AS [MinimumSale],
 count(*) AS [SalesCount]
FROM
 Invoice

--NESTING--
SELECT
 Sum(total) AS [TotalSales],
 ROUND(avg(total),2) AS [AverageSales],
 max(total) AS [MaximumSale],
 min(total) AS [MinimumSale],
 count(*) AS [SalesCount]
FROM
 Invoice


 

--############           GROUPING            #############--
/*
Description: What are average invoice totals by City
*/
SELECT
 BillingCity,
 round(avg(total),2) AS [averagesales]
FROM
 Invoice
GROUP BY
 BillingCity
ORDER BY
 BillingCity
 
--Grouping with where clause--
/*
Description: What are average invoice totals for only the cities starting with L?
*/
SELECT
 BillingCity,
 round(avg(total),2) AS [averagesales]
FROM
 Invoice
WHERE BillingCity LIKE 'L%'
GROUP BY
 BillingCity
ORDER BY
 BillingCity
 

 --Grouping with having clause--
 /*
Description: What are average invoice totals greater than $5.00?
*/
SELECT
 BillingCity,
 round(avg(total),2) AS [averagesales]
FROM
 Invoice
GROUP BY
 BillingCity
HAVING avg(total) > 5.00
ORDER BY
 BillingCity
 

--GROUPING with Where and having--
/*
Where is used to filter non aggregate columns and HAVING is used to filter using aggregated columns
Description: What are average invoice totals greater than $5.00 and cities starting with B
*/
SELECT
 BillingCity,
 round(avg(total),2) AS [averagesales]
FROM
 Invoice
WHERE BillingCity LIKE 'B%'
GROUP BY
 BillingCity
HAVING avg(total) > 5.00
ORDER BY
 BillingCity
 
--Grouping by many fields--
/*
Description: What are average invoice totals by billing country and city?
*/
SELECT
 BillingCountry,
 BillingCity,
 round(avg(total),2) AS [averagesales]
FROM
 Invoice
GROUP BY
 BillingCountry, BillingCity
ORDER BY
 BillingCountry
 

 
 
--###########        NESTED QUERY          #############--
/*
Description: gather Data about all invoices that are less than the average
*/
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity,
 total
FROM
 Invoice
WHERE
 total < 
  (Select avg(total) from Invoice)
 ORDER BY total DESC
 
--Aggregated Subqueries--
/*
description: How is each city performing against the global average sales?
*/
SELECT
 BillingCity,
 avg(totaL) AS Cityavg,
 (SELECT avg(total)from Invoice) AS globalavg
FROM
 Invoice
GROUP BY
 BillingCity
ORDER BY
 BillingCity
 
--Non aggregated Subqueries--
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity
FROM
 Invoice
WHERE
 InvoiceDate > 
 (SELECT InvoiceDate FROM Invoice WHERE InvoiceId = 251)
 
--IN clause subquery--
SELECT
 InvoiceDate,
 BillingAddress,
 BillingCity
FROM
 Invoice
WHERE
 InvoiceDate IN 
(SELECT 
  InvoiceDate
 FROM 
  Invoice
 WHERE
  InvoiceId IN (251,252,254)
)

--DISTINCT Clause subquery--
/*
Description: Which tracks are not selling?
*/
SELECT
 TrackId,
 Composer,
 Name
FROM
 Track
WHERE 
 TrackId
NOT IN
(SELECT
 DISTINCT(TrackId)
FROM
 InvoiceLine
ORDER BY TrackId)




--########          VIEWS          ##########--
/*
Description: Views
*/

--Create a view--
CREATE VIEW V_AvgTotal AS
SELECT
 round(avg(total),2) AS [Average Total]
FROM
 Invoice

--Edit a view--
/*
Drop the view manually and the modify the existing VIEW
*/
DROP VIEW "main"."V_AvgTotal";
CREATE VIEW V_AvgTotal AS
SELECT
 avg(total) AS [Average Total]
FROM
 Invoice*/
 
 
-- Joining Views--
CREATE VIEW V_tracks_invoiceLine AS 
SELECT
 il.InvoiceId,
 il.UnitPrice,
 il.Quantity,
 t.Name,
 t.Composer,
 t.Milliseconds
FROM
 InvoiceLine il
INNER JOIN 
 Track t
ON 
 il.TrackId = t.TrackId
 
--Delete a View--
/*
Two ways:
1. Manually DELETE
2. SQL syntax
*/
DROP VIEW
 V_AvgTotal



 
 
--############           DML QUERY           ############--
/*
Data MAnipulation language
1. Insert
2. Update
3. Delete
*/

--Insert data--
INSERT INTO 
  Artist(Name)
VALUES ('Bob Marley')

--UPDATE--
UPDATE 
Artist
SET Name = 'Damien Marley'
WHERE ArtistId = 276

--DELETE--
DELETE FROM 
  Artist
WHERE 
  ArtistId = 276