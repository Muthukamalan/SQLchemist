
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    store_name VARCHAR(50),
    sale_date DATE,
    sale_amount DECIMAL(10, 2)
);


INSERT INTO sales (store_name, sale_date, sale_amount) 
VALUES
('A', '2024-01-01', 1000.00),
('A', '2024-02-01', 1500.00),
('A', '2024-03-01', 2000.00),
('A', '2024-04-01', 3000.00),
('A', '2024-05-01', 4500.00),
('A', '2024-06-01', 6000.00),
('B', '2024-01-01', 2000.00),
('B', '2024-02-01', 2200.00),
('B', '2024-03-01', 2400.00),
('B', '2024-04-01', 2600.00),
('B', '2024-05-01', 2800.00),
('B', '2024-06-01', 3000.00),
('C', '2024-01-01', 3000.00),
('C', '2024-02-01', 3100.00),
('C', '2024-03-01', 3200.00),
('C', '2024-04-01', 3300.00),
('C', '2024-05-01', 3400.00),
('C', '2024-06-01', 3500.00);


-- Explore
select * from sales;

/*
- running total by month
- growth ration
*/

-- Calculate each store running total Growth ratio compare to previous month return store name, sales amount, running total, growth ratio
-- Window Function `lag`

/* 
# Formula
# GrowthRatio = current_month_sale - last_month_sale / (last_month_sale *100)
*/

WITH cte_table as (
	SELECT 
		*,
		SUM(sale_amount) OVER( PARTITION BY store_name ORDER BY sale_date ) as running_total,
		LAG(sale_amount,1) OVER( PARTITION BY store_name ORDER BY sale_date ) as last_month_sale
	from sales
) 
SELECT 
	store_name, 
	sale_date, 
	sale_amount, 
	running_total,
	last_month_sale,
	(sale_amount - last_month_sale )/ last_month_sale*100 as growth_ratio 
from cte_table