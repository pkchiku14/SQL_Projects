--###########              WSDA MUSIC LEARNING             ###########--
/* 
##############
CHALLENGE 1
##############
*/
/*
Created by: Prayash Panda
Created on: 2-08-2023
Description: The final project work for the course SQL essentials in LinkedIn
*/

--Challenge1:--
--1. List of transactions that took place between the years 2011 and 2012?--

SELECT
 InvoiceId,
 strftime('%Y', InvoiceDate) AS [year],
 total
FROM
 Invoice
WHERE year BETWEEN '2011' AND '2012'

--2. How many transactions took place between the years 2011 and 2012? --
SELECT
 COUNT(InvoiceDate)
FROM
 Invoice
WHERE strftime('%Y', InvoiceDate) BETWEEN '2011' AND '2012'

--3. How much money did WSDA Music make during the same period? --
SELECT
 SUM(total) AS 'Total money made'
FROM
 Invoice
WHERE strftime('%Y', InvoiceDate) BETWEEN '2011' AND '2012'


/*
##############
CHALLENGE 2
##############
*/
/*
More targeted questions that query tables containing data about customers and employees
*/

--1. Get a list of customers who made purchases between 2011 and 2012. --
SELECT
 i.InvoiceId,
 i.CustomerId,
 c.FirstName,
 c.LastName,
 i.total
FROM
 Invoice AS i
INNER JOIN
 Customer AS c
ON i.CustomerId = c.CustomerId
WHERE i.InvoiceId IN (SELECT
 InvoiceId
FROM
 Invoice
WHERE strftime('%Y', InvoiceDate) BETWEEN '2011' AND '2012'
)
ORDER BY i.total DESC

--2. Get a list of customers, sales reps, and total transaction amounts for each customer between 2011 and 2012.--
SELECT
 c.FirstName AS 'C firstname',
 c.LastName AS 'C laststname',
 e.FirstName AS 'E firstname',
 e.LastName AS 'E lasstname',
 i.total
FROM
 Invoice AS i
INNER JOIN
 Customer As c
ON i.CustomerId = c.CustomerId
INNER JOIN
 Employee AS e
ON e.EmployeeId = c.SupportRepId
WHERE i.InvoiceId IN (SELECT
 InvoiceId
FROM
 Invoice
WHERE strftime('%Y', InvoiceDate) BETWEEN '2011' AND '2012'
)
ORDER BY i.total DESC

--3. How many transactions are above the average transaction amount during the same time period?--
SELECT
 /*
 In case you want the names, uncomment this
 c.FirstName AS 'C firstname',
 c.LastName AS 'C laststname',
 e.FirstName AS 'E firstname',
 e.LastName AS 'E lasstname',
 i.total
 */
 Count(total)
FROM
 Invoice AS i
INNER JOIN
 Customer As c
ON i.CustomerId = c.CustomerId
INNER JOIN
 Employee AS e
ON e.EmployeeId = c.SupportRepId
WHERE i.InvoiceId IN (SELECT
 InvoiceId
FROM
 Invoice
WHERE strftime('%Y', InvoiceDate) BETWEEN '2011' AND '2012'
)
AND i.total > (
SELECT avg(total)
FROM Invoice
WHERE strftime('%Y', InvoiceDate) BETWEEN '2011' AND '2012')
ORDER BY i.total DESC

-- 4. What is the average transaction amount for each year that WSDA Music has been in business?--
SELECT
 strftime('%Y', InvoiceDate) AS [year],
 round(avg(total),2) AS averageTransaction
FROM
 Invoice
GROUP BY year


/*
############
CHALLENGE 3
############
*/
/*
Queries that perform in-depth analysis with the aim of finding employees who may have been
financially motivated to commit a crime
*/

--1. Get a list of employees who exceeded the average transaction amount from sales they generated during 2011 and 2012.--
SELECT
 e.FirstName AS 'E firstname',
 e.LastName AS 'E lasstname',
 sum(i.total) AS TotalSale
FROM
 Invoice AS i
INNER JOIN
 Customer As c
ON i.CustomerId = c.CustomerId
INNER JOIN
 Employee AS e
ON e.EmployeeId = c.SupportRepId
WHERE i.InvoiceId IN (SELECT
 InvoiceId
FROM
 Invoice
WHERE strftime('%Y', InvoiceDate) BETWEEN '2011' AND '2012'
)
AND i.total > (
SELECT avg(total)
FROM Invoice
WHERE strftime('%Y', InvoiceDate) BETWEEN '2011' AND '2012')
GROUP BY e.FirstName
ORDER BY TotalSale DESC

--2. Create a Commission Payout column that displays each employee’s commission based on 15% of the sales transaction amount.
SELECT
 e.FirstName AS 'E firstname',
 e.LastName AS 'E lasstname',
 sum(i.total) AS TotalSale,
 round(sum(i.total)*0.15,2) AS CommissionPayout
FROM
 Invoice AS i
INNER JOIN
 Customer As c
ON i.CustomerId = c.CustomerId
INNER JOIN
 Employee AS e
ON e.EmployeeId = c.SupportRepId
WHERE i.InvoiceId IN (SELECT
 InvoiceId
FROM
 Invoice
WHERE strftime('%Y', InvoiceDate) BETWEEN '2011' AND '2012'
)
GROUP BY e.FirstName
ORDER BY TotalSale DESC

--3. Which employee made the highest commission?--
SELECT
 e.FirstName||' '||e.LastName AS [Highest Commission],
 sum(i.total) AS [Total Sales],
 round(sum(i.total) *.15,2) AS [Commission Payout]
FROM
 Invoice i
INNER JOIN
 Customer c
ON i.CustomerId = c.CustomerId
INNER JOIN
 Employee e
ON e.EmployeeId = c.SupportRepId
WHERE
 InvoiceDate >= '2011-01-01' AND InvoiceDate <='2012-12-31'
GROUP BY
 e.FirstName,
 e.LastName
ORDER BY e.LastName DESC
LIMIT 1

--4. List the customers that the employee identified in the last question.--
SELECT
 c.FirstName AS [Customer Firstname],
 c.LastName AS [Customer Lastname],
 e.FirstName AS [Employer Firstname],
 e.LastName AS [Employer Firstname],
 sum(i.total) AS Purchase,
 round(sum(i.total)*0.15,2) AS CommissionPayout
FROM
 Invoice i
INNER JOIN
 Customer c
ON i.CustomerId = c.CustomerId
INNER JOIN
 Employee e
ON e.EmployeeId = c.SupportRepId
WHERE e.FirstName = 'Jane' and e.LastName = 'Peacock'
GROUP by c.FirstName
ORDER by Purchase DESC

--5. Which customer made the highest purchase?
SELECT
 c.FirstName||' '||c.LastName AS 'Highest Purchases',
 sum(i.total) AS Purchase,
 round(sum(i.total)*0.15,2) AS CommissionPayout
FROM
 Invoice i
INNER JOIN
 Customer c
ON i.CustomerId = c.CustomerId
INNER JOIN
 Employee e
ON e.EmployeeId = c.SupportRepId
WHERE e.FirstName = 'Jane' and e.LastName = 'Peacock'
GROUP by c.FirstName
ORDER by Purchase DESC
LIMIT 1

--6. Look at this customer record—do you see anything suspicious?
SELECT
 *
FROM
 Customer c
WHERE
 c.LastName = 'Doeein'
 
--7. Who do you conclude is our primary person of interest?--
--Ans. Jane Peacock is the primary person of interest as she is the Support Representative for John Doeein (whose entry is all NULL values)