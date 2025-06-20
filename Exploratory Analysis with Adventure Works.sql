--To understand what the table looks like in the Person.Person and Sales.Customer Tables
--** Have to use the SELECT * Statement
SELECT * FROM [Person].[Person];
SELECT * FROM [Sales].[Customer];

--To select specific columns from the sales.custoner table just for exploratory practice sake
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



SELECT pgtype_of (Taxtype)
from [Sales].[SalesTaxRate];

select * from [Production].[Product];

select * from [HumanResources].[Shift];

--FILTERING TEXT/WILD CARDS