select * from product;

#highest priced product from each category
select * , FIRST_VALUE(product_name) over(PARTITION BY product_category ORDER BY price desc ) as max_priced_product_category from product;




select * , 
FIRST_VALUE(product_name) over(PARTITION BY product_category order by price desc) as highest_price_in_ctgry 
from product;

# lowest price in category only using last_value willl give wrong answer as the lowest category 
#column has filled with all the categories instead of giving one category
#bcoz default frame in a window is the current row and preceeding to that row and it does not 
#    have the access to the post rows of the current row
#"range between unbounded preciding and current row"

#the frame function effects the result while calculating last_value, nth function, agregate functions



select * , 
FIRST_VALUE(product_name) over(PARTITION BY product_category order by price desc) as highest_price_in_ctgry,
LAST_VALUE(product_name) over(PARTITION BY product_category order by price desc) as lowest_price_in_ctgry 
from product;

#so we can change the above query to below frame clause "range between unbounded preceding and unbounded following"

select * , 
FIRST_VALUE(product_name) over(PARTITION BY product_category order by price desc) as highest_price_in_ctgry,
LAST_VALUE(product_name) over(PARTITION BY product_category order by price desc
								range between unbounded preceding and unbounded following
							) as lowest_price_in_ctgry 
from product;

select * , 
FIRST_VALUE(product_name) over w as highest_price_in_ctgry,
LAST_VALUE(product_name) over w as  lowest_price_in_ctgry 
#NTH_VALUE(product_name,2) over w as scnd_mostexpensive
from product 
window w as (
PARTITION BY product_category order by price desc 
range between unbounded preceding and unbounded following
);



select *,
CUME_DIST() over(ORDER BY price desc) as cume_distribution,
round(CUME_DIST() over(ORDER BY price desc)*100,2) as cume_distribution_prcntg
from product;


select product_name ,(cume_distribution_prcntg||'%') as cume_distribution_prcntg from
(
select *,
CUME_DIST() over(ORDER BY price desc) as cume_distribution,
round(CUME_DIST() over(ORDER BY price desc)*100,2) as cume_distribution_prcntg
from product) x
where  x.cume_distribution_prcntg<=30;