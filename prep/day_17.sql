
DROP TABLE IF EXISTS user_activities;

CREATE TABLE user_activities (
    user_id INT,
    activity VARCHAR(10), -- Either 'Login' or 'Logout'
    activity_time TIMESTAMP
);



INSERT INTO user_activities (user_id, activity, activity_time) VALUES
(1, 'Login', '2024-01-01 08:00:00'),
(1, 'Logout', '2024-01-01 12:00:00'),
(1, 'Login', '2024-01-01 13:00:00'),
(1, 'Logout', '2024-01-01 17:00:00'),
(2, 'Login', '2024-01-01 09:00:00'),
(2, 'Logout', '2024-01-01 11:00:00'),
(2, 'Login', '2024-01-01 14:00:00'),
(2, 'Logout', '2024-01-01 18:00:00'),
(3, 'Login', '2024-01-01 08:30:00'),
(3, 'Logout', '2024-01-01 12:30:00'),
(1, 'Login', '2024-07-23 08:00:00'),
(1, 'Logout', '2024-07-23 12:00:00'),
(1, 'Login', '2024-07-23 13:00:00'),
(1, 'Logout', '2024-07-23 17:00:00'),
(2, 'Login', '2024-07-23 09:00:00'),
(2, 'Logout', '2024-07-23 11:00:00'),
(2, 'Login', '2024-07-23 12:00:00'),
(2, 'Logout', '2024-07-23 15:00:00'),
(1, 'Login', '2024-07-24 08:30:00'),
(1, 'Logout', '2024-07-24 12:30:00'),
(2, 'Login', '2024-07-24 09:30:00'),
(2, 'Logout', '2024-07-24 10:30:00');

SELECT * FROM user_activities order by user_id, activity_time;


-- Find users productive hours
with login_logout_table as (
	select 
		*, 
		cast( activity_time as date ) as activity_day,
		LEAD(activity_time,1) over(partition by user_id,cast( activity_time as date ) order by  activity_time) as logout_time
	from user_activities
)
select 
	user_id,
	activity_day,
	-- EXTRACT(HOUR FROM activity_time) as login_time,
	-- EXTRACT(HOUR FROM logout_time) as logout_time
	MAX(EXTRACT(HOUR FROM logout_time)) - MIN(EXTRACT(HOUR FROM activity_time)) as inside_hours,
	sum(logout_time  - activity_time)  as productivity_hours
from login_logout_table
where activity='Login'
group by user_id,activity_day;