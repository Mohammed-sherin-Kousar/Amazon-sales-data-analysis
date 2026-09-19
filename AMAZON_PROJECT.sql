create database amazon_project;
use amazon_project;

create table amazon_cleaned_data(
id int auto_increment primary key,
Order_ID varchar(50),
Date DATE,
Status varchar(50),
Fulfilment varchar(50),
Sales_Channel varchar(50),
ship_service_level varchar(50),
Style varchar(100),
SKU varchar(100),
Category varchar(100),
Size varchar(20),
ASIN varchar(50),
Courier_Status varchar(50),
Qty int,
currency varchar(10),
Amount float,
ship_city varchar(100),
ship_state varchar(100),
ship_postal_code varchar(100),
ship_country varchar(20),
promotion_ids text,
B2B varchar(50),
fulfilled_by varchar(50),
Unnamed text,
Outlier_flag varchar(20),
Month int,
Year int,
Day int,
Weekday varchar(50),
Revenue float
);
select * from amazon_cleaned_data
limit 10;

--  ORDERS-BASED ANALYSIS:-

-- 1. MOST NET SALES BY SKU,CATEGORY,SIZES?

-- SKU-
select SKU,sum(Amount) as total_sales,sum(Qty) as total_qty 
from amazon_cleaned_data
group by SKU
order by total_sales DESC;

-- CATEGORY-
select Category,sum(Amount) as total_sales,sum(Qty) as total_qty 
from amazon_cleaned_data
group by Category
order by total_sales DESC;

-- SIZE-
select Size,sum(Amount) as total_sales,sum(Qty) as total_qty 
from amazon_cleaned_data
group by Size
order by total_sales DESC;

-- 2. TOP 5 STATES BASED ON TOTAL ORDER AMOUNT?
select ship_state,sum(Amount) as total_order_amount
from amazon_cleaned_data
group by ship_state
order by total_order_amount limit 5;

-- 3. TOP 5 CITIES BASED ON TOTAL ORDER AMOUNT?
select ship_city,sum(Amount) as total_order_amount
from amazon_cleaned_data
group by ship_city
order by total_order_amount limit 5;

-- 4.NO.OF ORDERS BASED ON PRODUCT CATEGORY?
select Category,count(order_id) as total_orders 
from amazon_cleaned_data
group by Category;

-- 5.NO.OF ORDERS BASED ON SHIP-CITY/SHIP-STATE?

-- SHIP-CITY-
select ship_city,count(order_id) as total_orders 
from amazon_cleaned_data
group by ship_city;

-- SHIP-STATE-
select ship_state,count(order_id) as total_orders 
from amazon_cleaned_data
group by ship_state;

-- REVENUE-BASED ANALYSIS:-

-- 6.REVENUE TREND OVER TIME?

-- DAILY-
select date,sum(Amount) as Revenue
from amazon_cleaned_data
group by date
order by date;

-- WEEKLY-
select week(date) as week_no,sum(Amount) as Revenue
from amazon_cleaned_data
group by week_no
order by week_no;

-- MONTHLY-
select month(date) as month_no,sum(Amount) as Revenue
from amazon_cleaned_data
group by month_no
order by month_no;

-- 7. MOST PROFITABLE FULFILMENT CHANNEL?
select fulfilment,sum(Amount) as Revenue
from amazon_cleaned_data
group by fulfilment
order by Revenue desc;

-- 8. SHIP-SERVICE V/S ORDER AMOUNT?
select ship_service_level,sum(Amount) as order_amount
from amazon_cleaned_data
group by ship_service_level;

-- 9. QUANTITY V/S AMOUNT BASED ON CATEGORY?
select Category,sum(Qty) as total_qty,sum(Amount) as total_sales
from amazon_cleaned_data
group by Category;

-- GENEREAL ANALYSIS:-

-- 10. SHIP-SERVICE V/S PRODUCT CATEGORY?
select ship_service_level,Category,
count(*) as orders_count
from amazon_cleaned_data
group by ship_service_level,Category;

-- 11. CANCELLATION RATES BY CATEGORY AND SIZE?
select Category,Size,Status,
count(*) as total
from amazon_cleaned_data
where Status='Cancelled'
group by Category,Size,Status;

-- 12. TYPE OF PROMOTION V/S ORDER AMOUNT?
select promotion_ids,avg(Amount) as avg_order_amount
from amazon_cleaned_data
group by promotion_ids;

-- 13. CATEGORY DISTRIBUTION?
select Category,count(*) as count_category
from amazon_cleaned_data
group by Category;

-- 14. PRODUCT SIZE DISTRIBUTION?
select Size,count(*) as count_size
from amazon_cleaned_data
group by Size;

-- 15. STYLE DISTRIBUTION?
select Style,count(*) as count_style
from amazon_cleaned_data
group by Style;

-- 16. % OF SALES FROM TOP 10 PRODUCTS/CATEGORIES?
select Category,sum(Amount) as sales,
sum(Amount)/(select sum(Amount) from amazon_cleaned_data)*100 as percentage
from amazon_cleaned_data
group by category
order by sales limit 5;

-- 17. REVENUE CONCENTRATION?
select Category,sum(Amount) as Revenue
from amazon_cleaned_data
group by Category
order by Revenue desc;








