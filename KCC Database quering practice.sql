----- RETRIEVE THE REVENUE EARNED FOR EACH COOKIE
-- (SELECT STATEMENT)
SELECT CookieID, RevenuePerCookie
FROM Product


----- TOTAL NUMBER OF ORDERS BY CUSTOMER
-- (AGG FUNCTION)
SELECT CustomerID, COUNT(OrderID) as TotalNumberOfOrders
FROM Orders
GROUP BY CustomerID


----- WHAT IS THE AVERAGE SPENDING FOR EACH CUSTOMER, SHOWING CUSTOMER NAME 
-- (INNER JOIN)
SELECT AVG(o.OrderTotal) as AverageSpending, c.CustomerName
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName


----- WHO ARE THE CUSTOMERS WHO HAVE PLACED TOTAL ORDERS WORTH MORE THAN $15000
-- (INNER JOIN)
SELECT SUM(o.OrderTotal) as TotalSpending, c.CustomerName
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(o.OrderTotal) > 15000


----- TOTAL SALES FOR EACH COOKIE
-- (JOIN)
SELECT p.CookieID, p.RevenuePerCookie * TotalQuanitySold.CookiesSold AS TotalSalesPerCookie
FROM Product p
JOIN (
	SELECT CookieID, SUM(Quantity) as CookiesSold
	FROM Order_Product
	GROUP BY CookieID
	) as TotalQuanitySold
ON p.CookieID = TotalQuanitySold.CookieID


----- GET PROFIT EARNED ACROSS EACH ORDER FOR EACH COOKIE
-- (JOIN)
SELECT p.CookieID, (p.RevenuePerCookie - p.CostPerCookie)* CookiesSold.NumberOfCookiesSold AS TotalProfit
FROM Product p
JOIN (
	SELECT CookieID, SUM(Quantity) as NumberOfCookiesSold
	FROM Order_Product
	GROUP BY CookieID
	) AS CookiesSold
ON p.CookieID = CookiesSold.CookieID


----- FIND THE CUSTOMERID WHO PLACED THE HIGHEST NUMBER OF ORDERS
-- (SUBQUERYING)
-- Find the max number of orders first
SELECT MAX(TotalNumberOfOrders) as MaxOrder
FROM (
	SELECT CustomerID, COUNT(OrderID) as TotalNumberOfOrders
	FROM Orders
	GROUP BY CustomerID
) AS OrderCounts

-- Get the customers who's total number of orders equal to the max number of orders
SELECT CustomerID, TotalNumberOfOrders
FROM (
	SELECT CustomerID, COUNT(OrderID) as TotalNumberOfOrders
	FROM Orders
	GROUP BY CustomerID
) AS OrderCounts
WHERE TotalNumberOfOrders = 
(SELECT MAX(TotalNumberOfOrders) as MaxOrder
	FROM (
		SELECT CustomerID, COUNT(OrderID) as TotalNumberOfOrders
		FROM Orders
		GROUP BY CustomerID
	) AS OrderCounts
)


