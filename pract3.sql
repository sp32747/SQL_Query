SELECT release_year , 
count(*) as total_per_year
from movies
WHERE imdb_rating>4
GROUP BY release_year
HAVING total_per_year>2
ORDER BY release_year desc;



select * from movies LIMIT 5;

select release_year ,count(*) as total_per_year from movies
where imdb_rating>4
GROUP BY release_year
HAVING total_per_year>2
ORDER BY release_year desc;

SELECT m.movie_id,title,budget ,revenue, currency , unit from movies m 
join financials f on m.movie_id=f.movie_id;

SELECT * from financials;
select * from movies;



SELECT m.movie_id,title,budget ,revenue, currency , unit from movies m 
left join financials f on m.movie_id=f.movie_id;

SELECT m.movie_id,title,budget ,revenue, currency , unit from movies m 
right join financials f on m.movie_id=f.movie_id;

## full join
SELECT m.movie_id,title,budget ,revenue, currency , unit from movies m 
left join financials f on m.movie_id=f.movie_id

UNION

SELECT m.movie_id,title,budget ,revenue, currency , unit from movies m 
right join financials f on m.movie_id=f.movie_id;


### joining tables using multipli primary keys we will Use "USING" clause in join

SELECT m.movie_id,title,budget ,revenue, currency , unit from movies m 
right join financials using(movie_id);
