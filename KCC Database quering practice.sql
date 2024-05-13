----- What is the average spending for each Customer, showing customer name
SELECT AVG(o.OrderTotal) as AverageSpending, c.CustomerName
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName

----- Who are the customers who have placed total orders worth more than $15000
SELECT SUM(o.OrderTotal) as TotalSpending, c.CustomerName
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
--HAVING SUM(o.OrderTotal) > 15000

----- Total number of Orders per Customer
SELECT CustomerID, COUNT(OrderID) as TotalNumberOfOrders
FROM Orders
GROUP BY CustomerID

----- Find the customerID who placed the highest number of orders
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

----- Get Profit earned across each order for each cookie
-- Get Profit per cookie by taking revenue - cost
SELECT p1.CookieID, p1.RevenuePerCookie - p2.CostPerCookie AS Profit
FROM Product p1
JOIN Product p2
ON p1.CookieID = p2.CookieID

-- Get total cookies sold per cookieID
SELECT CookieID, SUM(Quantity) AS TotalCookiesSoldAcrossAllOrders
FROM Order_Product
GROUP BY CookieID

-- Create view of Profit and Cookies Sold
SELECT ProfitPerCookieTable.CookieID, ProfitPerCookieTable.Profit, TotalCookiesSoldAcrossAllOrdersTable.CookiesSold
FROM (SELECT p1.CookieID, p1.RevenuePerCookie - p2.CostPerCookie AS Profit
		FROM Product p1
		JOIN Product p2
		ON p1.CookieID = p2.CookieID
	) AS ProfitPerCookieTable
INNER JOIN (SELECT CookieID, SUM(Quantity) AS CookiesSold
		FROM Order_Product
		GROUP BY CookieID
	) AS TotalCookiesSoldAcrossAllOrdersTable
ON ProfitPerCookieTable.CookieID = TotalCookiesSoldAcrossAllOrdersTable.CookieID

-- Use View to calculate Total Profit sold for each cookie
SELECT CookieID, Profit * CookiesSold AS TotalProfitEarnedPerCookie
FROM (
SELECT ProfitPerCookieTable.CookieID, ProfitPerCookieTable.Profit, TotalCookiesSoldAcrossAllOrdersTable.CookiesSold
FROM (SELECT p1.CookieID, p1.RevenuePerCookie - p2.CostPerCookie AS Profit
		FROM Product p1
		JOIN Product p2
		ON p1.CookieID = p2.CookieID
	) AS ProfitPerCookieTable
INNER JOIN (SELECT CookieID, SUM(Quantity) AS CookiesSold
		FROM Order_Product
		GROUP BY CookieID
	) AS TotalCookiesSoldAcrossAllOrdersTable
ON ProfitPerCookieTable.CookieID = TotalCookiesSoldAcrossAllOrdersTable.CookieID
) ProfitOfEachCookieSold 


