DROP TABLE IF EXISTS users cascade;

create table users
(
	user_id int,
	user_name varchar(20),
	credit_limit int
);

create table transactions
(
	trans_id int,
	paid_by int,
	paid_to int,
	amount int,
	trans_date date
);

insert into users(user_id,user_name,credit_limit)values
(1,'Peter',100),
(2,'Roger',200),
(3,'Jack',10000),
(4,'John',800);

insert into transactions(trans_id,paid_by,paid_to,amount,trans_date)values
(1,1,3,400,'01-01-2024'),
(2,3,2,500,'02-01-2024'),
(3,2,1,200,'02-01-2024');



select * from users;
select * from transactions;

--write a query to find users whose transactions has breached their credit limit
with money_spend as (
	select  
		paid_by as user_id,  
		sum(amount) as total_spent 
	from transactions 
	group by paid_by
),  
money_received as (
	select 
		paid_to as user_id, 
		sum(amount) as total_received
	from transactions 
	group by paid_to
)
	select 
		u.user_id,
		u.user_name ,
		u.credit_limit,
		COALESCE(sp.total_spent,0) as total_spend,
		COALESCE(mr.total_received,0) as total_received
	from users u
	left join money_spend sp on u.user_id=sp.user_id
	left join money_received mr on u.user_id=mr.user_id	
	where u.credit_limit+COALESCE(mr.total_received,0) < COALESCE(sp.total_spent,0)

