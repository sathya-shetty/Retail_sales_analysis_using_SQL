-- SQL Reatil Sales Analysis Project

-- Creating the database
create database retail_db;
use retail_db;

-- Creating Tables
create table retail_sales(
					transactions_id	int primary key,
                    sale_date date,
                    sale_time time,	
                    customer_id	int,
                    gender varchar(15),	
                    age	int,
                    category varchar(30),	
                    quantiy int,	
                    price_per_unit decimal(10,2),	
                    cogs decimal(10,2),	
                    total_sale decimal(10,2)
                    );
                    
-- Imported data by right-clicking on table name and Table Data import Wizard.

-- DATA CLEANING ---------------------------------------------------------------------------------------

select*from retail_sales limit 5;									-- check the data
alter table retail_sales rename column quantiy to quantity;			-- Rename
select count(*) as Total_rows from retail_sales;					-- Total Rows

-- Checking for NULL values
select * from retail_sales where
							sale_date is null 
                            or sale_time is null
                            or customer_id is null
                            or gender is null
                            or age is null
                            or category is null
                            or quantity is null
                            or price_per_unit is null
                            or cogs is null
                            or total_sale is null;
                            
                            
-- DATA EXPLORATION -------------------------------------------------------------------------------------
select sum(total_sale) as Total_Sales from retail_sales; 								-- Total revenue
select category, sum(total_sale) as Total_Sales from retail_sales group by category; 	-- Sales By Category
select count(distinct(customer_id)) as Total_Customers from retail_sales;				-- Customer Count

-- KEY ISSUES -------------------------------------------------------------------------------------------

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from retail_sales where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select * from retail_sales where category='Clothing' and quantity>3 and month(sale_date)=11 and year(sale_date)=2022;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as Total_Sales from retail_sales group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category, round(avg(age),1) as Avg_Age from retail_sales where category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions made by each gender in each category.
select category, gender, count(transactions_id) as count from retail_sales group by gender, category order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month for 2023.
select monthname(sale_date) as 'Month', round(avg(total_sale),2) as Average 
from retail_sales where year(sale_date)=2023 group by monthname(sale_date) order by 2 desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) from retail_sales group by customer_id order by 2 desc limit 5;    -- Multiple purchases by customer, so sum(total_sale)

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count( distinct customer_id) unq_cust from retail_sales group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select 	case
			when hour(sale_time)<12 then 'Morning'
			when hour(sale_time)<17 then 'Afternoon'
			else 'Evening'
		end as shift, 
        count(*) as Total_Orders from retail_sales group by 1;

-- Q.11  Find out best selling month in each year
select Month, year, Tot_sale from(
select monthname(sale_date) as 'Month', year(sale_date) as 'year', sum(total_sale) Tot_sale,
		rank() over( 
        partition by year(sale_date) order by sum(total_sale) desc
        ) as 'rnk'
        from retail_sales group by 1, 2) as Highest_sale where rnk=1;
        

-- Extras
-- 1. Top spending customer per category
select customer_id, category, sales, rnk as 'RANK' from (
		select customer_id, category, sum(total_sale) sales, rank() over(
        partition by category order by sum(total_sale) desc
        ) as rnk from retail_sales group by customer_id, category
        ) as ranked_sales where rnk in (1,2,3);
        
-- 2. Revenue contribution by category
select category, sum(total_sale) revenue, round(sum(total_sale)/(
									select sum(total_sale) from retail_sales
                                    )*100,2) as share_percentage 
from retail_sales group by category;

-- END
