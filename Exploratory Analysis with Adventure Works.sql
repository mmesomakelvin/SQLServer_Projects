--Exploratory Data Analysis

--To understand what the table looks like in the Person.Person and Sales.Customer Tables
--** Have to use the SELECT * Statement
SELECT * FROM [Person].[Person];
SELECT * FROM [Sales].[Customer];

--To select specific columns from the sales.custoner table just for exploratory practice sake
--Retrieve specific columns (CustomerID, PersonID, and rowguid) from the Sales.Customer table
SELECT CUSTOMERID, PERSONID, ROWGUID
FROM [Sales].[Customer];

--to show me distint Person Id values in the Sales.customer table
--**Have to use SELECT DISTINCT
SELECT DISTINCT PERSONID
FROM [Sales].[Customer];

--Exploring the Sales.salesterritory Table 
SELECT * FROM [Sales].[SalesTerritory];

--to count specific columns/entire table and display the results of the count on the sales.salesterritory table
--Have to use SELECT COUNT
SELECT COUNT([Group]) as group_count,
       COUNT(name) as name_count
FROM [Sales].[SalesTerritory];

--To count all records, SELECT (*)
select count(*) as total_records
from [Sales].[SalesTerritory];

--Trying to understand Total No. of Distinct Values, SELECT COUNT(DISTINCT......)
select count(distinct CountryRegionCode) as count_distint_crc
from [Sales].[SalesTerritory];

--Emplying subqueries to do a count distinct which first alias is column name and second alias is subquery table.
SELECT COUNT(*) As total_groups_avail
FROM (SELECT DISTINCT [Group] FROM [Sales].[SalesTerritory]) AS Distinct_groups;

--Exploring the Sales.SalesorderDetail table using Comparison Operators
select * from [Sales].[SalesOrderDetail];

--Looking for ProductID greatwer than 800
Select salesorderid, unitprice, orderqty
from [Sales].[SalesOrderDetail]
where productid > 800;

--Looking for Unit price within the sales.salesorderdetail with a unit price less than or equalto 400
Select salesorderid, unitprice, orderqty, UnitPriceDiscount
from [Sales].[SalesOrderDetail]
where UnitPrice <= 400;


SELECT SUM(ORDERQTY) AS SUM_OF_ORDERS
FROM [Sales].[SalesOrderDetail];

select * from [Sales].[SalesReason];

Select Name,Salesreasonid
from [Sales].[SalesReason]
where ReasonType = 'Other';

select * from [Sales].[SalesOrderHeader];

select * from [Sales].[SalesOrderHeader]
where subtotal >=20000
and SubTotal <=30000;

select taxamt as tax_amount, salesorderid, shipmethodid
from [Sales].[SalesOrderHeader]
where CreditCardID
between 10000 and 15000 and TerritoryID >=5;

SELECT taxamt as tax_amount, salesorderid, shipmethodid
FROM [Sales].[SalesOrderHeader]
WHERE CreditCardID BETWEEN 10000 AND 15000 
  OR TerritoryID >= 5;


select * from [Sales].[SalesOrderHeader]
where RevisionNumber >7
or RevisionNumber <=15;

select * from [Sales].[SalesTaxRate];

select stateprovinceid, taxtype
from [Sales].[SalesTaxRate]
where (Name = 'Canadian GST' OR Name = 'Germany Output Tax')
and (TaxType = 1 or TaxType = 3)
and TaxRate >= 10;


select * from [Production].[Product];

select * from [HumanResources].[Shift];

--FILTERING TEXT/WILD CARDS
--using the WILD CARD operation (% and _) on the Person.Addresstype table

select * from [Person].[AddressType];

select Addresstypeid, [Name]
from [Person].[AddressType]
Where [Name] like 'B%';

select Addresstypeid, [Name]
from [Person].[AddressType]
Where [Name] like 'Ma_'; --No result as the unerscore wild card only checks for 1 argument

select Addresstypeid, [Name]
from [Person].[AddressType]
Where [Name] like 'Ma_%'; -- adding the % wild cards then brings in everything when combined.

--uSING THE NOT LIKE WILD CARD
Select * from [Person].[Password];

Select * from [Person].[Password]
where PasswordHash Not Like '_B%' -- to check the password hash column and remove anything with the second letter being B

Select * from [Person].[Password]
where PasswordSalt Not Like 'A%';

--USING THE IN OPERATOR
Select * from [Person].[Person];

Select FirstName, lastname, middlename as mid
from [Person].[Person]
where Lastname in ('sanchez', 'erickson')
and middlename not like '_e%';--Rows with middlename = NULL are filtered out because NULL NOT LIKE '_e%' evaluates to unknown, not TRUE.

Select count (FirstName) as total_count, lastname, middlename as mid
from [Person].[Person]
where Lastname in ('sanchez', 'erickson')
and middlename not like '_e%'
group by lastname, MiddleName;--All non-aggregated columns in SELECT (like LastName, MiddleName) must be listed in the GROUP BY.

--checking for nulls
Select * from [Person].[Person];

select title, firstname, middlename
from [Person].[Person] 
where suffix is not null;

select title, firstname, middlename
from [Person].[Person] 
where suffix is null;

select count (*) as empty_titles
from [Person].[Person]
where Title is null;

--AGGREGATE FUNCTIONS: SUM, MIN, MAX, COUNT, AVG
SELECT * FROM [Purchasing].[PurchaseOrderHeader];

SELECT SUM(SUBTOTAL) AS TOTAL_SUB
FROM [Purchasing].[PurchaseOrderHeader];

select avg(taxamt) as tax_amount
from [Purchasing].[PurchaseOrderHeader]
where PurchaseOrderID > 5;

select max(subtotal) as max_sub, min(subtotal) as min_sub
from [Purchasing].[PurchaseOrderHeader];

select round(sum(totaldue),-4) as total_4_sum
from [Purchasing].[PurchaseOrderHeader]
where ShipMethodID = 4;

select round(sum(totaldue),0) as total_due_sum
from [Purchasing].[PurchaseOrderHeader]
where ShipMethodID in (3,5);

--round up to the nesrest thoussnd (-3)
select round(sum(totaldue),-3) as total_due_sum
from [Purchasing].[PurchaseOrderHeader]
where ShipMethodID in (3,5);


--ARTHMETIC FUNCTIONS ( +, -, * , and /)
SELECT * FROM [Sales].[SalesOrderHeader];

--to test
select salesorderid, revisionnumber, (salesorderid + revisionnumber) as test
from [Sales].[SalesOrderHeader];

select count (totaldue) * 100/count(*) as percentage_totaldue
from [Sales].[SalesOrderHeader]; --count to see % of rows that are not null

--test
select round(sum(totaldue)/60,-4) as total_4_sum
from [Purchasing].[PurchaseOrderHeader]
where ShipMethodID = 4; --pay very close attention to how this is written compared to the rounds above when putting decimal place rounding after a number

--SORTING AND GROUPING
select * from [Sales].[SalesPerson];

select territoryid, saleslastyear, salesytd
from [Sales].[SalesPerson]
where TerritoryID is not null
order by salesytd desc; 

select businessentityid, sum(Bonus) as totalBonus, TerritoryID
from [Sales].[SalesPerson]
group by BusinessEntityID, TerritoryID
order by territoryid asc, totalBonus desc;

--HAVING
--The HAVING clause is used to filter the results of a GROUP BY query based on aggregate function conditions

select * from [Sales].[SalesPerson];

-- Retrieve the total bonus earned by each salesperson, along with their associated territory
-- Group the data by BusinessEntityID and TerritoryID to calculate total bonuses per salesperson within each territory
-- Include only those salespeople whose total bonus exceeds 4,000 using the HAVING clause
-- The result is sorted first by TerritoryID in ascending order, then by total bonus in descending order
-- This helps identify top-earning salespeople per territory based on bonuses

select businessentityid, sum(Bonus) as totalBonus, TerritoryID
from [Sales].[SalesPerson]
group by BusinessEntityID, TerritoryID
HAVING SUM(BONUS) > 4000
order by territoryid asc, totalBonus desc;


select * from [Sales].[SalesOrderHeader];

-- Retrieve the total order subtotal for each shipping method where specific conditions are met
-- Filters:
--   - Only include orders with a non-null CurrencyRateID (i.e., currency conversion is applicable)
--   - Freight charges must be at least 150
--   - Tax amount must fall between 1000 and 2000
--   - ShipMethodID must be either 3, 4, or 5
-- Group the filtered records by ShipMethodID to compute the total subtotal per shipping method
-- Only include shipping methods where the total subtotal exceeds 10,000
-- Finally, sort the result set by ShipMethodID in ascending order

select Shipmethodid, sum(subtotal) as total_subtotal
from [Sales].[SalesOrderHeader]
where CurrencyRateID is not null
and Freight >= 150 and TaxAmt between 1000 and 2000
and ShipMethodID in (3,4,5)
group by ShipMethodID
having SUM(subtotal) >10000
order by ShipMethodID asc;

--INNER JOIN
--The INNER JOIN keyword selects records that have matching values in both tables.
SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[SalesOrderDetail];

Select ProductID, CarrierTrackingNumber, UnitPrice, SOH.Subtotal, SOH.shipdate
from [Sales].[SalesOrderDetail] as SOD
INNER JOIN [Sales].[SalesOrderHeader] AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID;

SELECT * FROM [Person].[Person];
SELECT * FROM [Sales].[Customer];

Select FirstName, LastName, Sc.storeid, Sc.territoryid
from [Person].[Person] as PP
INNER JOIN [Sales].[Customer] AS Sc
ON pp.businessentityid = sc.PersonID
where sc.storeid is not null; --the where should always come after the all the inner joins

--INNER JOIN / USING
SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[Customer];

Select shipmethodid, taxamt, freight, sc.customerid, sc.storeid
from [Sales].[SalesOrderHeader] as SOH
Inner join [Sales].[Customer] as Sc
USING (Customerid); --this will throw an error message as using does not work in sql ssms

Select shipmethodid, taxamt, freight, sc.customerid, sc.storeid
from [Sales].[SalesOrderHeader] as SOH
Inner join [Sales].[Customer] as Sc
on soh.CustomerID = sc.CustomerID;

--MULTIPLE JOINS
SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[Customer];
SELECT * FROM [Person].[Person];

SELECT status, duedate, shipdate, sc.personid, sc.storeid,pp.firstname, pp.lastname
from [Sales].[SalesOrderHeader] as soh
inner join [Sales].[Customer] as sc
on soh.CustomerID = sc.CustomerID
inner join [Person].[Person] as pp
on sc.PersonID = pp.BusinessEntityID
where sc.StoreID is not null;

--Joining more than 3 tables
SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[SalesOrderDetail];
SELECT * FROM [Production].[Product];
SELECT * FROM [Production].[ProductSubcategory];

Select orderdate, duedate, shipdate, sod.unitprice, sod.orderqty, prp.[name],
prp.[productnumber], prps.productcategoryid
from [Sales].[SalesOrderHeader] as soh
inner join [Sales].[SalesOrderDetail] as sod
on soh.SalesOrderID = sod.SalesOrderID
inner join [Production].[Product] as prp
on sod.ProductID = prp.ProductID
inner join [Production].[ProductSubcategory] as prps
on prp.ProductSubcategoryID = prps.ProductSubcategoryID
order by sod.OrderQty desc;

--Joining on Multiple Keys
SELECT * FROM [Sales].[SalesOrderHeader];
Select * from [Person].[Address];


select salesorderid, territoryid, CreditCardApprovalCode, pa.addressline1, pa.city, pa.stateprovinceid
from [Sales].[SalesOrderHeader] soh
inner join [Person].[Address] pa
on soh.ShipToAddressID = pa.AddressID
and soh.BillToAddressID = pa.AddressID;

--LEFT JOIN
--The LEFT JOIN keyword returns all records from the left table (table1), and the matching records 
--from the right table (table2). The result is 0 records from the right side, if there is no match.

SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[Customer];

Select shipmethodid, taxamt, freight, sc.customerid, sc.storeid
from [Sales].[SalesOrderHeader] as SOH
left join [Sales].[Customer] as Sc
on soh.CustomerID = sc.CustomerID;

Select shipmethodid, round(sum(taxamt),0) as total_taxamt, freight, sc.customerid, sc.storeid
from [Sales].[SalesOrderHeader] as SOH
left join [Sales].[Customer] as Sc
on soh.CustomerID = sc.CustomerID
group by soh.shipmethodid, soh.Freight, sc.customerid, sc.storeid
having round(sum(taxamt),0) > 1000
order by total_taxamt desc;

--RIGHT JOIN
SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[Customer];
SELECT * FROM [Person].[Person];

SELECT status, duedate, shipdate, sc.personid, sc.storeid,pp.firstname, pp.lastname
from [Sales].[SalesOrderHeader] as soh
Right join [Sales].[Customer] as sc
on soh.CustomerID = sc.CustomerID
Right join [Person].[Person] as pp
on sc.PersonID = pp.BusinessEntityID
where DueDate is not null
and ShipDate is not null; --notice that i did not have to put the soh alias here and on ship date as i am using the from syntax on the table that houses them

--FULL JOIN
--The FULL OUTER JOIN keyword returns all records when there is a match in left (table1) or right (table2) table records.
--Tip: FULL OUTER JOIN and FULL JOIN are the same.

SELECT * FROM [Sales].[SalesPerson];
SELECT * FROM [HumanResources].[Employee];

select * from [Sales].[SalesPerson] as ssp
full join [HumanResources].[Employee] as he
on ssp.BusinessEntityID = he.BusinessEntityID;


SELECT top 5 salesytd, count(distinct ssp.BusinessEntityID) as Unique_bid, he.jobtitle
from [Sales].[SalesPerson] as ssp
full join [HumanResources].[Employee] as he
on ssp.BusinessEntityID = he.BusinessEntityID
group by SalesYTD, he.JobTitle
order by SalesYTD desc;

select jobtitle, birthdate, maritalstatus, ssp.bonus
from [HumanResources].[Employee] as he
full join [Sales].[SalesPerson] as ssp
on he.BusinessEntityID = ssp.BusinessEntityID
where JobTitle like '%Engineer';

--CROSS JOIN
--The CROSS JOIN keyword returns all records from both tables (table1 and table2).
--You do not need to use the ON clause here
--CROSS JOIN simply creates a Cartesian product (all possible row combinations) between the two tables.
--It doesn’t require or allow a join condition.
SELECT * FROM [Production].[Product];
SELECT * FROM [Sales].[Currency];

Select P.Name, P.ProductNumber, sc.currencycode
from [Production].[Product] as P
Cross Join  [Sales].[Currency] as sc
--where p.ReorderPoint <600;

--CROSS JOIN MULTIPLE TABLES
SELECT * FROM [HumanResources].[Shift];
SELECT * FROM [Person].[AddressType];

select * from
[Production].[Product]
cross join [Sales].[Currency]
cross join [HumanResources].[Shift]
cross join [Person].[AddressType];


SELECT AVG (P.SAFETYSTOCKLEVEL) as Avg_safetystock, p.Name, ProductNumber, hs.Name, pa.name, sc.name
FROM [Production].[Product] as p
cross join [HumanResources].[Shift] as hs
cross join [Person].[AddressType] as pa
cross join [Sales].[Currency] as sc
where hs.name in ('Day', 'Night') -- where shpuld always come before group by and order by
group by p.Name, ProductNumber, hs.Name, pa.name, sc.name
having avg (p.safetystocklevel) >= 200
order by p.name;

--SELF JOIN
--A self join is a regular join, but the table is joined with itself.

SELECT * FROM [HumanResources].[Employee];

SELECT 
    E.BusinessEntityID AS EmployeeID,
    E.JobTitle AS EmployeeTitle,
    M.BusinessEntityID AS ManagerID,
    M.JobTitle AS ManagerTitle,
    MM.BusinessEntityID AS TopManagerID,
    MM.JobTitle AS TopManagerTitle
FROM 
    HumanResources.Employee AS E
LEFT JOIN 
    HumanResources.Employee AS M   -- Manager
    ON E.OrganizationNode.GetAncestor(1) = M.OrganizationNode
LEFT JOIN 
    HumanResources.Employee AS MM  -- Manager's Manager
    ON M.OrganizationNode.GetAncestor(1) = MM.OrganizationNode;


SELECT 
    Emp.BusinessEntityID AS EmployeeID,
    Emp.JobTitle,
    Manager.BusinessEntityID AS ManagerID,
    Manager.JobTitle AS ManagerTitle
FROM 
    HumanResources.Employee AS Emp
INNER JOIN 
    HumanResources.Employee AS Manager
    ON Emp.OrganizationNode = Manager.OrganizationNode
--AND  Emp.OrganizationNode <> Manager.OrganizationNode; (NO RESULT CAME OUT AFTER THIS


--UNION AND UNION ALL
--The UNION operator is used to combine the result-set of two or more SELECT statements.
--Every SELECT statement within UNION must have the same number of columns
--The columns must also have similar data types
--The columns in every SELECT statement must also be in the same order


--UNION
SELECT * FROM [Purchasing].[PurchaseOrderHeader];
SELECT * FROM [Sales].[SalesOrderHeader];

SELECT ORDERDATE, SUBTOTAL, TAXAMT, PPO.FREIGHT
FROM [Purchasing].[PurchaseOrderHeader] AS PPO
UNION
SELECT ORDERDATE, SUBTOTAL, TAXAMT, FREIGHT
FROM [Sales].[SalesOrderHeader];


SELECT ORDERDATE, SUBTOTAL, TAXAMT, PPO.FREIGHT
FROM [Purchasing].[PurchaseOrderHeader] AS PPO
WHERE FREIGHT IS NOT NULL-- NOTICE I KEPT THE WHERE EACH SELECT FROM STATEMENT SHOULD HAVE THEIR OWN WHERE CLAUSES INDEPENDENTLY
UNION
SELECT ORDERDATE, SUBTOTAL, TAXAMT, FREIGHT
FROM [Sales].[SalesOrderHeader];

--UNION ALL
--The UNION ALL command combines the result set of two or more SELECT statements (allows duplicate values).
SELECT * FROM [Production].[ProductCostHistory];
SELECT * FROM [Production].[ProductListPriceHistory];

--TESTING THIS OUT
SELECT PRODUCTID, STARTDATE, ENDDATE, STANDARDCOST AS PRICE, MODIFIEDDATE
FROM [Production].[ProductCostHistory]
WHERE ENDDATE IS NOT NULL
UNION ALL 
SELECT PRODUCTID, STARTDATE, ENDDATE, LISTPRICE, MODIFIEDDATE
FROM [Production].[ProductListPriceHistory]
WHERE ENDDATE IS NOT NULL
ORDER BY ProductID; --Notice that you can use order by after the union operator has been perfrormed

--INTERCEPT
--The INTERSECT operator in SQL is used to retrieve the records that are identical/common between the result sets of two or more tables.
SELECT * FROM [Sales].[SalesPerson];
SELECT * FROM [Sales].[SalesPersonQuotaHistory];

--This is a test
SELECT BUSINESSENTITYID
FROM [Sales].[SalesPerson]
intersect
select BUSINESSENTITYID
from [Sales].[SalesPersonQuotaHistory];

SELECT BUSINESSENTITYID
FROM [Sales].[SalesPerson]
where TerritoryID is not null --you can use a where clause from another column, just make sure that what is being intercected is the same column/data type on both tables
intersect
select BUSINESSENTITYID
from [Sales].[SalesPersonQuotaHistory]
order by BusinessEntityID;

--EXCEPT
--The SQL EXCEPT operator is used to return the rows from the first SELECT statement that are not present in the second SELECT statement. 
--This operator is conceptually similar to the subtract operator in relational algebra. 
--It is particularly useful for excluding specific data from your result set.

SELECT * FROM [Person].[Address];
select * from [Person].[BusinessEntityAddress];

SELECT ADDRESSID
FROM [Person].[Address]
EXCEPT 
SELECT ADDRESSID
FROM [Person].[BusinessEntityAddress]; --RETURNED EMOTY COS EVERYTHING IN THE LEFT TABLE EXISTS IN THE RIGHT TABLE

--SUBQUERIES
--a subquery can be defined as a query embedded within another query.
--We have Semi Join and Anti Join.

--SEMI JOIN
SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[Customer];
--CONNECTING COLUMN IS CUSTOMERID

SELECT * FROM [Sales].[SalesOrderHeader]
WHERE CustomerID IN
    (SELECT CUSTOMERID FROM
    [Sales].[Customer]
    WHERE PersonID IS NOT NULL);

SELECT STOREID, TERRITORYID
FROM [Sales].[Customer]
WHERE TERRITORYID > 4
AND CUSTOMERID IN
    (SELECT CustomerID
    FROM [Sales].[SalesOrderHeader]
    WHERE STATUS = 5
    AND SalesOrderID > 75000); --RETURNED NO RESULT. LET ME CHANGE THE ALIGNMENT


SELECT SALESORDERID, ORDERDATE, DUEDATE, ONLINEORDERFLAG
FROM [Sales].[SalesOrderHeader]
WHERE STATUS >= 5
    AND SalesOrderID > 75000
    AND CustomerID IN
        (SELECT CUSTOMERID FROM
        [Sales].[Customer]
        WHERE TerritoryID > 3)
        ORDER BY STATUS;

--ANTI JOIN
SELECT * FROM [Production].[Product];
SELECT * FROM [Production].[ProductSubcategory];
--Connecting column: ProductSubcategoryID


SELECT PRODUCTID, [NAME], COLOR
FROM [Production].[Product]
WHERE SIZE IS NOT NULL
AND ProductSubcategoryID NOT IN
    (SELECT ProductSubcategoryID
    FROM [Production].[ProductSubcategory]
    WHERE NAME like '%Chains');

SELECT ProductID, Name
FROM Production.Product
WHERE ProductSubcategoryID NOT IN (
    SELECT ProductSubcategoryID
    FROM Production.ProductSubcategory
);-- did not brign up a result


--SUBQUERIES WITH WHERE STATEMENT (SIMILAR TO WHAT WE HAVE DONE ABOVE)
--Use it when:
--You want to filter rows from your main table based on whether a condition is met in another table.
--Typical use cases:
--Check if a value exists (or doesn’t exist) in another table.
--Filter data based on a relationship.

SELECT * FROM [Production].[Product];
SELECT * FROM [Sales].[SalesOrderDetail];

SELECT 
    ProductID, 
    Name
FROM [Production].[Product]
WHERE ProductID IN (
    SELECT ProductID
    FROM [Sales].[SalesOrderDetail]
    where color is not null
);

--SUBQUERIES WITH SELECT STATEMENT

SELECT 
    ProductID, 
    Name,
    (SELECT SUM(OrderQty) 
     FROM [Sales].[SalesOrderDetail] SOD
     WHERE SOD.ProductID = P.ProductID) AS TotalQtySold
FROM [Production].[Product] P;


--to remove the null values
--Use ISNULL or most popularly, use COALESCE
SELECT 
    ProductID, 
    Name,
    ISNULL((
        SELECT SUM(OrderQty) 
        FROM [Sales].[SalesOrderDetail] SOD
        WHERE SOD.ProductID = P.ProductID
    ), 0) AS TotalQtySold
FROM [Production].[Product] P;


--CASE
--The CASE command is used is to create different output based on conditions.

SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[Customer];

--Add a column indicating if the order is online or not.
SELECT 
    SalesOrderID,
    OrderDate,
    -- Simple CASE to show if the order was placed online or offline
    CASE 
        WHEN OnlineOrderFlag = 1 THEN 'Online'
        ELSE 'Offline'
    END AS OrderType
FROM [Sales].[SalesOrderHeader];

--Classify orders by status (shipped, canceled, in process, etc.).
SELECT 
    SalesOrderID,
    Status,
    -- CASE for descriptive order status
    CASE 
        WHEN Status = 1 THEN 'In Process'
        WHEN Status = 2 THEN 'Approved'
        WHEN Status = 3 THEN 'Backordered'
        WHEN Status = 4 THEN 'Rejected'
        WHEN Status = 5 THEN 'Shipped'
        WHEN Status = 6 THEN 'Canceled'
        ELSE 'Unknown'
    END AS OrderStatusDescription
FROM [Sales].[SalesOrderHeader];


--Using AND in a CASE statement
SELECT 
    SalesOrderID,
    SubTotal,
    -- Use AND to check multiple conditions
    CASE 
        WHEN SubTotal > 1000 AND SubTotal < 5000 THEN 'Medium Order'
        WHEN SubTotal >= 5000 THEN 'Large Order'
        ELSE 'Small Order'
    END AS OrderSize
FROM [Sales].[SalesOrderHeader];


--Using BETWEEN in a CASE statement
SELECT 
    SalesOrderID,
    SubTotal,
    -- Use BETWEEN for range checks
    CASE 
        WHEN SubTotal BETWEEN 1000 AND 4999 THEN 'Medium Order'
        WHEN SubTotal >= 5000 THEN 'Large Order'
        ELSE 'Small Order'
    END AS OrderSize
FROM [Sales].[SalesOrderHeader];



--Classify orders by value and shipping method
SELECT 
    SalesOrderID,
    SubTotal,
    ShipMethodID,
    -- Complex CASE to label high-value, medium, or low-value and special shipping
    CASE 
        WHEN SubTotal > 10000 AND ShipMethodID = 4 THEN 'High Value - Express Shipping'
        WHEN SubTotal > 10000 THEN 'High Value'
        WHEN SubTotal BETWEEN 5000 AND 10000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS OrderCategory
FROM [Sales].[SalesOrderHeader];


--Using Case "When" with Join
SELECT 
    SOH.SalesOrderID,
    SOH.OrderDate,
    C.CustomerID,
    C.PersonID,
    -- Simple CASE: Label order as 'Store Customer' or 'Individual'
    CASE 
        WHEN C.PersonID IS NULL THEN 'Store Customer'
        ELSE 'Individual'
    END AS CustomerType,
    -- Complex CASE: Order-Channel combined with customer type
    CASE 
        WHEN SOH.OnlineOrderFlag = 1 AND C.PersonID IS NOT NULL THEN 'Online Individual Order'
        WHEN SOH.OnlineOrderFlag = 1 AND C.PersonID IS NULL THEN 'Online Store Order'
        WHEN SOH.OnlineOrderFlag = 0 AND C.PersonID IS NOT NULL THEN 'Offline Individual Order'
        ELSE 'Offline Store Order'
    END AS ChannelCustomerType
FROM [Sales].[SalesOrderHeader] SOH
INNER JOIN [Sales].[Customer] C
    ON SOH.CustomerID = C.CustomerID;


--Add a flag to show if a customer has an individual record (PersonID not null):
SELECT
    soh.SalesOrderID,
    soh.OrderDate,
    c.CustomerID,
    -- LEFT JOIN allows us to catch SalesOrderHeader records without a matching customer
    CASE
        WHEN c.CustomerID IS NULL THEN 'No Customer'
        WHEN c.PersonID IS NOT NULL THEN 'Individual Customer'
        ELSE 'Store Customer'
    END AS CustomerStatus
FROM [Sales].[SalesOrderHeader] soh
LEFT JOIN [Sales].[Customer] c
    ON soh.CustomerID = c.CustomerID;


--SGroup orders by status and show the count of each status, ordered by count descending
SELECT
    -- Use CASE to create readable status names
    CASE
        WHEN Status = 1 THEN 'In Process'
        WHEN Status = 2 THEN 'Approved'
        WHEN Status = 3 THEN 'Backordered'
        WHEN Status = 4 THEN 'Rejected'
        WHEN Status = 5 THEN 'Shipped'
        WHEN Status = 6 THEN 'Canceled'
        ELSE 'Other'
    END AS StatusDescription,
    COUNT(*) AS OrderCount
FROM [Sales].[SalesOrderHeader]
GROUP BY
    CASE
        WHEN Status = 1 THEN 'In Process'
        WHEN Status = 2 THEN 'Approved'
        WHEN Status = 3 THEN 'Backordered'
        WHEN Status = 4 THEN 'Rejected'
        WHEN Status = 5 THEN 'Shipped'
        WHEN Status = 6 THEN 'Canceled'
        ELSE 'Other'
    END
ORDER BY OrderCount DESC; -- only returns result for 5 as thats the only status it is seeing


--CASE, FILTER (WHERE), JOIN
--Find orders from 2013 or 2014, and label each as ‘Store’ or ‘Individual’:
SELECT
    soh.SalesOrderID,
    soh.OrderDate,
    c.CustomerID,
    CASE
        WHEN c.PersonID IS NULL THEN 'Store'
        ELSE 'Individual'
    END AS CustomerType
FROM [Sales].[SalesOrderHeader] soh
INNER JOIN [Sales].[Customer] c
    ON soh.CustomerID = c.CustomerID
WHERE
    YEAR(soh.OrderDate) = 2013 OR YEAR(soh.OrderDate) = 2014;


    --uSING from in Case
    --A subquery in the FROM clause acts like a temporary table for your outer query, letting you build on summarized or filtered results.
    --When you place a SELECT statement inside the FROM clause, it’s called a subquery in the FROM clause or an inline view or derived table.
SELECT 
    c.CustomerID,
    c.PersonID,
    c.StoreID,
    summary.LargeOrderCount
FROM [Sales].[Customer] c
INNER JOIN (
    SELECT 
        CustomerID, 
        COUNT(*) AS LargeOrderCount
    FROM [Sales].[SalesOrderHeader]
    WHERE SubTotal >= 10000
    GROUP BY CustomerID
) AS summary
    ON c.CustomerID = summary.CustomerID
ORDER BY summary.LargeOrderCount DESC;


--CASE STATEMENTS WITH AGGREGATE FUNCTIONS (ALREADY WORKED ON SOME ABOVE)
SELECT * FROM [Production].[Product];
SELECT * FROM [Sales].[SalesOrderDetail];


--CASE with Aggregate (AVG) 
--Label products based on whether their StandardCost is above or below the average
SELECT
    ProductID,
    Name,
    StandardCost,
    -- Compare each product's StandardCost to the rounded average cost
    CASE
        WHEN StandardCost > (
            SELECT AVG(StandardCost) FROM [Production].[Product]
        ) THEN 'Above Average Cost'
        ELSE 'Average or Below'
    END AS CostCategory
FROM [Production].[Product];


-- CASE with COUNT (e.g., count how many products are above/below average cost)
SELECT
    COUNT(CASE 
        WHEN p.StandardCost > a.AvgCost THEN 1
        ELSE NULL
    END) AS AboveAvgCount,
    COUNT(CASE 
        WHEN p.StandardCost <= a.AvgCost THEN 1
        ELSE NULL
    END) AS AtOrBelowAvgCount
FROM [Production].[Product] p,
     (SELECT AVG(StandardCost) AS AvgCost FROM [Production].[Product]) a;


 --Sum order quantities by 'Bulk' or 'Regular'
 SELECT
    SUM(CASE
        WHEN OrderQty >= 1 THEN OrderQty
        ELSE 0
    END) AS BulkOrderQty,
    
    SUM(CASE
        WHEN OrderQty < 100 THEN OrderQty
        ELSE 0
    END) AS RegularOrderQty
FROM [Sales].[SalesOrderDetail];


--CASE using Percentage (OrderQty vs. SUM for the same order)
--Show each item's quantity as a percentage of the total quantity in its order, and label as 'Major Contribution' if above 50%
SELECT
    SalesOrderID,
    ProductID,
    OrderQty,
    -- Percentage calculation for this item's quantity vs. total for the order
    ROUND(
        100.0 * OrderQty / 
        (SELECT SUM(OrderQty) FROM [Sales].[SalesOrderDetail] sod2 
         WHERE sod2.SalesOrderID = sod.SalesOrderID), 2
    ) AS QtyPercentOfOrder,
    CASE
        WHEN OrderQty >= 0.5 * 
            (SELECT SUM(OrderQty) FROM [Sales].[SalesOrderDetail] sod2 
             WHERE sod2.SalesOrderID = sod.SalesOrderID)
            THEN 'Major Contribution'
        ELSE 'Minor Contribution'
    END AS ContributionCategory
FROM [Sales].[SalesOrderDetail] sod; -- DO MORE RESEARCH ON THIS


--MORE SUBQUERIES
SELECT * FROM [Sales].[SalesOrderDetail];

--subqueries in where
-- Find all order details where the line total is greater than the average line total
SELECT *
FROM [Sales].[SalesOrderDetail]
WHERE LineTotal > (
    SELECT AVG(LineTotal) FROM [Sales].[SalesOrderDetail]
);


-- Find all order details where the unit price is greater than the sum of all unit prices divided by 500000
SELECT *
FROM [Sales].[SalesOrderDetail]
WHERE UnitPrice > (
    SELECT SUM(UnitPrice) / 500000 FROM [Sales].[SalesOrderDetail]
);


--SUBQUERIES (FROM)
--Get average line total per product, then add product name from Product table.
-- Subquery calculates average line total per ProductID

SELECT * FROM [Sales].[SalesOrderDetail];
SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Production].[Product];


SELECT 
    p.Name AS ProductName,
    sub.AvgLineTotal
FROM (
    SELECT 
        ProductID,
        AVG(LineTotal) AS AvgLineTotal
    FROM [Sales].[SalesOrderDetail]
    GROUP BY ProductID
) AS sub
INNER JOIN [Production].[Product] p
    ON sub.ProductID = p.ProductID;


--Get total sales value per year, for years with sales over $5,000,000.
-- Subquery joins Detail and Header, aggregates by year, and then outer query filters by sales threshold
SELECT 
    Year,
    TotalSales
FROM (
    SELECT 
        YEAR(h.OrderDate) AS Year,
        SUM(d.LineTotal) AS TotalSales
    FROM [Sales].[SalesOrderDetail] d
    INNER JOIN [Sales].[SalesOrderHeader] h
        ON d.SalesOrderID = h.SalesOrderID
    GROUP BY YEAR(h.OrderDate)
) AS yearly
WHERE yearly.TotalSales > 5000000
ORDER BY yearly.TotalSales DESC;


--Find each customer’s total order count.
SELECT 
    c.CustomerID,
    sub.OrderCount
FROM [Sales].[Customer] c
INNER JOIN (
    SELECT 
        CustomerID, 
        COUNT(*) AS OrderCount
    FROM [Sales].[SalesOrderHeader]
    GROUP BY CustomerID
) AS sub
    ON c.CustomerID = sub.CustomerID;
-- Shows customers and how many orders they've placed


--Moderate: Average Subtotal per Store, only for stores with more than 10 orders
SELECT 
    store.StoreID,
    sub.AvgSubtotal
FROM (
    SELECT 
        CustomerID,
        ROUND(AVG(SubTotal),2) AS AvgSubtotal
    FROM [Sales].[SalesOrderHeader]
    GROUP BY CustomerID
    HAVING COUNT(*) > 10
) AS sub
INNER JOIN [Sales].[Customer] store
    ON sub.CustomerID = store.CustomerID
WHERE store.StoreID IS NOT NULL;
-- Shows stores with their average order subtotal, only if they've placed > 10 orders


--Find the top 5 products by total sales value
SELECT TOP 5
    p.Name AS ProductName,
    prod_sales.TotalSales
FROM (
    SELECT 
        ProductID,
        SUM(LineTotal) AS TotalSales
    FROM [Sales].[SalesOrderDetail]
    GROUP BY ProductID
) AS prod_sales
INNER JOIN [Production].[Product] p
    ON prod_sales.ProductID = p.ProductID
ORDER BY prod_sales.TotalSales DESC;
-- Returns the top 5 selling products by sales value


--SUBQUERIES (SELECT)

--Show each customer and how many orders they have placed (using a subquery in SELECT):
SELECT 
    CustomerID,
    -- Subquery counts number of orders for each customer
    (SELECT COUNT(*) 
     FROM [Sales].[SalesOrderHeader] soh 
     WHERE soh.CustomerID = c.CustomerID
    ) AS OrderCount
FROM [Sales].[Customer] c;


--Show each product and the average order quantity for that product (subquery in SELECT)
SELECT
    ProductID,
    Name,
    -- Subquery computes average ordered quantity per product
    (SELECT AVG(OrderQty)
     FROM [Sales].[SalesOrderDetail] sod
     WHERE sod.ProductID = p.ProductID
    ) AS AvgOrderQty
FROM [Production].[Product] p
WHERE Avgorderqty is not null; --this would give an error as sql does not allow one to use alias in a where statenent. You must doma CTE

--correct quwry wothout the where
SELECT
    ProductID,
    Name,
    -- Subquery computes average ordered quantity per product
    (SELECT AVG(OrderQty)
     FROM [Sales].[SalesOrderDetail] sod
     WHERE sod.ProductID = p.ProductID
    ) AS AvgOrderQty
FROM [Production].[Product] p;


--Show each order, the total value of that order, and the percentage of that order’s value vs. the largest order value (mathematical calculation in subquery)
SELECT
    SalesOrderID,
    -- Subquery calculates the total value of the current order
    (SELECT SUM(LineTotal)
     FROM [Sales].[SalesOrderDetail] sod
     WHERE sod.SalesOrderID = soh.SalesOrderID
    ) AS OrderTotal,
    -- Subquery calculates the max order total, used to compute percentage
    ROUND(
        100.0 * 
        (SELECT SUM(LineTotal)
         FROM [Sales].[SalesOrderDetail] sod
         WHERE sod.SalesOrderID = soh.SalesOrderID
        ) /
        (SELECT MAX(TotalOrderValue)
         FROM (
             SELECT SalesOrderID, SUM(LineTotal) AS TotalOrderValue
             FROM [Sales].[SalesOrderDetail]
             GROUP BY SalesOrderID
         ) maxvals
        )
    , 2) AS PercentOfMaxOrder
FROM [Sales].[SalesOrderHeader] soh;


--CORRELATED SUBQUERIES
--Find all products whose list price is higher than the average list price of products in the same subcategory.
SELECT * FROM [Production].[Product];

--Find all products whose list price is higher than the average list price of products in the same product subcategory.
SELECT 
    ProductID,
    Name,
    ListPrice,
    ProductSubcategoryID
FROM [Production].[Product] p
WHERE ListPrice > (
    SELECT AVG(ListPrice)
    FROM [Production].[Product] p2
    WHERE p2.ProductSubcategoryID = p.ProductSubcategoryID
);--For each order line, SQL checks if the quantity is above the average for that order.


--Find customers who have placed at least one order with a total value greater than the average order value across all orders.
SELECT * FROM [Sales].[Customer]
SELECT * FROM [Sales].[SalesOrderHeader]
SELECT * FROM [Sales].[SalesOrderDetail]

SELECT 
    c.CustomerID,
    c.PersonID,
    c.StoreID
FROM [Sales].[Customer] c
WHERE EXISTS (
    SELECT 1
    FROM [Sales].[SalesOrderHeader] h
    WHERE h.CustomerID = c.CustomerID
      AND (
        SELECT SUM(LineTotal)
        FROM [Sales].[SalesOrderDetail] d
        WHERE d.SalesOrderID = h.SalesOrderID
      ) > (
        SELECT AVG(OrderTotal)
        FROM (
          SELECT SUM(LineTotal) AS OrderTotal
          FROM [Sales].[SalesOrderDetail]
          GROUP BY SalesOrderID
        ) sub
      ) AND C.StoreID IS NOT NULL
);

--NESTED SUBQUERIES
/* A nested query (also called a subquery) is a query embedded within another SQL query. 
The result of the inner query is used by the outer query to perform additional operations. 
Subqueries can be used in various parts of an SQL query such as SELECT, FROM or WHERE Clauses.*/

--Find products above overall average cost
SELECT * FROM [Production].[Product];

SELECT ProductID, Name, StandardCost
FROM [Production].[Product]
WHERE StandardCost > (
    SELECT AVG(StandardCost)
    FROM [Production].[Product]
);


--Find customers whose order count is above the average order count
--Subquery inside a subquery!
SELECT * FROM [Sales].[SalesOrderHeader];

SELECT CustomerID
FROM (
    SELECT CustomerID, COUNT(*) AS OrderCount
    FROM [Sales].[SalesOrderHeader]
    GROUP BY CustomerID
) AS customer_orders
WHERE OrderCount > (
    SELECT AVG(OrderCount)
    FROM (
        SELECT CustomerID, COUNT(*) AS OrderCount
        FROM [Sales].[SalesOrderHeader]
        GROUP BY CustomerID
    ) AS customer_orders_inner
);


-- Find the product(s) with the highest total sales value
--Deeply nested for max total sales.

SELECT * FROM [Sales].[SalesOrderDetail];

SELECT ProductID, TotalSales
FROM (
    SELECT ProductID, SUM(LineTotal) AS TotalSales
    FROM [Sales].[SalesOrderDetail]
    GROUP BY ProductID
) AS prod_sales
WHERE TotalSales = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT ProductID, SUM(LineTotal) AS TotalSales
        FROM [Sales].[SalesOrderDetail]
        GROUP BY ProductID
    ) AS max_sales
);


--ind the year with the highest average order value and display total sales for that year
--Nested subqueries for year, average, and final sales.

SELECT * FROM [Sales].[SalesOrderDetail];
SELECT * FROM [Sales].[SalesOrderHeader];

SELECT Year, TotalSales
FROM (
    SELECT 
        YEAR(h.OrderDate) AS Year,
        SUM(d.LineTotal) AS TotalSales,
        AVG(d.LineTotal) AS AvgOrderValue
    FROM [Sales].[SalesOrderHeader] h
    INNER JOIN [Sales].[SalesOrderDetail] d
        ON h.SalesOrderID = d.SalesOrderID
    GROUP BY YEAR(h.OrderDate)
) AS yearly
WHERE AvgOrderValue = (
    SELECT MAX(AvgOrderValue)
    FROM (
        SELECT 
            YEAR(h.OrderDate) AS Year,
            AVG(d.LineTotal) AS AvgOrderValue
        FROM [Sales].[SalesOrderHeader] h
        INNER JOIN [Sales].[SalesOrderDetail] d
            ON h.SalesOrderID = d.SalesOrderID
        GROUP BY YEAR(h.OrderDate)
    ) AS avgvals
);



--COMMON TABLE EXPRESSIONS (CTEs)
/*In SQL, a Common Table Expression (CTE) is an essential tool for simplifying complex queries and making them more readable. 
By defining temporary result sets that can be referenced multiple times, a CTE in SQL allows developers to break down complicated logic into manageable parts. 
CTEs help with hierarchical data representation, improve code reusability, and simplify maintenance.*/

SELECT * FROM [Production].[Product];
SELECT * FROM [Sales].[SalesOrderDetail];
SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[Customer];


--Average Product Cost
WITH AvgCost AS (
    SELECT AVG(StandardCost) AS AvgStandardCost
    FROM [Production].[Product]
)
SELECT *
FROM AvgCost;


--Top 5 Selling Products by Sales Value
WITH ProductSales AS (
    SELECT 
        ProductID, 
        SUM(LineTotal) AS TotalSales
    FROM [Sales].[SalesOrderDetail]
    GROUP BY ProductID
)
SELECT TOP 5 
    ps.ProductID,   -- changed from p.ProductID to ps.ProductID
    pr.Name, 
    ps.TotalSales
FROM ProductSales ps
INNER JOIN [Production].[Product] pr
    ON ps.ProductID = pr.ProductID
ORDER BY ps.TotalSales DESC;


--Orders per Customer
WITH CustomerOrderCounts AS (
    SELECT 
        CustomerID,
        COUNT(*) AS OrderCount
    FROM [Sales].[SalesOrderHeader]
    GROUP BY CustomerID
)
SELECT 
    c.CustomerID,
    c.PersonID,
    coc.OrderCount
FROM [Sales].[Customer] c
LEFT JOIN CustomerOrderCounts coc
    ON c.CustomerID = coc.CustomerID
 WHERE C.PersonID IS NOT NULL;


 --Yearly Sales Summary
 WITH YearlySales AS (
    SELECT 
        YEAR(h.OrderDate) AS SalesYear,
        SUM(d.LineTotal) AS TotalSales
    FROM [Sales].[SalesOrderHeader] h
    INNER JOIN [Sales].[SalesOrderDetail] d
        ON h.SalesOrderID = d.SalesOrderID
    GROUP BY YEAR(h.OrderDate)
)
SELECT *
FROM YearlySales
ORDER BY TotalSales DESC;


--Get Year and Month from Orders
SELECT * FROM [Sales].[SalesOrderHeader];

WITH OrderDates AS (
    SELECT
        SalesOrderID,
        OrderDate,
        YEAR(OrderDate) AS OrderYear,
        MONTH(OrderDate) AS OrderMonth
    FROM [Sales].[SalesOrderHeader]
)
SELECT *
FROM OrderDates;


--Get Year/Month from Employee Hire Date
SELECT * FROM[HumanResources].[Employee];

WITH EmployeeHireDates AS (
    SELECT
        BusinessEntityID,
        JobTitle,
        HireDate,
        YEAR(HireDate) AS HireYear,
        MONTH(HireDate) AS HireMonth
    FROM [HumanResources].[Employee]
)
SELECT *
FROM EmployeeHireDates;


--WINDOWS FUNCTIONS
/*SQL window functions are essential for advanced data analysis and database management. 
It is a type of function that allows us to perform calculations across a specific set of rows related to the current row. 
These calculations happen within a defined window of data and they are particularly useful for aggregates, rankings and cumulative totals without modifying the dataset.*/

/*RANK(): Assigns ranks to rows, skipping ranks for duplicates.
DENSE_RANK(): Assigns ranks to rows without skipping rank numbers for duplicates.
ROW_NUMBER(): Assigns a unique number to each row in the result set.*/

/* The OVER clause is used in SQL to specify the partitioning, ordering and window "over which" the analytic function operates. 
It is used to determine which rows from the query are applied to the function, what order they are evaluated in by that function, and when the function’s calculations should restart.*/

--Get a row number for every order
SELECT * FROM [Sales].[SalesOrderHeader];

SELECT 
    SalesOrderID,
    OrderDate,
    ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNum
FROM [Sales].[SalesOrderHeader]; --Numbers each order based on the order date.


--Rank orders from highest to lowest subtotal
SELECT 
    SalesOrderID,
    SubTotal,
    RANK() OVER (ORDER BY SubTotal DESC) AS SubtotalRank
FROM [Sales].[SalesOrderHeader]; --Assigns a rank based on order subtotal.


--Assigns the same rank for ties in product prices:
SELECT * FROM [Production].[Product];

SELECT 
    ProductID,
    Name,
    ListPrice,
    DENSE_RANK() OVER (ORDER BY ListPrice DESC) AS PriceRank
FROM [Production].[Product]; --If two products have the same price, they get the same rank, and the next rank is not skipped.


--Calculate a cumulative sum of sales line totals

SELECT * FROM [Sales].[SalesOrderDetail];

SELECT 
    SalesOrderID,
    LineTotal,
    SUM(LineTotal) OVER (ORDER BY SalesOrderID) AS RunningTotal
FROM [Sales].[SalesOrderDetail]; --Shows a running total as you go through the order details.


--PARTITION BY AND OVER
/*  the PARTITION BY clause is used with window functions to divide a result set into subsets, or "partitions," based on one or more columns. 
Each partition is processed independently by the window function, allowing calculations like rankings, 
running totals, or averages to be applied within each subset rather than across the entire dataset.*/


--Rank each product’s sales lines by line total, restarting the rank for each product:
SELECT * FROM [Sales].[SalesOrderDetail];

SELECT 
    ProductID,
    SalesOrderID,
    LineTotal,
    RANK() OVER (
        PARTITION BY ProductID 
        ORDER BY LineTotal DESC
    ) AS ProductLineRank
FROM [Sales].[SalesOrderDetail]; --Ranks line items for each product separately, from largest to smallest line total.


--Row Number per Customer
--Assign a row number to each order, starting at 1 for each customer.
SELECT * FROM [Sales].[SalesOrderHeader];

SELECT
    CustomerID,
    SalesOrderID,
    OrderDate,
    ROW_NUMBER() OVER (
        PARTITION BY CustomerID 
        ORDER BY OrderDate
    ) AS OrderSeq
FROM [Sales].[SalesOrderHeader];--This resets the row numbering for each customer, showing the sequence of their orders by date.



--Running Total of LineTotal per Order
--Calculate a running total of line items within each order.
SELECT * FROM [Sales].[SalesOrderDetail];

SELECT
    SalesOrderID,
    ProductID,
    LineTotal,
    SUM(LineTotal) OVER (
        PARTITION BY SalesOrderID 
        ORDER BY ProductID
    ) AS RunningLineTotal
FROM [Sales].[SalesOrderDetail];--For each order, this sums up LineTotal as you move through the products in that order.



--Average LineTotal per Product and Rank Each Line
--Compute the average line total for each product and rank order lines by LineTotal within each product.
SELECT * FROM [Sales].[SalesOrderDetail];

SELECT
    ProductID,
    SalesOrderID,
    LineTotal,
    AVG(LineTotal) OVER (
        PARTITION BY ProductID
    ) AS AvgLineTotalPerProduct,
    RANK() OVER (
        PARTITION BY ProductID 
        ORDER BY LineTotal DESC
    ) AS LineRankInProduct
FROM [Sales].[SalesOrderDetail]; --Calculates the average line total for each product and ranks each line (largest first) within the product group.



--Partition by Multiple Columns—Rank by Year and Product
--Rank products by their sales total within each year.
SELECT * FROM [Sales].[SalesOrderDetail];
SELECT * FROM [Sales].[SalesOrderHeader];

SELECT
    YEAR(h.OrderDate) AS SalesYear,
    d.ProductID,
    SUM(d.LineTotal) AS ProductSales,
    RANK() OVER (
        PARTITION BY YEAR(h.OrderDate)
        ORDER BY SUM(d.LineTotal) DESC
    ) AS YearlyProductRank
FROM [Sales].[SalesOrderHeader] h
INNER JOIN [Sales].[SalesOrderDetail] d
    ON h.SalesOrderID = d.SalesOrderID
GROUP BY YEAR(h.OrderDate), d.ProductID;































