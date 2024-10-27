select distinct industry from movies;

select count(*) from movies where industry="hollywood";

select * from movies where title like "%THOR%";

select  * from movies where studio="";

select * from movies where imdb_rating>=9;

select * from movies where imdb_rating between 6 and 8;

select count(*) from movies where imdb_rating between 6 and 8;

#same as using or 
select * from movies where release_year in (2018,2019,2013);

select * from movies where imdb_rating is  null;

SELECT * FROM movies WHERE industry='Bollywood' ORDER BY imdb_rating;

SELECT * FROM movies WHERE industry='Bollywood' ORDER BY imdb_rating DESC;

SELECT * FROM movies WHERE industry='hollywood' ORDER BY imdb_rating LIMIT 5;

SELECT * from movies where industry="hollywood" ORDER BY imdb_rating limit 5 OFFSET 1;
SELECT MAX(imdb_rating) FROM movies WHERE  industry='hollywood';

select MIN(imdb_rating) from movies where industry="bollywood";

SELECT round(avg(imdb_rating),2) as avg_rating,
		round(MIN(imdb_rating),2) as min_rating,
        round(MAX(imdb_rating),2) as max_rating
from movies where industry="bollywood";

#DESCRIBE movies;

SELECT industry,count(*) as total
from movies
GROUP BY industry;

SELECT studio,
count(*) as total,
avg(imdb_rating) as rating
from movies
where studio!=""
GROUP BY studio
ORDER BY total DESC;

SELECT industry,
count(*) as total,
avg(imdb_rating) as rating
from movies
GROUP BY industry
ORDER BY rating DESC;
##print all the years where more then two movies were released
## FROM->WHERE -> GROUP BY -> HAVING -> OREDER BY

SELECT * FROM movies LIMIT 5;

SELECT release_year , 
count(*) as total_per_year
from movies
WHERE imdb_rating>4
GROUP BY release_year
HAVING total_per_year>2
ORDER BY release_year desc;

select * from financials limit 10;

SELECT * ,
if(currency="USD",77*revenue,revenue) as revenue_in_inr
from financials;

select * from actors limit 5;
select * from movie_actor limit 5;
select * from financials limit 5;
select * from languages limit 5;
select * from movies limit 5;

##inner join

select movies.movie_id, title ,release_year , budget ,revenue, unit 
FROM movies INNER JOIN 
financials on movies.movie_id=financials.movie_id;

select m.movie_id, title ,release_year , budget ,revenue, unit 
FROM movies m INNER JOIN 
financials f on m.movie_id=f.movie_id;

## outer join

select m.movie_id, title ,release_year , budget ,revenue, unit 
FROM movies m left JOIN 
financials f on m.movie_id=f.movie_id;

select f.movie_id, title ,release_year , budget ,revenue, unit 
FROM movies m right JOIN 
financials f on m.movie_id=f.movie_id;

##full join
select m.movie_id, title ,release_year , budget ,revenue, unit 
FROM movies m left JOIN 
financials f on m.movie_id=f.movie_id
union
select f.movie_id, title ,release_year , budget ,revenue, unit 
FROM movies m right JOIN 
financials f on m.movie_id=f.movie_id;















