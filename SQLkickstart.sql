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


-- SECTION::2
-- Filter Rows
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

-- SECTION:: 4

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


-- SECTION::4 Relating Records With Joins
SELECT * FROM users;     -- id, username
SELECT * FROM "comments";-- id, contents, user_id, photo_id
SELECT * FROM photos;    -- id, url, user_id

-- User with most activity (more comments, more photos)
select 
	u.id,
	u.username,
	count(p.id) as num_photos,
	count(c.contents) as num_cmds
from users u 
left join photos p ON p.user_id = u.id
left join "comments" c on c.photo_id = p.id and c.user_id = p.id
group by u.id,u.username
order by 3 desc,4 desc;

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
SELECT 
	p.id AS photo_id,
	p.url AS photo_url,
	AVG(COUNT(c.id)) OVER(PARTITION BY p.id) as avgs
FROM "comments" c 
right join photos p on c.photo_id=p.id
group by p.url,p.id
order by 1;

-- Average number of comments per photo


-- SECTION::5
-- SECTION::6 # TODO: 24-07-24
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
-- SECTION::
