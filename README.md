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

## Data Cleaning

Before performing the analysis, the imported dataset was validated to ensure consistency and accuracy. The following data cleaning steps were carried out:

- Renamed the incorrectly named `quantiy` column to `quantity`.
- Verified the total number of records imported into the table.
- Checked all columns for missing (`NULL`) values.
- Confirmed whether the values were ready to perform further analysis.

### Preview the Data
To check whether the respective columns have appropriate values after importing.	
```sql
select*from retail_sales limit 5;
```
The data contained transaction details, customer information, product categories, pricing, and total sales.

| transactions_id | sale_date | sale_time | customer_id | gender | age | category | quantity | price_per_unit | cogs | total_sale |
|----------------:|:---------:|:---------:|------------:|:------:|----:|:---------|---------:|---------------:|-----:|-----------:|
| 1 | 2022-12-16 | 19:10:00 | 50 | Male | 34 | Beauty | 3 | 50 | 16 | 150 |
| 2 | 2022-06-24 | 10:07:00 | 104 | Female | 26 | Clothing | 2 | 500 | 135 | 1000 |
| 3 | 2022-06-14 | 07:08:00 | 114 | Male | 50 | Electronics | 1 | 30 | 8.1 | 30 |
| 4 | 2023-08-27 | 18:12:00 | 3 | Male | 37 | Clothing | 1 | 500 | 200 | 500 |
| 5 | 2023-09-05 | 22:10:00 | 3 | Male | 30 | Beauty | 2 | 50 | 24 | 100 |

### Rename Column

```sql
alter table retail_sales rename column quantiy to quantity;
```

### Check Total Records	

```sql
select count(*) as Total_rows from retail_sales;
```
The dataset contains **1,987** retail sales transactions.

### Check for NULL Values

```sql
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
```

No `NULL` values were found in any of the columns, indicating that the dataset was complete and ready for analysis.


## Exploratory Data Analysis
*Exploratory data analysis (EDA) is used by data scientists to analyze and investigate data sets and summarize their main characteristics.*

After verifying and cleaning the dataset, an initial exploratory analysis was performed to understand the overall sales performance and customer base before answering specific business questions.

Given below are the few findings:

### Total Revenue

```sql
select sum(total_sale) as Total_Sales from retail_sales;
```

**Total Revenue Generated:** **908,230**

---

### Sales by Category

```sql
select category, sum(total_sale) as Total_Sales
from retail_sales
group by category;
```

| Category | Total Sales |
|----------|------------:|
| Beauty | 286,790 |
| Clothing | 309,995 |
| Electronics | 311,445 |

---

### Total Customers

```sql
select count(distinct(customer_id)) as Total_Customers
from retail_sales;
```
The dataset contains transactions from **155 unique customers**, providing a diverse customer base for further analysis.

