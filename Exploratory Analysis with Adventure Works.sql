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


