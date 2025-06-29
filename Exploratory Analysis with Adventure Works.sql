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
from [Sales].[SalesOrderHeader]; --cpunt to see % of rows that are not null

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
select businessentityid, sum(Bonus) as totalBonus, TerritoryID
from [Sales].[SalesPerson]
group by BusinessEntityID, TerritoryID
HAVING SUM(BONUS) > 4000
order by territoryid asc, totalBonus desc;

hi




