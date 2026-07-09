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

---

### Sales Performance by Day of the Week

```sql
select dayname(sale_date) as 'Day', sum(quantity) Units_sold, sum(total_sale) Revenue 
from retail_sales group by 1 order by 3 desc;
```

| Day | Units Sold | Revenue |
|-----|-----------:|---------:|
| Sunday | 803 | 152,800 |
| Monday | 720 | 147,575 |
| Saturday | 783 | 141,400 |
| Thursday | 691 | 122,585 |
| Friday | 722 | 120,605 |
| Wednesday | 662 | 120,420 |
| Tuesday | 614 | 102,845 |

---

### Findings from EDA:
1. The store generated a **total revenue of 908,230** from **1,987 transactions** consisting of **155 unique customers**.
2. **Electronics** was the highest revenue generating category followed by **Clothing** and **Beauty** respectively.
3. Revenue accross the 3 segments are balanced, indicating a well-distributed demand rather than indivdual domination.
4. **Sunday** was the best-performing day of the week, recording both the **highest revenue (152,800)** and the **highest number of units sold (803)**, suggesting increased customer activity during weekends.

EDA provided a better understanding on the store's sales performance, demand pattern, purchasing patterns and revenue distribution.

## Business Problems

The project answers a set of real-world business questions using SQL by analysing the retail sales database.

| No. | Business Question |
|:---:|-------------------|
| 1 | Retrieve all sales transactions made on **5 November 2022**. |
| 2 | Identify **Clothing** purchases where the quantity sold was **greater than 3** during **November 2022**. |
| 3 | Calculate the **total revenue generated** by each product category. |
| 4 | Determine the **average age** of customers purchasing products from the **Beauty** category. |
| 5 | Identify **high-value transactions** where the total sale exceeded **1,000**. |
| 6 | Analyze the **number of transactions** made by each gender across different product categories. |
| 7 | Calculate the **average monthly sales** for the year **2023**. |
| 8 | Identify the **Top 5 customers** based on their total purchase value. |
| 9 | Determine the **number of unique customers** purchasing from each product category. |
| 10 | Classify transactions into **Morning**, **Afternoon**, and **Evening** shifts based on purchase time and determine the number of orders in each shift. |
| 11 | Identify the **best-selling month** of each year using SQL window functions. |

📄 **Detailed SQL queries, outputs, and observations are available in [FINDINGS.md](FINDINGS.md).**

---

## Results and Findings
Given below are the observations from the output obtained after running the queries mentioned in `FINDINGS.md`:
1. A total of **11 transactions** were recorded on 5 November 2025 ranging between all three categories **indicating distribution of demand** on that day.
2. There were several (16 transactions) high value purchases in clothing category on Nov 2022.
3. **Electronics** generated the highest total revenue (**311,445**), then **Clothing** (**309,995**) and **Beauty** (**286,790**).
4. The average age of customers purchasing from Beauty category was **40.4 years**.
5. **306** high revenue transactions (total sale exceeding 1000) were recorded indicating possibility of stronger purchasing power.
6. There were balanced distribution of customers based on gender in category with **female customers being relatively higher in Beauty category and slightly higher Male customers in Electronics and Clothing.**
7. **February 2023** recorded the highest average monthly sale (**535.53**), while **March** recorded the lowest (**394.81**).

