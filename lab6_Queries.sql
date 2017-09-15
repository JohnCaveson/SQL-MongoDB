SELECT Category, City, State, SUM((Quantity*SalePrice)+SalesTax) AS TotalPrice, SUM(Quantity) AS TotalCount
FROM Sales
INNER JOIN CUSTOMER ON SALES.CUSTOMERID = CUSTOMER.CUSTOMERID
INNER JOIN ANIMAL ON SALES.ANIMALID = ANIMAL.ANIMALID
GROUP BY ROLLUP(Category, CITY, State);