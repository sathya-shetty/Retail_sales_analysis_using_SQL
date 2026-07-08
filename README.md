# Retail Sales SQL Analysis

### Overview

This project demonstrates **retail sales data analysis** using **MySQL** on an imported retail sales dataset. It covers the complete workflow from **database creation** and **data cleaning** to **exploratory data analysis (EDA)** and **SQL queries** to answer business questions from the given raw data. The objective of this project is to transform raw retail sales data into actionable insights using SQL.

## Dataset

The dataset contains retail sales transactions with customer details, product categories, quantities sold, pricing, and sales information.

**File:**  [retail_data.csv](retail_data.csv)

### Columns

| Column | Description |
|---------|-------------|
| transactions_id | Unique transaction identifier |
| sale_date | Date of transaction |
| sale_time | Time of transaction |
| customer_id | Unique customer identifier |
| gender | Customer gender |
| age | Customer age |
| category | Product category |
| quantity | Quantity purchased |
| price_per_unit | Price per unit |
| cogs | Cost of goods sold |
| total_sale | Total sale amount |

## Database 
A database named `retail_db` was created to import and store the retail sales data. The dataset was **imported into the database** by right-clicking on the Table created in the database, selecting **Table Data Import Wizard** and browsing the `.csv` file.
![Table Data Import Wizard](images/Import%20wizard.png)

## Table creation
A table named `retail_sales` was created which contained the same column headings as that of the `.csv` file to smoothly import the data.

```sql
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
```


