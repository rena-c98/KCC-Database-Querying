# KCC-Database-Querying
Found an online database file and performed SQL queries on the database

An online dataset taken by Kevin Stratvert, with the link of the database "https://onedrive.live.com/?authkey=%21AGGtzPTtFEqtVoU&id=B09F9559F6A16B6C%2177197&cid=B09F9559F6A16B6C&parId=root&parQt=sharedby&o=OneUp"

In this dataset, there were 4 tables:
1. Customers
    - CustomerID (PK)
    - CustomerName
    - Phone
    - Address
    - City
    - State
    - Zip
    - Country
    - Notes
2. Orders
    - OrderID (PK)
    - OrderDate
    - CustomerID
    - OrderTotal
3. Order_Product
    - OrderID
    - CookieID
    - Quantity
4. Product
    - CookieID
    - CookieName
    - RevenuePerCookie
    - CostPerCookie

In the SQL file, SELECT statements with AGG functions, INNER JOINS, WHERE and GROUP BY clause, as well as the HAVING clause are used.
