------------------------------ DATASET PREPERATION ---------------------------------------------------------------------------------------
-- CREATE DATABASE  BANKING;

DROP TABLE IF EXISTS accounts,products,employees,customers,customer_accounts,transactions;

create table products
(
	prod_id		varchar(10) primary key,
	prod_name	varchar(100) not null
);

create table Employees
(
	Emp_ID		varchar(10),
	Emp_Name	varchar(100),
	Salary		float,
	gender		varchar(10) check (gender in ('M', 'F')),
	constraint pk_emp primary key (emp_id)
);

create table Customers
(
	Customer_ID		varchar(10),
	First_Name		varchar(40),
	Last_Name		varchar(40),
	Phone			bigint,
	Address			varchar(200),
	dob				date,
	constraint pk_cust primary key(customer_id)
);

create table Accounts
(
	Account_No			bigint primary key,
	Balance				int,
	Account_Status		varchar(10) check (Account_Status in ('Active', 'Inactive', 'Suspended', 'On hold')),
	Date_of_Opening		date
);

create table Transactions
(
	Transaction_ID		int generated always as identity,
	Transaction_Date	date,
	Transaction_amount	float,
	Credit_Debit_flag	varchar(1),
	Account_No			bigint,
	constraint fk_acc foreign key (Account_No) references Accounts(Account_No)
);

create table Customer_Accounts
(
	Customer_ID		varchar(10),
	Account_No		bigint,
	prod_id			varchar(10),
	constraint fk_acc1 foreign key (Customer_ID) references Customers(Customer_ID),
	constraint fk_acc2 foreign key (Account_No) references Accounts(Account_No),
	constraint fk_acc3 foreign key (prod_id) references Products(prod_id)
);


insert into products values ('PRD0001', 'Savings Account');
insert into products (prod_id, prod_name) values ('PRD0002', 'Current Account');
insert into products values ('PRD0003', 'Home Loan');
insert into products values ('PRD0004', 'Personal Loan');

insert into Employees values
	('E1', 'Mohan Kumar', 5000, 'M'),
	('E2', 'James Bond', 6000, 'M'),
	('E3', 'David Smith', 7000, 'M'),
	('E4', 'Alice Mathew', 5000, 'F');

insert into Customers values ('C1', 'Satya', 'Sharma', 9900889911, 'Bangalore', to_date('01-03-1990', 'dd-mm-yyyy'));
insert into Customers values ('C2', 'Jaswinder', 'Singh', 9900889922, 'Mumbai', to_date('024-03-1980', 'dd-mm-yyyy'));
insert into Customers values ('C3', 'Satya', 'Sharma', 9900889933, 'Pune', to_date('11-08-1992', 'dd-mm-yyyy'));
insert into Customers values ('C4', 'Maryam', 'Parveen', 9900889944, 'Delhi', to_date('01-12-1993', 'dd-mm-yyyy'));
insert into Customers values ('C5', 'Steven', 'Smith', null, 'Chennai', to_date('20-12-1994', 'dd-mm-yyyy'));
insert into Customers values ('C6', 'Jason', 'Holder', null, 'Chennai', to_date('01-02-1995', 'dd-mm-yyyy'));

insert into Accounts values (1100444101, 100, 'Active', to_date('01-01-2020','dd-mm-yyyy'));
insert into Accounts values (1100444102, 900, 'Active', to_date('10-01-2020','dd-mm-yyyy'));
insert into Accounts values (1100444103, 500, 'Active', to_date('21-11-2021','dd-mm-yyyy'));
insert into Accounts values (1100444104, 1100, 'Active', to_date('15-10-2022','dd-mm-yyyy'));
insert into Accounts values (1100444105, 2200, 'Active', to_date('10-12-2022','dd-mm-yyyy'));
insert into Accounts values (1100444106, 3300, 'Active', to_date('05-11-2022','dd-mm-yyyy'));

insert into Transactions values (default,current_date, 200, 'C', 1100444101);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-1, 100, 'C', 1100444101);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-1, 50, 'D', 1100444101);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-1, 100, 'C', 1100444102);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-2, 200, 'C', 1100444102);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-2, 100, 'D', 1100444102);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-3, 100, 'C', 1100444103);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-4, 200, 'C', 1100444104);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-5, 100, 'C', 1100444105);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-5, 200, 'D', 1100444105);

insert into Customer_Accounts values ('C1', 1100444101, 'PRD0001');
insert into Customer_Accounts values ('C1', 1100444102, 'PRD0003');
insert into Customer_Accounts values ('C1', 1100444103, 'PRD0004');
insert into Customer_Accounts values ('C2', 1100444105, 'PRD0002');
insert into Customer_Accounts values ('C3', 1100444106, 'PRD0002');
insert into Customer_Accounts values ('C1', 1100444104, 'PRD0004');


select * from products;
select * from Employees;
select * from Customers;
select * from Accounts;
select * from Transactions;
select * from Customer_Accounts;

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Difference between TRUNCATE and DELETE

update employees set salary=salary*2 where salary=1750;
select * from employees;


-- MERGE
create table employee_history as (select * from employees where 1=0) ;
select * from employee_history;  -- constraints not copied

merge into employee_history h using employees e on e.emp_id=h.emp_id
when matched and h.salary<>e.salary then
	update set salary=e.salary
when not matched then 
	insert (emp_id,emp_name,salary,gender) values (e.emp_id, e.emp_name, e.salary, e.gender)


-- VIEW
create view emp as select emp_name,gender from employees;
select * from emp;
-- GRANT 
create user PwC_auditors with password 'audit';
grant select on emp to PwC_auditors;
revoke select on emp to PwC_auditors;




-- 1) Fetch the transaction id, date and amount of all debit transactions
select * from Transactions where credit_debit_flag='D'; 

-- 2) Fetch male employees who earn more than 5000 salary.
select * from employees where gender='M' and salary>5000;

-- 3) Fetch employees whose name starts with J or whose salary is greater than or equal to 70000.
select * from employees where emp_name like 'J%' or salary>=70000;

-- 4) Fetch accounts with balance in between 1000 to 3000
select * from accounts where balance between 1000 and 3000;

-- 5) Using SQL, find out if a given number is even or odd ? (Given numbers are 432, 77)
-- CASE CONDITION THEN 'YES' ELSE 'NO' END "COLUMN_NAME";
select 432%2 as is_even_flag;
select 77%2 as is_even_flag;
select case when 434%2 = 0 then 'Even' else 'Odd' end even_odd_flag;

-- 6) Find customers who did not provide a phone no.
select * from customers where phone is null;

-- 7) Find all the different products purchased by the customers.
select distinct(prod_id) from customer_accounts;


-- 8) Sort all the active accounts based on highest balance and based on the earliest opening date.
select * from accounts where account_status='Active' order by balance asc;



-- 9) Fetch the oldest 5 transactions.
select * from Transactions order by transaction_date limit 5; 

-- 10) Find customers who are either from Bangalore/Chennai and their phone number is available OR those who were born before 1990.
select * 
from customers 
where 
	address in ('Bangalore','Chennai') 
	and phone is not null 
	or extract(year from dob) < '1990';

-- 11) Find total no of transactions in Feb 2023
select count(*) from transactions where to_char(transaction_date,'YYYY-MM')>='2023-02';


-- 12) How many total no of products purchased by customer "Satya Sharma".
select * from customers where concat(first_name,' ',last_name) ='Satya Sharma';
select * from customers where first_name||' ' || 	last_name ='Satya Sharma'

select 
	count(prod_id) as total_no_of_products 
from customer_accounts as ca 
join customers as c 
	on ca.customer_id=c.customer_id 
where  concat(first_name,' ',last_name) ='Satya Sharma';

-- 13) Display the full names of all employees and customers.
select  emp_name from employees
union all
select concat(customers.first_name,' ',customers.last_name) as cus_name from customers 



-- 14) Categorise accounts based on their balance.
-- [Below 1k is Low balance, between 1k to 2k is average balance, above 2k is high balance]
select 
	*,
	case 
		when balance<1000 then 'Low balance'
		when balance between 1000 and 2000 then 'Average balance'
		else 'High Balance'
	end as category
from accounts;


-- 15) Find the total balance of all savings account.
select
	sum(a.balance) as total_balance
from accounts as a
join customer_accounts as ca on ca.account_no = a.account_no
join products as p on p.prod_id = ca.prod_id
where p.prod_name='Savings Account'



-- 16) Display the total account balance in all the current and savings account.

select prod_name as account_type , sum(balance) as balance
from accounts a
join customer_accounts ca on ca.account_no=a.account_no
join products p on p.prod_id = ca.prod_id
where p.prod_name in ('Savings Account', 'Current Account')
group by prod_name



