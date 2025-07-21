# SQL Project: Smart Logistics Supply Chain System
# 1. Introduction
#This Smart Logistics Supply Chain System analyzes shipment efficiency, traffic impact, inventory management, and operational bottlenecks using SQL. 
#It helps optimize delivery speed, reduce delays, and improve overall logistics performance through data-driven insights.
#This project contains Logistics data with Real-time asset tracking,shipment and delays.

# Various SQL operations are performed, including CRUD operations, joins, aggregations, constraints, and advanced queries.

# 2. Database Design
create database Logistics;
use Logistics;

# 3.smart_logistics_dataset table
#Import table smart_logistics_dataset
Select *from smart_logistics_dataset;
 
# User_data Table
Create table User_data (
 user_id int,user_name varchar(10),user_age int);
 
 #order_data
 Create table Order_details (
 order_id int,order_type varchar(10),amount int,Order_date date);

INSERT INTO ORDER_DETAILS ( order_id,order_type,amount,order_date) values
(1005, 'COD' , 1300 , '2024-09-10'),
(1005, 'Prepaid',1600,'2025-08-10'),
(1005,'Postpaid',1200,'2024-12-11');

 # 4. SQL Queries for Various Concepts
 
-- 🔹 Rename
#How to rename table name
RENAME TABLE smart_logistics_dataset to Logistics_data;

-- 🔹 Operators (= , > ,<, >= ,<= ,!= )
#use = operator 
SELECT *from logistics_data where shipment_Status = 'Delayed';

#use > operator 
select *from logistics_data where Temperature > 22;

#use < operator
select *from logistics_data where waiting_time <20;

#use <= operator
select *from logistics_data where Humidity <= 50.0;

#use >= operator
select *from logistics_data where Humidity >= 60.0;

#use != opearator
select *from logistics_data where Traffic_status != 'Clear';

-- 🔹 COUNT & DISTINCT
SELECT count(*) FROM logistics_data;

SELECT DISTINCT Asset_ID FROM logistics_data;

-- 🔹 Delete, truncate and drop
-- Delete table
DELETE FROM logistics_data WHERE Waiting_Time = 16 limit 1;

-- Truncate table (removes all data but keeps structure)
TRUNCATE user_data;

-- Drop Table (Remove entire data structure with data)
DROP table order_details;

-- 🔹 ALTER & UPDATE
-- Add a new column to the user_data
ALTER TABLE user_data ADD column phone_no bigint ;

-- Update column 
UPDATE logistics_data SET Temperature = 23 WHERE Timestamp = '2024-03-20 00:11:14';

-- 🔹 LIMIT,OFFSET & ORDER BY
-- Get first 4 rows from logistics_data
SELECT *FROM logistics_data limit 4;

-- Get 5,6,7 row from logistics_data
SELECT *FROM logistics_data limit 3 OFFSET 4;

-- First 4 rows oder by timestamp
SELECT *FROM logistics_data ORDER BY Timestamp DESC limit 4;

-- 🔹 ARITHMATIC OPERATOR (MIN,MAX,COUNT,AVERAGE,SUM)
SELECT MIN(Temperature) FROM logistics_data;

SELECT MAX(Humidity) FROM logistics_data;

SELECT COUNT(Inventory_Level) FROM logistics_data;

SELECT SUM(User_Transaction_Amount) FROM logistics_data;

-- 🔹 Constraints Example
-- Adding a new constraint to prevent NULL values in Asset_ID
ALTER TABLE logistics_data MODIFY Asset_ID VARCHAR(100) NOT NULL;

-- Adding a new constraint to prevent Duplicate values in Timestamp
ALTER TABLE logistics_data MODIFY Timestamp datetime UNIQUE;

-- 🔹 GROUP BY & HAVING
-- Count Timestamp assigned in Asset
SELECT Asset_ID ,COUNT(Timestamp) as Count FROM logistics_data GROUP BY Asset_ID;

-- Return the Asset_ID values where the count of Waiting_time is greater than 20
SELECT Asset_ID , count(Waiting_time) as Count FROM logistics_data GROUP BY Asset_id HAVING COUNT(Waiting_time)> 20;

-- 🔹 UNION & UNION ALL
-- Create 2 Tables
CREATE TABLE FIRST5 (SELECT *FROM logistics_data LIMIT 5);
CREATE TABLE NEXT5 (SELECT *FROM logistics_data LIMIT 5 OFFSET 4);

-- Combine the FIRST5 & NEXT5 table using UNION & UNION ALL
-- UNION (Combine only unique data)
SELECT *FROM FIRST5
UNION
SELECT *FROM NEXT5;

-- UNION ALL (Includes Duplicates)
SELECT *FROM FIRST5
UNION ALL 
SELECT *FROM NEXT5;

-- 🔹VIEWS--
-- Store all the data of Truck_7 Virtually
CREATE VIEW Truck_7
AS
SELECT *FROM logistics_data where Asset_ID ='Truck_7';

-- 🔹INDEX-- 
-- Index on Inventory_level
CREATE INDEX logisticsIndex
on logistics_data (Inventory_Level);

-- Drop Index on Inventory_level
Alter table logistics_data
drop index logisticsIndex;

-- 🔹CASE STATEMENT--
-- Update Remark as per Shipment status using case

SELECT 
	Shipment_Status,
CASE
WHEN Shipment_Status = 'Delayed' THEN 'Need Improvement'
WHEN Shipment_Status = 'In Transit' THEN 'Average'
WHEN Shipment_Status = 'Delivered' THEN 'Good'
ELSE 'Unknown Reason'
END as Remark
From logistics_data;

-- 🔹SPECIAL OPERATOR
-- IN (Pass Multiple value)
SELECT *FROM logistics_data where Waiting_time in(30,31,33,34,35);

-- BETWEEN-AND(Get data based on range)
SELECT *FROM logistics_data where User_Transaction_Amount BETWEEN 200 AND 500;

-- LIKE(Get data based on some character of string)
SELECT *FROM logistics_data where Traffic_Status LIKE 'H%';

-- IS NULL(Get Null values )
SELECT * FROM logistics_data where Logistics_Delay IS NULL;

-- 🔹STRING FUNCTIONS
-- LENGTH()
SELECT Traffic_Status, length(Traffic_Status) as Length FROM logistics_data;

-- UPPER()
SELECT Shipment_Status, UPPER(Shipment_Status) as UPPER FROM logistics_data;

-- LOWER()
SELECT Shipment_Status, LOWER(Shipment_Status) as LOWER FROM logistics_data;

-- CONCATENATE()
SELECT concat( Latitude, '-' ,Longitude) as Location FROM logistics_data;

-- 🔹SUBQUERY
-- Find the Asset_ID that has the earliest Timestamp using a subquery.
SELECT ASSET_ID,Timestamp FROM logistics_data WHERE Timestamp = (SELECT MIN(Timestamp) FROM logistics_data);

-- Query to find the Shipment_Status of the asset that had the lowest Inventory_Level.
SELECT Shipment_Status, Inventory_Level FROM logistics_data WHERE Inventory_Level = (SELECT MIN(Inventory_Level) FROM logistics_data);

-- Query to fetch shipments where the Waiting_Time is greater than the average Waiting_Time?
SELECT * FROM logistics_data WHERE Waiting_time > (SELECT AVG(Waiting_Time) FROM logistics_data);

-- Write a query to find the Traffic_Status with the highest Temperature using a subquery.
SELECT Traffic_Status,Temperature FROM logistics_data WHERE temperature = (SELECT MAX(Temperature) FROM logistics_data);

-- 4. Data Analysis
-- o	Results of SQL queries with interpretations.
-- Here SQL query result and it interpretations based on the Supply Chain Logistics System data.
SELECT Shipment_Status, COUNT(*) AS Shipment_Count FROM logistics_data GROUP BY Shipment_Status;

-- Interpretations:
-- High delays (350 shipments) indicate major logistics inefficiencies like traffic congestion or inventory shortages.
-- 312 shipments in transit need better tracking to prevent further delays.
-- 338 successful deliveries show stable operations, but improvements are needed to reduce delays.

-- o Key insights gained from the data analysis.
-- Optimizing traffic routes and inventory management can reduce shipment delays.
-- Better demand forecasting prevents stock shortages.
-- Customer satisfaction is directly impacted by delivery speed.

-- 6. Challenges Faced
-- Some columns had null values so use ISNULL() to ensure accurate calculations.

-- 7. Conclusion
-- By using Smart Logistics Supply Chain System, its implementing real-time traffic monitoring can help reduce delays and improve delivery accuracy.
-- Also improving shipment tracking transparency can boost customer trust and increase repeat purchases.


























