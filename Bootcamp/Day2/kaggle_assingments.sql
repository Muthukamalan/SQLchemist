-- Kaggle assignment
drop table if exists imdb_top_movies;
create table if not exists imdb_top_movies
(
	Poster_Link		varchar(4000),
	Series_Title	varchar(1000),
	Released_Year	varchar(10),
	Certificate		varchar(10),
	Runtime			varchar(20),
	Genre			varchar(s50),
	IMDB_Rating		decimal,
	Overview		varchar(4000),
	Meta_score		int,
	Director		varchar(200),
	Star1			varchar(200),
	Star2			varchar(200),
	Star3			varchar(200),
	Star4			varchar(200),
	No_of_Votes		bigint,
	Gross			money
);

select * from imdb_top_movies;



/*
1) Fetch all data from imdb table 
2) Fetch only the name and release year for all movies.
3) Fetch the name, release year and imdb rating of movies which are UA certified.
4) Fetch the name and genre of movies which are UA certified and have a Imdb rating of over 8.
5) Find out how many movies are of Drama genre.
6) How many movies are directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and "Rajkumar Hirani".
7) What is the highest imdb rating given so far?
8) What is the highest and lowest imdb rating given so far?
8a) Solve the above problem but display the results in different rows.
8b) Solve the above problem but display the results in different rows. And have a column which indicates the value as lowest and highest.
9) Find out the total business done by movies staring "Aamir Khan".
10) Find out the average imdb rating of movies which are neither directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and are not acted by any of these stars "Christian Bale", "Liam Neeson", "Heath Ledger", "Leonardo DiCaprio", "Anne Hathaway".

11) Mention the movies involving both "Steven Spielberg" and "Tom Cruise".
12) Display the movie name and watch time (in both mins and hours) which have over 9 imdb rating.
13) What is the average imdb rating of movies which are released in the last 10 years and have less than 2 hrs of runtime.
14) Identify the Batman movie which is not directed by "Christopher Nolan".
15) Display all the A and UA certified movies which are either directed by "Steven Spielberg", "Christopher Nolan" or which are directed by other directors but have a rating of over 8.
--16) What are the different certificates given to movies?
17) Display all the movies acted by Tom Cruise in the order of their release. Consider only movies which have a meta score.
--18) Segregate all the Drama and Comedy movies released in the last 10 years as per their runtime. Movies shorter than 1 hour should be termed as short film. Movies longer than 2 hrs should be termed as longer movies. All others can be termed as Good watch time.
19) Write a query to display the "Christian Bale" movies which released in odd year and even year. Sort the data as per Odd year at the top.
20) Re-write problem #18 without using case statement.



-- Extra Assignment:
1) Split the value '1234_1234' into 2 seperate columns having 1234 each.

2) We see a string value 'PG' in released_year and we hardcoaded it, can we make a query dynamic to identify string value incase if we have multiple string values in-order to ignore those string values
 Write a query to identify non numeric values in a column.
 
*/


-- 8) What is the highest and lowest imdb rating given so far?
select max(imdb_rating) as highest_rating, min(imdb_rating) as lowest_rating from imdb_top_movies;

-- 8b) Solve the above problem but display the results in different rows. And have a column which indicates the value as lowest and highest.
select max(imdb_rating) as rating, 'Highest' as category from imdb_top_movies
union all
select min(imdb_rating) as rating, 'Lowest' as category from imdb_top_movies



-- 9) Find out the total business done by movies staring "Aamir Khan".
select sum(gross)
from imdb_top_movies 
where 
	-- star1='Aamir Khan'  or star2='Aamir Khan'  or star3='Aamir Khan'  or star4='Aamir Khan';
	'Aamir Khan' in (star1,star2,star3,star4);


-- 12) Display the movie name and watch time (in both mins and hours) which have over 9 imdb rating.

select 
	series_title  as movie_name,
	runtime as runtime_mins,
	-- runtime/60 as runtime_hours,
	round( cast(replace(runtime,'min','') as decimal)/60, 4) as runtime_hours
from imdb_top_movies
	


-- 13) What is the average imdb rating of movies which are released in the last 10 years and have less than 2 hrs of runtime.
select 
	round(avg(imdb_top_movies.imdb_rating) ,2) as avg_rating
from imdb_top_movies 
where 
	imdb_top_movies.released_year~'[0-9]'	
	and imdb_top_movies.released_year>( extract(year from current_date)-10)::varchar
	and replace(runtime,'min','')::int <=120



--18) Segregate all the Drama and Comedy movies released in the last 10 years as per their runtime. Movies shorter than 1 hour should be termed as short film. Movies longer than 2 hrs should be termed as longer movies. All others can be termed as Good watch time.
select 
	imdb_top_movies.series_title,
	round( cast(replace(runtime,'min','') as decimal)/60, 2) as runtime_hrs,
	case 
		when 	round( cast(replace(runtime,'min','') as decimal)/60, 2)  < 1 then 'Short'
		when 	round( cast(replace(runtime,'min','') as decimal)/60, 2)  between 1 and 2 then 'Mid'
		else 'longer'	
	end as category
from imdb_top_movies 
where 
	lower(genre) like '%drama%' or lower(genre) like '%comedy' 
	and imdb_top_movies.released_year>( extract(year from current_date)-10)::varchar
order by 2 asc;


-- 3:00:00
-- 20) Re-write problem #18 without using case statement.

-- 19) Write a query to display the "Christian Bale" movies which released in odd year and even year. Sort the data as per Odd year at the top.



-- drop table if exists imdb_top_movies