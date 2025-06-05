drop table if exists retail_sales;
Create Table retail_sales(
            transactions_id	int primary key,
            sale_date	date,
            sale_time	time,
            customer_id	int,
            gender varchar(15),
            age int	,
            category varchar(15),
            quantiy	int,
            price_per_unit	float,
            cogs	float,
            total_sale float
            );
alter table retail_sales
rename column quantiy to quantity;
select * from retail_sales;
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL ;
describe retail_sales;
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
-- data exploration
-- how many sales we have ?
select count(*) as total_sales  from retail_sales;
-- how many unique customers we have ?
select count(distinct customer_id) as total_sales from retail_sales;
select count(distinct category) as total_sales from retail_sales;
select distinct category from retail_sales;
-- data analysis  & business key problems & answers .
--  Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales where sale_date = '2022-11-05';
-- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022 
select * from  retail_sales 
 where category = 'clothing' 
 and date_format(sale_date ,'%Y-%m') ='2022-11'
 and quantity >='4';
 -- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.:
 select 
  category,
  sum(total_sale) as net_sales,
  count(*) as total_orders
  from retail_sales 
  group by 1;
  -- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
  select 
  category,
  round(avg(age),2)as avg_age
   from retail_sales where category = 'beauty';
   
   -- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000 
   select 
      transactions_id ,
      total_sale 
      from retail_sales 
          where total_sale >'1000';
          
-- OR Another Solution
select *
      from retail_sales 
          where total_sale >'1000';
          
-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select 
  category,
  gender,
 count(*) as total_transactions from retail_sales
 group by category,
  gender;
  
-- 	Q7

-- Q8  Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,
		sum(total_sale) as total_sales
        from retail_sales
        group by 1
        order by 2 desc
        limit 5;
-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category.:
select 
    category,
   count(distinct(customer_id)) from retail_sales
    group by category;
 -- Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
 WITH hourly_sale as (
 select *,
   CASE
    WHEN HOUR(sale_time) <=12  then 'morning'
    WHEN hour(sale_time) between 12 and 17 then 'afternoon'
    ELSE 'evening'
    END as shift from retail_sales)
    select 
     shift ,
     count(*) as total_orders from hourly_sale group by shift;
 