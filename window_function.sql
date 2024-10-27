create schema employeedb;
use employeedb;
drop table if exists employee ;
create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);
COMMIT;



select * from employee limit 5;

select  dept_name, max(salary)  as max_salary from employee GROUP BY dept_name;

## window function , every window function is created with over() clause
select e.* , max(salary) over() as max_salary from employee e;

select e.* ,max(salary) over(PARTITION BY DEPT_NAME) as max_salary from employee e;

select e.*, ROW_NUMBER() over() as ro_num from employee e;

select e.* , row_number() over(PARTITION BY DEPT_NAME) as rn from employee e;

select e.* , row_number() over(PARTITION BY DEPT_NAME order by emp_ID) as rn  from employee e;

## fetch the oldest 2 employees from each dept

select * from (select e.* , row_number() over(PARTITION BY DEPT_NAME order by emp_ID) as rn  from employee e) 
x where x.rn<3;

select * from 
	(
    select e.* , 
    ROW_NUMBER() over(PARTITION BY DEPT_NAME order by emp_ID) as rn 
    from employee e 
    ) x
where x.rn<3;

## fetch the top3 employees from each dept earning the max salary


## below is the wrong way of doing this bcoz it will skip some records with same salary if the row number goes beyond 4
select  * from (
select e.*, ROW_NUMBER() over(partition by DEPT_NAME order by SALARY desc ) as rn 
from employee e) x 
where x.rn < 4;


## using rank() gives the correct output , it gives the same rank for same slaries
select  * from (
select e.*, rank() over(partition by DEPT_NAME order by SALARY desc ) as rnk 
from employee e) x 
where x.rnk < 4;

## diffrence between rank and dense_rank and row number  , rank will skip the value for the duplicate for dense rank will not

select e.*, 
rank() over(partition by DEPT_NAME order by SALARY desc ) as rnk ,
DENSE_RANK() over(PARTITION BY DEPT_NAME order by salary desc) as dense_rnk,
ROW_NUMBER() over(PARTITION BY DEPT_NAME order by salary desc) as row_no
from employee e  ;

## lag() means previous to the current row and lead() means next to the current row

# fetch a query to display if the salary of an employee is higher , lower or same as the previous employee

select e.* , 
lag(SALARY) over(PARTITION BY DEPT_NAME order by emp_ID) as prev_employee_sal
from employee e;

select e.* , 
lead(SALARY) over(PARTITION BY DEPT_NAME order by emp_ID) as next_employee_sal
from employee e;

select e.* , 
lag(SALARY) over(PARTITION BY DEPT_NAME order by emp_ID) as prev_employee_sal,
case when e.salary > lag(SALARY) over(PARTITION BY DEPT_NAME order by emp_ID) then "higher then previous employee"
	 when e.salary < lag(SALARY) over(PARTITION BY DEPT_NAME order by emp_ID) then "lower then previous employee"
     when e.salary = lag(SALARY) over(PARTITION BY DEPT_NAME order by emp_ID) then "same as previous employee"
     end sal_range
from employee e;

SELECT emp_NAME, salary
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE salary < (SELECT MAX(salary) FROM employee)
);

select e.* , max(SALARY) over(partition by DEPT_NAME)as max_sal from employee e;

select e.* ,max(salary) over(PARTITION BY DEPT_NAME order by emp_ID) as max_salary from employee e;

select e.*, 
rank() over(partition by DEPT_NAME order by SALARY desc ) as rnk ,
DENSE_RANK() over(PARTITION BY DEPT_NAME order by salary desc) as dense_rnk,
ROW_NUMBER() over(PARTITION BY DEPT_NAME order by salary desc) as row_no
from employee e  ;