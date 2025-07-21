#SQL Project - synthetic fraud dataset 
# 1.Introduction 
# In this project, we focus on the development of a fraud detection system ,aimed at identifying suspicious transactions in mobile money systems.
# This project is to analyze transaction data, identify patterns of legitimate and fraudulent activities, and build an efficient system for detecting potential fraud. 

-- Data Description:
-- The synthetic fraud dataset contains artificially generated transaction data designed to help test and improve fraud detection systems. 
-- It includes various attributes such as transaction amounts, time stamps, which are used to simulate both legitimate and fraudulent activities.
--  This dataset is useful for analyzing patterns and building models that can accurately identify fraudulent transactions in real-world scenarios.

# . Database Design
create database fraud;
use fraud;
-- fraud_details Table
create table fraud_details( user_iD int primary key auto_increment, 
user_name varchar(100) not null,user_city varchar(100) not null,phone_no bigint unique not null);


#insert valuse into table 
insert into  fraud_details (user_iD , user_name , user_city,phone_no) values 
(1,'jyoti','nagpur',9921101818),
(2,'mangesh','latur',7066973030),
(3,'vaishnavi','pune',9763980033);


#How to rename table
rename table synthetic_fraud_dataset to fraud_table;
select * from fraud_table;

# 🔹 COUNT & DISTINCT
-- Count total rows in fraud_table
select count(*) as total  from fraud_table;

-- 🔹 DELETE, TRUNCATE & DROP
select * from fraud_table;
-- delete specific user id --
set sql_safe_updates=0;
delete from fraud_table where User_ID='USER_2617';

-- Truncate the fraud_details table (removes all data but keeps structure)
truncate fraud_details;
select * from fraud_details;
-- drop entire fraud_details table --
drop table fraud_details;


select  * from fraud_table;

-- AND, OR and NOT Operators--
-- find mobile device type  which has transaction amount smaller than 30 (using and operator)
select device_type,transaction_amount from fraud_table where device_type = 'Mobile' and transaction_amount < 30;

-- find where transaction_type should be ATM withdrawal or transaction_amount grater than 100  (using or operator)
select  transaction_amount,transaction_type from fraud_table where transaction_type='ATM withdrawal' or transaction_amount > 100;

-- find out authetication_method except PIN (using not operator)
select authentication_method from fraud_table where not authentication_method = 'PIN';


-- IN and NOT IN operator
select * from fraud_table; 
select daily_transaction_count from fraud_table where daily_transaction_count in (1,3,4,10);
select daily_transaction_count from fraud_table where daily_transaction_count not in (1,3,4,10);

-- BETWEEN and NOT BETWEEN Operator
select card_age from fraud_table where card_age between 20 and 100 ;
select Avg_Transaction_Amount_7d from  fraud_table where Avg_Transaction_Amount_7d not between 50 and 400;


-- 🔹 ALTER & UPDATE
-- Add a new column to the fraud_table --
alter table  fraud_table add column Address varchar(255);

-- update transection type --
update fraud_table set transaction_type='POS' where user_id ='user_6852';


-- 🔹 LIMIT & ORDER BY
-- Get the first 4 user_id  ordered by account_balance
select * from fraud_table  order by account_balance desc limit 4;

-- 🔹 Arithmetic Expressions
-- Increase card age by 2--
select user_id ,card_age+2 as card_age_next_2_year from fraud_table;

-- 🔹 Constraints Example
-- Adding a new constraint to prevent NULL values in CourseName
ALTER TABLE fraud_table MODIFY merchant_category VARCHAR(100) NOT NULL;

select * from fraud_table;

-- 🔹 GROUP BY & HAVING
-- Count user_id having transaction_type
select transaction_type,count(user_id) from fraud_table group by transaction_type ;

-- count device_type having transaction amount greater than 20--
select device_type, sum(transaction_amount) from fraud_table group by device_type having sum(transaction_amount) > 20;

-- 🔹 CASE Statement

select user_id,location,
case 
when location = 'mumbai' then 'in_india'
when location !='mumbai'  then'out_of_india'
else '0' 
end as india_out_of_india from fraud_table;

-- 🔹 String Functions
-- convert location to upeercase
 select upper(location) from fraud_table;
 
 -- Get the length of card_type --  
 select card_type,   length(card_type) from fraud_table;
 
 -- Concatenate device_type  and location
 select concat(device_type,'-', location) from fraud_table;
 
 -- 🔹 Subqueries
-- Find card_age where  transaction_amount under 50
 select card_age from fraud_table where card_age in(select card_age from fraud_table where transaction_amount <50) ;
 
 select * from fraud_table;
 -- Analyze the number of transactions by location.
 SELECT location, COUNT(*) AS transaction_count
FROM fraud_table
GROUP BY location
ORDER BY transaction_count DESC;

-- Find the top users based on transaction amounts.
SELECT user_id, SUM(transaction_amount) AS total_spent
FROM fraud_table
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 10;

-- Find out which users are associated with fraudulent transactions.
SELECT user_id, COUNT(*) AS fraudulent_transactions
FROM fraud_table
WHERE fraud_label = 1
GROUP BY user_id
ORDER BY fraudulent_transactions DESC;

-- Get a count of transactions grouped by fraud and non-fraud.
SELECT fraud_label, COUNT(*) AS transaction_count
FROM fraud_table
GROUP BY fraud_label;
 
 -- .	Challenges Faced-
 -- The synthetic dataset may have missing or incomplete data, making it challenging to run accurate queries or create meaningful insights.
 -- Handling missing or null values in SQL queries requires proper techniques, such as using handling NULL values effectively.

 
 -- Conclusion - 
 -- Our analysis highlighted critical fraud indicators, such as unusual transaction amounts, frequent high-value transfers, and 
 -- transactions occurring at irregular times or locations. Using aggregations, joins, subqueries functions,
--  we effectively detected suspicious behaviors and uncovered trends in fraudulent activities.
 
 


