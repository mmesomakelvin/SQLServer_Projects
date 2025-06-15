SELECT * FROM [Person].[Person];
SELECT * FROM [Sales].[Customer];

SELECT CUSTOMERID, PERSONID, ROWGUID
FROM [Sales].[Customer];

SELECT DISTINCT PERSONID
FROM [Sales].[Customer];

SELECT * FROM [Sales].[SalesTerritory];

SELECT COUNT([Group]) as group_count,
       COUNT(name) as name_count
FROM [Sales].[SalesTerritory];

select count(*) as total_records
from [Sales].[SalesTerritory];

select count(distinct CountryRegionCode) as count_distint_crc
from [Sales].[SalesTerritory];

select * from [Sales].[SalesOrderDetail];

Select salesorderid, unitprice, orderqty
from [Sales].[SalesOrderDetail]
where productid > 800;

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



