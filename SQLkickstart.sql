-- ORDER OF EXECUTION
-- FROM, JOIN, WHERE, GROUP BY, HAVING, SELECT, DISTINCT, ORDER BY, and finally, LIMIT/OFFSET

-- SECTION::1
DROP TABLE IF EXISTS cities CASCADE;
CREATE TABLE cities (
	name VARCHAR(50), 
  	country VARCHAR(50),
  	population INTEGER,
  	area INTEGER
);

INSERT INTO cities (name, country, population, area)
VALUES ('Tokyo', 'Japan', 38505000, 8223);

INSERT INTO cities (name, country, population, area)
VALUES 
	('Delhi', 'India', 28125000, 2240),
  	('Shanghai', 'China', 22125000, 4015),
	('Sao Paulo', 'Brazil', 20935000, 3043);

-- EXPLORE
SELECT * FROM cities;
SELECT 
	*,
	population/area AS population_density 
FROM cities;


/*
	STING Opeartor
	`||` join two string
	`concat`
	`lower`
	`length`
	`upper`
*/

SELECT 
	name || ',' || country   AS P1,
	CONCAT(name,',',country) AS P2,
	LOWER(name),
	UPPER(country) ,
	LENGTH(name) AS CHARLEN
FROM cities;


-- SECTION::2 Filter Rows
SELECT 
	name,
	area 
FROM cities
WHERE area>4000;

UPDATE cities SET population =39505000 WHERE name='Tokyo'
SELECT * FROM cities;

DELETE FROM cities WHERE name='Tokyo';
SELECT * FROM cities;

-- SECTION::3 Photo-Sharing-App   <users><photos><comments><likes>
/*
	One-to-One
	One-to-Many
	Many-to-Many
*/
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,   -- SERIAL makes
  username VARCHAR(50)
);

INSERT INTO users (username) VALUES ('monahan93'), ('pferrer');
-- INSERT INTO users (id,username) VALUES (4,'muthukamalan');   -- Uncomment to SEE ERROR in next line
INSERT INTO users (username) VALUES ('si93onis'),('99stroman');
SELECT * FROM users;


DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS photos;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50)
);

INSERT INTO users (username) VALUES ('monahan93'),('pferrer'),  ('si93onis'),  ('99stroman');

CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  url VARCHAR(200),
  -- user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
	user_id INTEGER REFERENCES users(id) ON DELETE SET NULL
);

INSERT INTO photos (url, user_id) 
VALUES 
	('http://one.jpg', 4),
	('http://two.jpg', 2),
	('http:/two.jpg', 1),
	('http:/25.jpg', 1),
	('http:/36.jpg', 1),
	('http:/754.jpg', 2),
	('http:/35.jpg', 3),
	('http:/256.jpg', 4),
	('http://three.jpg', 4),
	('http://three.jpg', 1),
	('http://three_cats.jpg', 3);

INSERT INTO photos (url, user_id)  VALUES  ('http://bored.jpg', NULL);

-- INSERT INTO photos (url, user_id)  VALUES  ('http://unknown_img.jpg', 41);

SELECT 
	users.id AS ssn_id,
	username AS user_name,
	url as image	
FROM users 
JOIN photos ON users.id=photos.user_id
WHERE users.username='99stroman';

SELECT * FROM users;
SELECT * FROM photos;

/* # DELETE options
	- ON DELETE RESTRICT
	- ON DELETE NO ACTION
	- ON DELETE CASCADE
	- ON DELETE NULL
	- ON DELETE SET DEFAULT
*/
-- ON RESTRICT CAN'T delete simply bcz if referenced in other table
-- ON CASCADE delete phots too
-- ON SET NULL make as user_id NULL
DELETE FROM users where id=4;
DELETE FROM users where id=4;

-- DROP TABLE users; -- CAN'T do referenced with other table

-- SECTION::4  Realting Records with  Joins

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS photos CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(50)
);
 
CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  url VARCHAR(200),
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);
 
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  contents VARCHAR(240),
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  photo_id INTEGER REFERENCES photos(id) ON DELETE CASCADE
);
 
INSERT INTO users (username) 
VALUES 
  ('Reyna.Marvin'),
        ('Micah.Cremin'),
        ('Alfredo66'),
        ('Gerard_Mitchell42'),
        ('Frederique_Donnelly');
 
INSERT INTO photos (url, user_id)
VALUES
  ('https://santina.net', 3),
        ('https://alayna.net', 5),
        ('https://kailyn.name', 3),
        ('http://marjolaine.name', 1),
        ('http://chet.net', 5),
        ('http://jerrold.org', 2),
        ('https://meredith.net', 4),
        ('http://isaias.net', 4),
        ('http://dayne.com', 4),
        ('http://colten.net', 2),
        ('https://adelbert.biz', 5),
        ('http://kolby.org', 1),
        ('https://deon.biz', 2),
        ('https://marina.com', 5),
        ('http://johnson.info', 1),
        ('https://linda.info', 2),
        ('https://tyrique.info', 4),
        ('http://buddy.info', 5),
        ('https://elinore.name', 2),
        ('http://sasha.com', 3);
INSERT INTO photos (url, user_id)  VALUES  ('http://bored.jpg', NULL);
 
INSERT INTO comments (contents, user_id, photo_id)
VALUES
  ('Quo velit iusto ducimus quos a incidunt nesciunt facilis.', 2, 4),
        ('Non est totam.', 5, 5),
        ('Fuga et iste beatae.', 3, 3),
        ('Molestias tempore est.', 1, 5),
        ('Est voluptatum voluptatem voluptatem est ullam quod quia in.', 1, 5),
        ('Aut et similique porro ullam.', 1, 3),
        ('Fugiat cupiditate consequatur sit magni at non ad omnis.', 1, 2),
        ('Accusantium illo maiores et sed maiores quod natus.', 2, 5),
        ('Perferendis cumque eligendi.', 1, 2),
        ('Nihil quo voluptatem placeat.', 5, 5),
        ('Rerum dolor sunt sint.', 5, 2),
        ('Id corrupti tenetur similique reprehenderit qui sint qui nulla tenetur.', 2, 1),
        ('Maiores quo quia.', 1, 5),
        ('Culpa perferendis qui perferendis eligendi officia neque ex.', 1, 4),
        ('Reprehenderit voluptates rerum qui veritatis ut.', 1, 1),
        ('Aut ipsum porro deserunt maiores sit.', 5, 3),
        ('Aut qui eum eos soluta pariatur.', 1, 1),
        ('Praesentium tempora rerum necessitatibus aut.', 4, 3),
        ('Magni error voluptas veniam ipsum enim.', 4, 2),
        ('Et maiores libero quod aliquam sit voluptas.', 2, 3),
        ('Eius ab occaecati quae eos aut enim rem.', 5, 4),
        ('Et sit occaecati.', 4, 3),
        ('Illum omnis et excepturi totam eum omnis.', 1, 5),
        ('Nemo nihil rerum alias vel.', 5, 1),
        ('Voluptas ab eius.', 5, 1),
        ('Dolor soluta quisquam voluptatibus delectus.', 3, 5),
        ('Consequatur neque beatae.', 4, 5),
        ('Aliquid vel voluptatem.', 4, 5),
        ('Maiores nulla ea non autem.', 4, 5),
        ('Enim doloremque delectus.', 1, 4),
        ('Facere vel assumenda.', 2, 5),
        ('Fugiat dignissimos dolorum iusto fugit voluptas et.', 2, 1),
        ('Sed cumque in et.', 1, 3),
        ('Doloribus temporibus hic eveniet temporibus corrupti et voluptatem et sint.', 5, 4),
        ('Quia dolorem officia explicabo quae.', 3, 1),
        ('Ullam ad laborum totam veniam.', 1, 2),
        ('Et rerum voluptas et corporis rem in hic.', 2, 3),
        ('Tempora quas facere.', 3, 1),
        ('Rem autem corporis earum necessitatibus dolores explicabo iste quo.', 5, 5),
        ('Animi aperiam repellendus in aut eum consequatur quos.', 1, 2),
        ('Enim esse magni.', 4, 3),
        ('Saepe cumque qui pariatur.', 4, 4),
        ('Sit dolorem ipsam nisi.', 4, 1),
        ('Dolorem veniam nisi quidem.', 2, 5),
        ('Porro illum perferendis nemo libero voluptatibus vel.', 3, 3),
        ('Dicta enim rerum culpa a quo molestiae nam repudiandae at.', 2, 4),
        ('Consequatur magnam autem voluptas deserunt.', 5, 1),
        ('Incidunt cum delectus sunt tenetur et.', 4, 3),
        ('Non vel eveniet sed molestiae tempora.', 2, 1),
        ('Ad placeat repellat et veniam ea asperiores.', 5, 1),
        ('Eum aut magni sint.', 3, 1),
        ('Aperiam voluptates quis velit explicabo ipsam vero eum.', 1, 3),
        ('Error nesciunt blanditiis quae quis et tempora velit repellat sint.', 2, 4),
        ('Blanditiis saepe dolorem enim eos sed ea.', 1, 2),
        ('Ab veritatis est.', 2, 2),
        ('Vitae voluptatem voluptates vel nam.', 3, 1),
        ('Neque aspernatur est non ad vitae nisi ut nobis enim.', 4, 3),
        ('Debitis ut amet.', 4, 2),
        ('Pariatur beatae nihil cum molestiae provident vel.', 4, 4),
        ('Aperiam sunt aliquam illum impedit.', 1, 4),
        ('Aut laudantium necessitatibus harum eaque.', 5, 3),
        ('Debitis voluptatum nesciunt quisquam voluptatibus fugiat nostrum sed dolore quasi.', 3, 2),
        ('Praesentium velit voluptatem distinctio ut voluptatum at aut.', 2, 2),
        ('Voluptates nihil voluptatum quia maiores dolorum molestias occaecati.', 1, 4),
        ('Quisquam modi labore.', 3, 2),
        ('Fugit quia perferendis magni doloremque dicta officia dignissimos ut necessitatibus.', 1, 4),
        ('Tempora ipsam aut placeat ducimus ut exercitationem quis provident.', 5, 3),
        ('Expedita ducimus cum quibusdam.', 5, 1),
        ('In voluptates doloribus aut ut libero possimus adipisci iste.', 3, 2),
        ('Sit qui est sed accusantium quidem id voluptatum id.', 1, 5),
        ('Libero eius quo consequatur laudantium reiciendis reiciendis aliquid nemo.', 1, 2),
        ('Officia qui reprehenderit ut accusamus qui voluptatum at.', 2, 2),
        ('Ad similique quo.', 4, 1),
        ('Commodi culpa aut nobis qui illum deserunt reiciendis.', 2, 3),
        ('Tenetur quam aut rerum doloribus est ipsa autem.', 4, 2),
        ('Est accusamus aut nisi sit aut id non natus assumenda.', 2, 4),
        ('Et sit et vel quos recusandae quo qui.', 1, 3),
        ('Velit nihil voluptatem et sed.', 4, 4),
        ('Sunt vitae expedita fugiat occaecati.', 1, 3),
        ('Consequatur quod et ipsam in dolorem.', 4, 2),
        ('Magnam voluptatum molestias vitae voluptatibus beatae nostrum sunt.', 3, 5),
        ('Alias praesentium ut voluptatem alias praesentium tempora voluptas debitis.', 2, 5),
        ('Ipsam cumque aut consectetur mollitia vel quod voluptates provident suscipit.', 3, 5),
        ('Ad dignissimos quia aut commodi vel ut nisi.', 3, 3),
        ('Fugit ut architecto doloremque neque quis.', 4, 5),
        ('Repudiandae et voluptas aut in excepturi.', 5, 3),
        ('Aperiam voluptatem animi.', 5, 1),
        ('Et mollitia vel soluta fugiat.', 4, 1),
        ('Ut nemo voluptas voluptatem voluptas.', 5, 2),
        ('At aut quidem voluptatibus rem.', 5, 1),
        ('Temporibus voluptates iure fuga alias minus eius.', 2, 3),
        ('Non autem laboriosam consectetur officiis aut excepturi nobis commodi.', 4, 3),
        ('Esse voluptatem sed deserunt ipsum eaque maxime rerum qui.', 5, 5),
        ('Debitis ipsam ut pariatur molestiae ut qui aut reiciendis.', 4, 4),
        ('Illo atque nihil et quod consequatur neque pariatur delectus.', 3, 3),
        ('Qui et hic accusantium odio quis necessitatibus et magni.', 4, 2),
        ('Debitis repellendus inventore omnis est facere aliquam.', 3, 3),
        ('Occaecati eos possimus deleniti itaque aliquam accusamus.', 3, 4),
        ('Molestiae officia architecto eius nesciunt.', 5, 4),
        ('Minima dolorem reiciendis excepturi culpa sapiente eos deserunt ut.', 3, 3);


SELECT * FROM users;     -- id, username
SELECT * FROM "comments";-- id, contents, user_id, photo_id
SELECT * FROM photos;    -- id, url, user_id


-- Who is commenting on their own photos?
select 
	DISTINCT p.url, c.contents,u.username
from photos p 
join users u on u.id=p.user_id
join "comments" c on c.user_id = u.id and c.photo_id=p.id order by 1;

-- For each comment, show the content and username who wrotes
select 
	c.contents,
	u.username
from "comments" as c 
join users as u on u.id=c.user_id;

-- For each comment, list the contents of the comment and the URL of the photo the comment was added to 
select 
	p.id,p.url,c.contents
from "comments" as c 
join photos as p on p.id = c.photo_id
order by p.id;

-- show each photo url and the username of the poster
select 
	p.id,p.url,u.username
from "users" as u
right join photos as p on u.id = p.user_id
order by u.id;

-- User with most activity (more comments, more photos)
select 
	u.id,
	u.username,
	count(p.id) as num_photos,
	count(c.contents) as num_cmds
from users u 
left join photos p ON p.user_id = u.id
left join "comments" c on c.photo_id = p.id and c.user_id = p.id
group by u.id,u.username order by 3 desc,4 desc;

-- Find all comments for the photo with ID=3, along with username of the comment authour
select 
	c.id as content_id,
	c.contents as contents,
	p.url as url,
	c.user_id as user_id,
	u.username as username
from "comments" c
join photos p on c.id=c.photo_id
join users u on u.id=c.user_id
where p.id=3;

-- Find the average number of comments per photos
select 
	p.id,
	p.url,
	-- avg(c.id)
	count(c.id)  -- count number of comments
from "comments" c 
right join photos p on p.id=c.photo_id
group by p.id order by p.id;

-- TODO:: ⚒️
-- Calculate the average number of characters/comment
-- Find the photo with id=10 and get the number of comments attached to it

-- SECTION::5 Aggregation of Records
SELECT user_id FROM "comments" GROUP BY user_id;
-- column must be in group by clause or be used in aggregate function
-- count, sum, avg, min, max
SELECT user_id,count(comments.id) total_cmds,u.username 
FROM "comments" 
JOIN users u on u.id=user_id
GROUP BY user_id,u.username order by 1;

/*
	INTERVIEW Question:: count(*) and count(column_name)

	count(column_name): not consider null records
	count(*): splits every row

*/

SELECT user_id,count(*) total_cmds,u.username 
FROM "comments" 
JOIN users u on u.id=user_id
GROUP BY user_id,u.username order by 1;

/*
	INTERVIEW Question: Where VS Having
	Where:: Filters the set of rows
	Having:: Filters the set of groups
*/

-- Filter the number of comments for each photo where the photo_id is less than 4 and the photo has more than 20 comments
select 
	p.id, p.url,count(c.id)
from "comments" c 
join photos p on p.id = c.photo_id
where p.id<4
group by p.id
having count(c.id)>20;

-- Find the users where the user has commented on the first 2 photos and the user added more than 2 comments on those photos;
select c.user_id,count(*)
from "comments" c 
where c.photo_id < 50
group by c.user_id
having count(*)>20


-- SECTION::6 Working with large  Dataset

DROP TABLE IF EXISTS users cascade;
DROP TABLE IF EXISTS products cascade;
DROP TABLE IF EXISTS orders cascade;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR
);
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  department VARCHAR,
  price INTEGER,
  weight INTEGER
);
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  product_id INTEGER REFERENCES products(id),
  paid BOOLEAN
);
 
 
INSERT INTO users (first_name, last_name) 
VALUES 
  ('Iva', 'Lindgren'),
  ('Ignatius', 'Johns'),
  ('Jannie', 'Boehm'),
  ('Neal', 'Wehner'),
  ('Mikayla', 'Casper'),
  ('Patience', 'Stracke'),
  ('Josianne', 'Gerhold'),
  ('Kailee', 'Jacobson'),
  ('Marlen', 'Hickle'),
  ('Pansy', 'Daugherty'),
  ('Vinnie', 'Feest'),
  ('Cierra', 'Johns'),
  ('Violette', 'Heathcote'),
  ('Stan', 'Rath'),
  ('Neha', 'Hyatt'),
  ('Kaylah', 'Gleason'),
  ('Jacky', 'Hegmann'),
  ('Duane', 'Lockman'),
  ('Sonya', 'Marquardt'),
  ('Brenden', 'Streich'),
  ('Laurianne', 'Douglas'),
  ('Orlando', 'Kerluke'),
  ('Irma', 'Wintheiser'),
  ('Cletus', 'Schultz'),
  ('Jermaine', 'Langosh'),
  ('Alexanne', 'Dickens'),
  ('Garret', 'Williamson'),
  ('Max', 'Goodwin'),
  ('Tad', 'Wilderman'),
  ('Lindsay', 'Yost'),
  ('Elliot', 'Oberbrunner'),
  ('Brendan', 'Thompson'),
  ('Brennan', 'Auer'),
  ('Luigi', 'Johnston'),
  ('Garth', 'McLaughlin'),
  ('Ressie', 'Nikolaus'),
  ('Ruby', 'Turner'),
  ('Caden', 'Turcotte'),
  ('Armand', 'Kshlerin'),
  ('Albertha', 'Yundt'),
  ('Kathryn', 'Mueller'),
  ('Arely', 'McGlynn'),
  ('Lawrence', 'Casper'),
  ('Johathan', 'Kirlin'),
  ('Clara', 'Gerhold'),
  ('Miller', 'Feil'),
  ('Rosendo', 'Sawayn'),
  ('Sally', 'Mann'),
  ('Kennith', 'Hettinger'),
  ('Mathilde', 'Eichmann');
 
INSERT INTO products (name, department, price, weight)
VALUES
  ('Practical Fresh Shirt', 'Toys', 876.00, 3),
  ('Gorgeous Steel Towels', 'Outdoors', 412.00, 16),
  ('Rustic Plastic Bacon', 'Movies', 10.00, 6),
  ('Tasty Wooden Ball', 'Industrial', 796.00, 23),
  ('Fantastic Soft Fish', 'Tools', 10.00, 10),
  ('Gorgeous Concrete Towels', 'Grocery', 328.00, 11),
  ('Incredible Granite Mouse', 'Home', 989.00, 2),
  ('Gorgeous Rubber Ball', 'Books', 801.00, 4),
  ('Generic Fresh Computer', 'Toys', 926.00, 11),
  ('Unbranded Cotton Shoes', 'Sports', 298.00, 29),
  ('Fantastic Metal Chair', 'Home', 887.00, 9),
  ('Ergonomic Metal Pizza', 'Jewelery', 463.00, 16),
  ('Ergonomic Steel Car', 'Outdoors', 53.00, 20),
  ('Licensed Steel Car', 'Movies', 664.00, 10),
  ('Tasty Metal Cheese', 'Beauty', 650.00, 17),
  ('Handcrafted Rubber Towels', 'Baby', 945.00, 6),
  ('Intelligent Metal Mouse', 'Music', 509.00, 7),
  ('Awesome Cotton Salad', 'Shoes', 211.00, 16),
  ('Unbranded Plastic Pizza', 'Industrial', 72.00, 9),
  ('Practical Concrete Sausages', 'Industrial', 408.00, 9),
  ('Handcrafted Frozen Chair', 'Garden', 411.00, 16),
  ('Generic Cotton Pizza', 'Home', 555.00, 4),
  ('Intelligent Cotton Chips', 'Books', 280.00, 21),
  ('Small Plastic Soap', 'Beauty', 345.00, 1),
  ('Small Wooden Pizza', 'Garden', 307.00, 7),
  ('Rustic Rubber Soap', 'Beauty', 127.00, 2),
  ('Handmade Plastic Gloves', 'Sports', 301.00, 10),
  ('Unbranded Cotton Tuna', 'Jewelery', 633.00, 10),
  ('Practical Plastic Towels', 'Games', 379.00, 20),
  ('Practical Wooden Shoes', 'Computers', 112.00, 20),
  ('Sleek Granite Towels', 'Toys', 797.00, 30),
  ('Practical Rubber Mouse', 'Garden', 948.00, 15),
  ('Handcrafted Concrete Bike', 'Toys', 748.00, 10),
  ('Rustic Granite Chair', 'Electronics', 76.00, 8),
  ('Unbranded Wooden Ball', 'Sports', 384.00, 2),
  ('Licensed Frozen Chair', 'Books', 417.00, 9),
  ('Handmade Rubber Chicken', 'Movies', 959.00, 22),
  ('Awesome Fresh Keyboard', 'Home', 982.00, 30),
  ('Generic Fresh Hat', 'Baby', 791.00, 25),
  ('Licensed Plastic Keyboard', 'Garden', 433.00, 17),
  ('Fantastic Steel Chicken', 'Computers', 472.00, 17),
  ('Tasty Rubber Soap', 'Tools', 823.00, 6),
  ('Refined Wooden Mouse', 'Music', 842.00, 15),
  ('Gorgeous Steel Cheese', 'Movies', 548.00, 9),
  ('Fantastic Fresh Sausages', 'Industrial', 360.00, 26),
  ('Incredible Granite Bacon', 'Music', 982.00, 9),
  ('Handcrafted Fresh Sausages', 'Games', 231.00, 21),
  ('Intelligent Fresh Ball', 'Home', 619.00, 9),
  ('Handmade Plastic Fish', 'Games', 312.00, 23),
  ('Handcrafted Cotton Bacon', 'Kids', 480.00, 12),
  ('Sleek Rubber Shoes', 'Jewelery', 597.00, 6),
  ('Handmade Granite Fish', 'Electronics', 166.00, 14),
  ('Practical Wooden Chips', 'Toys', 707.00, 4),
  ('Handmade Rubber Salad', 'Outdoors', 232.00, 13),
  ('Unbranded Granite Shirt', 'Music', 519.00, 13),
  ('Gorgeous Plastic Sausages', 'Movies', 556.00, 2),
  ('Awesome Steel Mouse', 'Clothing', 175.00, 5),
  ('Licensed Steel Towels', 'Industrial', 939.00, 23),
  ('Handcrafted Fresh Bacon', 'Sports', 387.00, 29),
  ('Fantastic Cotton Shirt', 'Health', 496.00, 24),
  ('Licensed Cotton Sausages', 'Sports', 751.00, 27),
  ('Ergonomic Fresh Pants', 'Baby', 638.00, 30),
  ('Handcrafted Frozen Shoes', 'Sports', 84.00, 1),
  ('Small Concrete Pants', 'Health', 487.00, 19),
  ('Intelligent Plastic Car', 'Shoes', 628.00, 13),
  ('Intelligent Cotton Chips', 'Baby', 521.00, 22),
  ('Licensed Steel Towels', 'Health', 132.00, 11),
  ('Sleek Soft Computer', 'Movies', 619.00, 7),
  ('Fantastic Fresh Shirt', 'Tools', 643.00, 17),
  ('Generic Fresh Shoes', 'Kids', 628.00, 29),
  ('Sleek Fresh Gloves', 'Clothing', 919.00, 15),
  ('Gorgeous Rubber Keyboard', 'Baby', 32.00, 8),
  ('Handcrafted Soft Chicken', 'Kids', 720.00, 8),
  ('Small Metal Mouse', 'Baby', 60.00, 6),
  ('Fantastic Fresh Chips', 'Home', 966.00, 14),
  ('Awesome Metal Pants', 'Shoes', 460.00, 8),
  ('Handcrafted Frozen Chips', 'Shoes', 564.00, 19),
  ('Gorgeous Plastic Gloves', 'Movies', 341.00, 14),
  ('Rustic Metal Salad', 'Health', 240.00, 12),
  ('Small Fresh Gloves', 'Garden', 991.00, 8),
  ('Small Fresh Bacon', 'Baby', 473.00, 10),
  ('Refined Rubber Tuna', 'Garden', 1.00, 21),
  ('Small Metal Chips', 'Home', 161.00, 27),
  ('Unbranded Fresh Tuna', 'Home', 657.00, 9),
  ('Refined Metal Hat', 'Industrial', 309.00, 21),
  ('Refined Concrete Pants', 'Sports', 724.00, 2),
  ('Licensed Plastic Salad', 'Beauty', 834.00, 5),
  ('Licensed Soft Chicken', 'Toys', 425.00, 13),
  ('Fantastic Granite Soap', 'Home', 666.00, 29),
  ('Awesome Steel Towels', 'Baby', 552.00, 10),
  ('Ergonomic Wooden Tuna', 'Garden', 778.00, 29),
  ('Fantastic Wooden Chair', 'Jewelery', 145.00, 26),
  ('Tasty Granite Chips', 'Home', 37.00, 9),
  ('Tasty Rubber Table', 'Computers', 525.00, 29),
  ('Ergonomic Granite Shoes', 'Beauty', 48.00, 12),
  ('Refined Metal Tuna', 'Jewelery', 708.00, 23),
  ('Intelligent Rubber Chicken', 'Industrial', 1.00, 11),
  ('Practical Steel Shoes', 'Toys', 947.00, 14),
  ('Handcrafted Rubber Shoes', 'Sports', 275.00, 6),
  ('Intelligent Cotton Gloves', 'Home', 447.00, 29);
 
INSERT INTO orders (user_id, product_id, paid)
VALUES
  (41, 100, true),
  (27, 99, false),
  (50, 72, false),
  (24, 81, true),
  (24, 54, true),
  (1, 6, true),
  (17, 25, false),
  (8, 5, true),
  (34, 3, true),
  (41, 19, true),
  (15, 23, true),
  (23, 60, true),
  (31, 44, true),
  (46, 34, false),
  (11, 76, false),
  (44, 74, true),
  (18, 58, true),
  (40, 1, false),
  (41, 22, true),
  (10, 20, false),
  (50, 49, false),
  (14, 30, true),
  (4, 38, false),
  (42, 34, true),
  (22, 16, false),
  (4, 89, true),
  (49, 18, true),
  (35, 30, true),
  (7, 59, false),
  (31, 25, true),
  (43, 16, false),
  (18, 27, false),
  (47, 91, true),
  (32, 22, false),
  (5, 11, false),
  (14, 68, false),
  (19, 8, false),
  (43, 74, true),
  (29, 1, false),
  (7, 6, true),
  (16, 3, true),
  (29, 15, false),
  (25, 80, true),
  (5, 15, true),
  (23, 9, true),
  (20, 28, false),
  (18, 21, true),
  (34, 27, false),
  (33, 44, true),
  (26, 18, false),
  (10, 42, false),
  (49, 47, true),
  (4, 87, true),
  (8, 82, true),
  (32, 96, true),
  (3, 88, true),
  (2, 8, true),
  (49, 25, false),
  (3, 34, true),
  (38, 81, false),
  (41, 69, true),
  (50, 19, true),
  (44, 44, false),
  (20, 52, false),
  (16, 44, false),
  (50, 62, false),
  (47, 4, false),
  (4, 2, true),
  (36, 56, true),
  (49, 18, true),
  (20, 63, true),
  (18, 44, true),
  (30, 69, true),
  (33, 52, true),
  (18, 1, true),
  (39, 94, true),
  (39, 53, true),
  (31, 75, true),
  (39, 64, false),
  (33, 46, false),
  (16, 43, false),
  (41, 41, false),
  (33, 77, true),
  (8, 95, false),
  (16, 75, false),
  (4, 12, false),
  (14, 4, true),
  (31, 90, true),
  (30, 77, true),
  (44, 53, false),
  (34, 70, true),
  (23, 76, false),
  (22, 87, false),
  (45, 15, true),
  (14, 15, true),
  (6, 11, true),
  (3, 84, false),
  (25, 89, true),
  (5, 66, true),
  (40, 70, false),
  (10, 95, true),
  (22, 39, true),
  (13, 13, false),
  (12, 46, false),
  (28, 77, false),
  (14, 67, false),
  (11, 52, false),
  (11, 6, false),
  (32, 17, true),
  (40, 79, true),
  (5, 84, true),
  (38, 67, false),
  (45, 8, false),
  (21, 90, true),
  (38, 9, true),
  (23, 33, false),
  (14, 32, false),
  (47, 71, false),
  (15, 63, true),
  (12, 13, true),
  (32, 76, true),
  (17, 23, true),
  (48, 20, false),
  (25, 29, true),
  (20, 18, true),
  (49, 6, true),
  (28, 97, false),
  (2, 29, true),
  (36, 96, false),
  (13, 99, false),
  (36, 70, false),
  (34, 38, true),
  (15, 11, false),
  (19, 17, false),
  (32, 73, true),
  (45, 27, true),
  (34, 86, false),
  (27, 68, true),
  (49, 90, false),
  (10, 60, true),
  (31, 84, false),
  (35, 83, false),
  (28, 43, false),
  (39, 95, false),
  (11, 53, true),
  (8, 89, true),
  (23, 7, true),
  (39, 42, false),
  (41, 60, false),
  (25, 18, true),
  (38, 88, false),
  (47, 69, true),
  (15, 13, true),
  (37, 35, false),
  (37, 52, true),
  (12, 80, false),
  (39, 40, true),
  (28, 23, false),
  (3, 58, false),
  (33, 92, false),
  (38, 51, true),
  (18, 15, false),
  (25, 57, false),
  (46, 28, false),
  (42, 49, true),
  (31, 5, true),
  (37, 29, false),
  (4, 64, true),
  (23, 12, false),
  (37, 93, true),
  (13, 46, true),
  (4, 95, false),
  (44, 59, true),
  (39, 72, false),
  (28, 44, true),
  (3, 55, false),
  (17, 36, false),
  (7, 40, false),
  (4, 69, true),
  (39, 22, true),
  (25, 2, false),
  (21, 88, false),
  (13, 1, true),
  (34, 76, false),
  (9, 19, true),
  (43, 95, false),
  (42, 16, false),
  (50, 35, false),
  (7, 61, false),
  (16, 17, true),
  (45, 25, true),
  (36, 53, true),
  (5, 85, false),
  (1, 27, true),
  (29, 29, true),
  (14, 41, true),
  (1, 95, true),
  (2, 1, true),
  (43, 63, true),
  (6, 36, true),
  (34, 26, true),
  (35, 52, false),
  (14, 92, true),
  (18, 100, true),
  (13, 17, true),
  (25, 69, false),
  (45, 3, false),
  (37, 85, false),
  (44, 87, false),
  (36, 1, true),
  (15, 68, false),
  (12, 30, true),
  (22, 41, false),
  (16, 26, true),
  (34, 46, false),
  (33, 33, false),
  (31, 31, false),
  (41, 75, true),
  (32, 66, false),
  (11, 30, true),
  (29, 20, false),
  (16, 13, false),
  (39, 79, false),
  (45, 94, false),
  (9, 96, false),
  (36, 47, false),
  (2, 34, true),
  (43, 38, true),
  (27, 6, true),
  (19, 55, true),
  (29, 48, false),
  (45, 85, false),
  (18, 38, false),
  (1, 15, true),
  (13, 25, false),
  (14, 10, false),
  (31, 28, false),
  (20, 85, false),
  (18, 88, true),
  (8, 8, false),
  (24, 58, false),
  (24, 48, true),
  (24, 68, false),
  (29, 87, true),
  (6, 36, true),
  (46, 51, true),
  (20, 21, false),
  (18, 40, true),
  (36, 12, false),
  (22, 54, true),
  (22, 10, true),
  (20, 13, false),
  (2, 33, true),
  (20, 46, true),
  (48, 37, true),
  (41, 2, false),
  (2, 53, true),
  (45, 87, false),
  (5, 35, false),
  (28, 46, false),
  (42, 79, true),
  (27, 45, false),
  (11, 21, false),
  (36, 96, false),
  (35, 59, true),
  (30, 92, true),
  (17, 28, false),
  (28, 28, true),
  (23, 43, true),
  (44, 24, false),
  (26, 98, false),
  (36, 51, false),
  (1, 66, false),
  (47, 92, false),
  (1, 36, false),
  (9, 8, false),
  (42, 97, true),
  (32, 38, false),
  (17, 60, true),
  (14, 24, true),
  (43, 14, true),
  (47, 21, true),
  (38, 46, true),
  (22, 75, false),
  (19, 47, true),
  (10, 37, true),
  (9, 11, true),
  (44, 56, true),
  (50, 6, true),
  (21, 99, false),
  (34, 4, true),
  (5, 37, false),
  (8, 11, false),
  (12, 66, false),
  (21, 74, true),
  (38, 53, false),
  (24, 54, false),
  (33, 85, true),
  (9, 57, false),
  (20, 71, true),
  (21, 4, false),
  (38, 96, false),
  (35, 50, false),
  (16, 89, false),
  (45, 95, true),
  (33, 92, false),
  (41, 87, false),
  (25, 15, false),
  (42, 86, false),
  (2, 68, false),
  (5, 85, true),
  (42, 43, false),
  (15, 8, true),
  (13, 3, true),
  (24, 86, false),
  (34, 66, false),
  (35, 98, false),
  (48, 90, false),
  (34, 97, false),
  (48, 36, true),
  (21, 31, false),
  (40, 93, false),
  (26, 89, true),
  (47, 15, true),
  (27, 24, true),
  (30, 34, false),
  (44, 23, true),
  (17, 54, true),
  (31, 42, false),
  (42, 32, false),
  (20, 55, true),
  (2, 80, true),
  (30, 70, true),
  (24, 18, true),
  (5, 96, false),
  (50, 31, false),
  (35, 98, true),
  (41, 30, false),
  (48, 22, true),
  (19, 31, false),
  (34, 33, false),
  (19, 58, false),
  (26, 72, false),
  (34, 59, true),
  (8, 39, true),
  (40, 73, false),
  (44, 56, false),
  (36, 91, true),
  (33, 56, false),
  (36, 90, true),
  (28, 22, false),
  (49, 70, true),
  (19, 14, true),
  (39, 59, false),
  (17, 39, false),
  (40, 72, true),
  (21, 96, false),
  (3, 66, true),
  (23, 6, true),
  (6, 6, false),
  (18, 52, true),
  (48, 87, true),
  (40, 83, true),
  (23, 10, true),
  (21, 6, false),
  (24, 63, true),
  (18, 67, false),
  (35, 47, false),
  (26, 62, false),
  (14, 37, false),
  (9, 51, false),
  (1, 51, true),
  (35, 29, false),
  (49, 66, true),
  (45, 47, false),
  (26, 52, false),
  (31, 60, false),
  (4, 89, false),
  (43, 46, true),
  (16, 23, false),
  (37, 97, true),
  (47, 70, false),
  (22, 88, false),
  (21, 45, true),
  (46, 25, true),
  (36, 80, true),
  (42, 20, true),
  (14, 5, false),
  (10, 65, false),
  (14, 30, false),
  (1, 37, false),
  (2, 22, true),
  (41, 3, true),
  (47, 17, true),
  (34, 50, true),
  (23, 60, false),
  (13, 29, true),
  (18, 16, true),
  (23, 91, true),
  (46, 68, false),
  (3, 87, false),
  (31, 52, false),
  (49, 23, false),
  (50, 75, true),
  (20, 43, true),
  (13, 100, false),
  (14, 6, false),
  (19, 99, true),
  (45, 82, true),
  (41, 66, true),
  (9, 39, true),
  (18, 41, true),
  (47, 17, false),
  (25, 100, true),
  (49, 57, false),
  (41, 15, false),
  (22, 41, false),
  (15, 1, true),
  (29, 96, true),
  (2, 78, true),
  (4, 87, true),
  (22, 99, true),
  (41, 7, false),
  (6, 98, true),
  (41, 20, false),
  (25, 17, false),
  (21, 54, true),
  (48, 64, true),
  (4, 29, false),
  (46, 98, true),
  (23, 66, true),
  (35, 64, true),
  (37, 98, false),
  (30, 84, false),
  (8, 24, false),
  (12, 56, true),
  (7, 23, true),
  (25, 31, true),
  (25, 46, false),
  (49, 80, false),
  (29, 97, false),
  (30, 60, true),
  (50, 37, true),
  (42, 48, false),
  (44, 24, true),
  (34, 93, true),
  (7, 44, true),
  (34, 13, true),
  (37, 47, false),
  (40, 12, false),
  (43, 76, true),
  (41, 2, false),
  (12, 22, true),
  (2, 75, true),
  (19, 18, false),
  (31, 39, true),
  (20, 72, true),
  (25, 15, false),
  (42, 34, false),
  (33, 13, false),
  (40, 8, true),
  (5, 33, true),
  (44, 28, true),
  (29, 5, true),
  (37, 88, false),
  (44, 61, false),
  (1, 57, false),
  (39, 28, true),
  (25, 88, false),
  (47, 52, false),
  (1, 42, false),
  (26, 97, true),
  (29, 24, false),
  (19, 48, true),
  (5, 60, true),
  (45, 74, true),
  (25, 97, true),
  (37, 71, false),
  (30, 18, false),
  (7, 6, true),
  (38, 9, true),
  (36, 56, true),
  (34, 17, true),
  (19, 90, true),
  (7, 16, true),
  (6, 43, true),
  (15, 22, false),
  (1, 60, true),
  (9, 65, true),
  (35, 21, true),
  (18, 62, false),
  (1, 36, false),
  (30, 26, false),
  (12, 82, false),
  (34, 30, false),
  (18, 86, true),
  (12, 77, true),
  (12, 37, false),
  (31, 12, false),
  (6, 28, false),
  (13, 68, false),
  (41, 81, true),
  (6, 87, false),
  (21, 10, false),
  (28, 53, true),
  (30, 22, false),
  (47, 24, false),
  (22, 84, false),
  (21, 88, false),
  (39, 81, true),
  (42, 15, false),
  (25, 31, true),
  (1, 6, false),
  (11, 82, true),
  (8, 64, false),
  (50, 16, true),
  (17, 9, false),
  (41, 36, true),
  (23, 18, true),
  (32, 64, true),
  (2, 73, true),
  (24, 52, true),
  (22, 12, true),
  (17, 32, true),
  (32, 76, true),
  (20, 95, false),
  (36, 33, true),
  (18, 52, false),
  (24, 34, true),
  (21, 48, false),
  (9, 65, false),
  (7, 67, true),
  (22, 54, false),
  (18, 40, false),
  (6, 11, true),
  (29, 34, true),
  (39, 11, true),
  (16, 60, false),
  (19, 11, false),
  (31, 38, false),
  (18, 58, true),
  (7, 16, false),
  (12, 85, false),
  (32, 95, false),
  (24, 45, false),
  (50, 80, false),
  (5, 66, true),
  (27, 56, false),
  (36, 95, false),
  (3, 32, true);


SELECT * FROM users;
SELECT * FROM products;
SELECT * FROM orders;

SELECT paid,count(*) FROM orders GROUP BY paid;
SELECT 
	u.first_name,
	u.last_name,
	o.paid
FROM orders o JOIN users u ON o.user_id=u.id;


-- SECTION::7 Sorting Reords
SELECT * FROM products ORDER BY price DESC; --ASC
SELECT * FROM products ORDER BY price DESC,"name" ASC;
SELECT * FROM users OFFSET 40;
SELECT * FROM users OFFSET 40 LIMIT 5;
-- Pagination
SELECT * FROM users OFFSET 40 LIMIT 500; --no error
 
-- SECTION::8 Union & Intersection With Sets
-- SECTION::9 # TODO: 26-07-24
-- SECTION::10# TODO: 29-07-24
-- SECTION::11# TODO: 29-07-24
-- SECTION::12# TODO: 29-07-24
-- SECTION::13
-- SECTION::14
-- SECTION::15
-- SECTION::16
-- SECTION::17
-- SECTION::18
-- SECTION::19
-- SECTION::20
-- SECTION::21
-- SECTION::22
-- SECTION::23
-- SECTION::24
-- SECTION::25
-- SECTION::26
-- SECTION::27
-- SECTION::28
-- SECTION::29
-- SECTION::30
-- SECTION::31
-- SECTION::32
-- SECTION::33
-- SECTION::34
-- SECTION::35
-- SECTION::36