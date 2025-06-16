--SQL Retail sale analysis--
create database sql_project2;

--Create table--
drop table if exists retail_sales;
create table retail_sales
     (
        transactions_id	int primary key,
		sale_date Date,
		sale_time Time,
	    customer_id	int,
		gender varchar(50),
		age	int,
		category varchar(100),	
		quantiy	int,
		price_per_unit float,	
		cogs float,	
		total_sale float
      );

select *
from retail_sales
limit 10;


---Data Cleaning
select count(*)
from retail_sales;	

select *
from retail_sales
where transactions_id is null;

select *
from retail_sales
where sale_date is null;

select *
from retail_sales
where 
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or 
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

update retail_sales
set age=35
where customer_id=17;

update retail_sales
set age=30
where customer_id=16;

update retail_sales
set age=25
where customer_id=130;

update retail_sales
set age=41
where customer_id=67;

update retail_sales
set age=case
   when customer_id=89 then 29
   when customer_id=25 then 17
   when customer_id=77 then 33
   when customer_id=94 then 52
   when customer_id=116 then 20
   when customer_id=101 then 24
   else age
end
where age is null;

select *
from retail_sales
where 
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or 
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

delete from retail_sales
where
   transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or 
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

select *
from retail_sales
where
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or 
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

---Data exploration 
--how many sales we have?
select count(*) as total_sale from retail_sales;

--how many unique customers we have?
select count(distinct customer_id)as total_sale from retail_sales;

--how many unique customers we have?
select distinct category from retail_sales;

---Data analysis and business key problems and answers
--My Analysis and Findings

--Q1 write a sql query to retrive all columns for sales made on "2022-11-05"
select *
from retail_sales
where sale_date='2022-11-05';

--Q2 Write a sql query to retrieve all transactions where the categorie is 'Clothing' and the quantity sold is more than 4 in the month of November-2022
select *
from retail_sales
where
    category='Clothing'
	and
	to_char(sale_date,'YYYY-MM')='2022-11'
	and
	quantiy >=4

--Q3 Write a SQL query to calculate the total sales ( total_sales) for each category	
select
    category,
    sum(total_sale) as net_sale,
	count(*) as total_orders
from retail_sales
group by 1

--Q4 Write a scale query to find the average age of customer who purchase items from the Beauty category
select 
avg(age)
from retail_sales
where category='Beauty';

--Q5 Write a SQL query to find all transaction where the total sale is greater than 1000
select *
from retail_sales
where total_sale >1000

--Q6 Write a SQL query to find the total number of transactions (transaction_ID)made by each gender in each category
select 
    category,
    gender,
	count(*)as total_trans
from retail_sales
group by  category,
       gender

--Q7 Write a query to calculate the average sale for each month. Find out best selling month in each year.
select 
      year,
	  month,
	  avg_sale
from 
  (
  select
   extract(year from sale_date)as year,
   extract(month from sale_date)as month,
   avg(total_sale)as avg_sale,
   rank()over(partition by extract(year from sale_date) order by avg(total_sale)desc)
   from retail_sales
group by 1, 2 
) as t1
where rank=1

--Q8 Write a query to find the top five Customer based on the highest total sales
select 
  customer_id,
  sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--Q9 Write a sql query to find the number of unique customers who purchased items from each category
select
   category,
   count(distinct customer_id) as unique_customer
   from retail_sales
   group by category;

--Q10 Write a sql query to create each shift and number of orders. (Example morning<=12, afternoon between 12 and 17 evening > 17.
with hourly_sale
as
(
select *,
     case
	 when extract(hour from sale_time) < 12 then 'morning'
	 when extract(hour from sale_time)between 12 and 17 then 'afternoon'
	 else 'evening'
	end as shift
	from retail_sales
)
select 
   shift ,
   count(*)as total_orders
   from hourly_sale
   group by shift;


----End of the Project