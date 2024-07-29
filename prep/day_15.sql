
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS orders;


CREATE TABLE Restaurants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE Orders (
    id SERIAL PRIMARY KEY,
    restaurant_id INT REFERENCES Restaurants(id),
    order_time TIMESTAMP,
    dispatch_time TIMESTAMP
);

INSERT INTO Restaurants (name, location) VALUES
('Restaurant A', 'Delhi'),
('Restaurant B', 'Delhi'),
('Restaurant C', 'Delhi'),
('Restaurant D', 'Delhi'),
('Restaurant E', 'Delhi');

INSERT INTO Orders (restaurant_id, order_time, dispatch_time) VALUES
(1, '2024-07-23 12:00:00', '2024-07-23 12:14:00'),
(1, '2024-07-23 12:30:00', '2024-07-23 12:48:00'),
(1, '2024-07-23 13:00:00', '2024-07-23 13:16:00'),
(2, '2024-07-23 13:30:00', '2024-07-23 13:50:00'),
(2, '2024-07-23 14:00:00', '2024-07-23 14:14:00'),
(3, '2024-07-23 14:30:00', '2024-07-23 14:49:00'),
(3, '2024-07-23 15:00:00', '2024-07-23 15:16:00'),
(3, '2024-07-23 15:30:00', '2024-07-23 15:40:00'),
(4, '2024-07-23 16:00:00', '2024-07-23 16:10:00'),
(4, '2024-07-23 16:30:00', '2024-07-23 16:50:00'),
(5, '2024-07-23 17:00:00', '2024-07-23 17:25:00'),
(5, '2024-07-23 17:30:00', '2024-07-23 17:55:00'),
(5, '2024-07-23 18:00:00', '2024-07-23 18:19:00'),
(1, '2024-07-23 18:30:00', '2024-07-23 18:44:00'),
(2, '2024-07-23 19:00:00', '2024-07-23 19:13:00');


/*
You are given two tables: Restaurants and Orders. After receiving an order, 
each restaurant has 15 minutes to dispatch it. Dispatch times are categorized as follows:

on_time_dispatch: Dispatched within 15 minutes of order received.
late_dispatch: Dispatched between 15 and 20 minutes after order received.
super_late_dispatch: Dispatched after 20 minutes.
Task: Write an SQL query to count the number of dispatched orders in each category for each restaurant.
*/

select * from orders;                -- id, restaurant_id, order_time, dispatch_time
select * from restaurants;           -- id, name, location

with cte_table as (
	select 
		o.id as order_id,
		r.id as restaurant_id,
		r.name as restaurant_name,
		r.location as location,
		o.order_time as order_time,
		o.dispatch_time as dispatch_time,
		date_part('minutes',o.dispatch_time - o.order_time) as delivered_time
	from orders o 
	join restaurants r ON r.id = o.restaurant_id
),
reports_table as (
	select 
		*,
		case 
			when dispatch_time <= order_time + INTERVAL'15 minutes'  then 'on-time_dispatch'
			when dispatch_time>(order_time+ INTERVAL '15 minutes') and dispatch_time<=(order_time+ INTERVAL '20 minutes') then 'late_dispatch'
		else
			'super_late_dispatch'
		end as "reports"
		from cte_table
)
select 
	restaurant_id,
	restaurant_name,
	COUNT(CASE when reports='on-time_dispatch' then 1 END ) as on_time_report,
	COUNT(CASE when reports='late_dispatch' then 1 END ) as delay_report,
	COUNT(CASE when reports='super_late_dispatch' then 1 END ) as super_delay_report
from reports_table
group by restaurant_id,restaurant_name;