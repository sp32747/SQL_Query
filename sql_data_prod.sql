
###=================https://www.youtube.com/watch?v=Bp703NkC00Q=================######

select DISTINCT branch from allstudents;

select * from branch;
Select * from allstudents where branch='cse' and marksobtained>=800;

Select * from allstudents where marksobtained between 800 and 900;

#where branch is not cs , both the below queries work as the same 
Select * from allstudents where branch <>  'cse';

Select * from allstudents where NOT branch ='cse';

Select * from allstudents where branch in ('ece','cse');

Select * from allstudents where email is null;

Select * from allstudents where email is not null;

Select * from allstudents where firstname like '%ya';

Select * from allstudents where branch like '_E'and email is not null;

# ordering by marks in DESC order  then ordering by first name with default ascending order
Select * from allstudents   order by marksobtained desc  ;

#select top 5 records
select  * from allstudents order by marksobtained desc limit 5 ;

select  * from allstudents where branch='cse' order by marksobtained desc limit 3 ;

select branch ,sum(marksobtained) as total_marks from allstudents ;

# group by-having
select branch, avg(marksobtained) as avg_mark from allstudents GROUP BY branch;

select branch, avg(marksobtained) as avg_mark from allstudents GROUP BY branch having avg_mark>840;

#===========================JOINS========================



#inner join , if you have common column in both the tables then refer the tablename.columnname
select firstname,lastname, branchname,capacity 
from allstudents s
inner join branch b 
on s.branchid=b.branchid;

###################################  SUBQUERY   #############################################################

#show the student name who is having maximun mark in CSE

select studentid,firstname,lastname,marksobtained 
from allstudents where branch='cse' and
marksobtained=(select max(marksobtained) from allstudents where branch='cse')
;
# below query skips the same maximum marks if you give a higher unintended rows wil come
select studentid,firstname,lastname,marksobtained 
from allstudents where branch='cse' ORDER BY marksobtained desc limit 3;

# second maximum mark
select studentid,firstname,lastname,marksobtained 
from allstudents 
where branch='cse' and marksobtained = (
select max(marksobtained) 
from allstudents where branch='cse' and 
marksobtained <> (select max(marksobtained) 
from allstudents where branch='cse'))
;

## window function , every window function is created with over() clause , 3 type of window functions are there
##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++##
########### 1) Agregate indow function #########################
select firstname,lastname,branch,marksobtained , 
		avg(marksobtained) OVER() as 'avg.mark'
        from allstudents;


select branch,avg(marksobtained) as 'avg.mark'  from allstudents 
        GROUP BY branch;
        
#find avg partitoned by branch
select studentid,firstname,lastname,branch , avg(marksobtained) 
over(partition by branch ) as 'avg.marks' from allstudents;

#supose we need another window column then we have to use another over() clause

select studentid,firstname,lastname,branch , marksobtained,
avg(marksobtained) over(partition by branch ) as 'avg.marks',
max(marksobtained) over(partition by branch) as 'max.bybranch',
min(marksobtained) over(partition by branch) as 'min.bybranch',
count(*) over(PARTITION BY branch) as 'tot.students' from allstudents;
     
## ROWS BETWEEN , UNBOUNDED PRECEEDING, UNBOUNDED FOLLOWING , N PRECEEDING , N FOLLOWING , CURRENT ROW IN WINDOW FUNCTION
select studentID,firstname,lastname,branch , marksobtained,
sum(marksobtained) over(order by marksobtained rows between unbounded preceding and current row  ) 
as 'running.total.marks'
from allstudents;

select studentid,firstname,lastname,branch , marksobtained,
sum(marksobtained) over(partition by branch order by marksobtained rows between unbounded preceding and unbounded following ) 
as 'total.marks'from allstudents;

########### 2) Ranking window  function #########################
/*
these functions give each row a special rank within a group of rows RANK(), DENSE_RANK(),ROW_NUMBER(),NTILE()
these rank() window  functions are usefull while arranging data with certain rules
ROW_NUMBER() must be used witha ORDER BY clause
*/
select studentid,firstname,lastname,branch , marksobtained,
ROW_NUMBER() over( order by marksobtained desc) as "ronum"
from allstudents;


select studentid,firstname,lastname,branch , marksobtained,
ROW_NUMBER() over(partition by branch order by marksobtained desc) as "ronum"
from allstudents;
     
select studentid,firstname,lastname,branch , marksobtained,
ROW_NUMBER() over(partition by branch order by marksobtained desc) as "ronum",
rank() over(partition by branch ORDER BY marksobtained desc) as 'rnk',
DENSE_RANK() over(partition by branch ORDER BY marksobtained desc) as 'dns.rnk'
from allstudents;

## EMPLOYEE WITH Nth HIGHEST SALARY
## SELECT name, salary FROM employee ORDER BY salary DESC LIMIT (N-1), 1; 


select   branch , avg(marksobtained)
from  allstudents 
GROUP BY branch;

## 2 nd highest mark
## CTE commom table expression( some times called as "with Clause")



with cte_avgmarks as 
(
select   branch , avg(marksobtained) as avgmark
from  allstudents 
GROUP BY branch
)
select studentid,firstname,lastname,a.branch , marksobtained 
from allstudents a
inner join cte_avgmarks c
on a.branch=c.branch
and a.marksobtained > c.avgmark;

select studentid,firstname,lastname,branch , marksobtained,
ROW_NUMBER() over(partition by branch order by marksobtained desc) as "ronum",
rank() over(partition by branch ORDER BY marksobtained desc) as 'rnk',
DENSE_RANK() over(partition by branch ORDER BY marksobtained desc) as 'dns.rnk' 
from allstudents;


## 2 nd highest mark with CTE




with t as (
select studentid,firstname,lastname,branch , marksobtained,
DENSE_RANK() over( partition by branch ORDER BY marksobtained desc) as 'dnsrnk'
from allstudents) select firstname,branch,marksobtained  from t where dnsrnk=2;




################################################################################

/*
derive the product in sales which have years sales in increasing trend only 
show productid, product name ,year
*/
 
 
 
     
     

