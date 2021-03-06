# ScienceQtech Employee Performance Mapping.

# 1)Create a database named employee, then import data_science_team.csv proj_table.csv and 
 #emp_record_table.csv into the employee database from the given resources.
create database employee;
use employee;
select * from employees;
create database project;
use project;
select * from project_tab;
select * from data_science_team;


#2)Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.
use employee;
SELECT * FROM employees;
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM employees;
---------------------------------------------------------------------------------------------------------------------------
#3)Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
### less than two,greater than four ,between two and four

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM employees
WHERE EMP_RATING <2;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM employees
WHERE EMP_RATING >4;
select  EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM employees
WHERE EMP_RATING >=2 AND EMP_RATING <=4;
--------------------------------------------------------------------------------------------------

#4)Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
select concat(FIRST_NAME,LAST_NAME) AS NAME, DEPT
FROM employees
WHERE DEPT = 'FINANCE';
----------------------------------------------------------------------------------------------------------------------

#5)Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).

select e.EMP_ID,e.FIRST_NAME,e.LAST_NAME, count(e.emp_id) as number_of_reporters
from employees e
join employees m
on e.emp_id= m.manager_id
group by e.emp_id
order by e.emp_id;
----------------------------------------------------------------------------------------------------------
#6)Write a query to list down all the employees from the healthcare and finance departments using union. 

select e.emp_id,e.first_name,e.last_name,e.dept
from employees e
where e.dept='healthcare'
union
select es.emp_id,es.first_name,es.last_name,es.dept
from employees es
where es.dept='finance';
-------------------------------------------------------------------------------------------------------
select * from employees;
#7)Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. 
# Also include the respective employee rating along with the max emp rating for the department.

select  EMP_ID, FIRST_NAME, LAST_NAME,ROLE, DEpt,EMP_RATING,max(emp_rating) as max_rating
from employees
group by dept;
-------------------------------------------------------------------------------------------------------------------
#8)Write a query to calculate the minimum and the maximum salary of the employees in each role. 

select role,min(salary) as min_salary,max(salary) as max_salary
from employees
group by role;
--------------------------------------------------------------------------------------------------------

#9)Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.

select emp_id,first_name,last_name,dept,emp_rating,rank() over(order by emp_rating) as Emp_rank,
dense_rank() over(order by emp_rating) as emp_dense_rank
from employees;
----------------------------------------------------------------------------------------------------------

#10)Write a query to create a view that displays employees in various countries whose salary is more than six thousand. 

create view emp_country as
select emp_id,first_name,last_name,country,salary
from employees
where salary>6000
order by salary;

select * from emp_country;
------------------------------------------------------------------------------------------------------------------

#11)Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.

select e.emp_id,e.first_name,e.last_name,e.exp
from employees e
where e.emp_id in (
select es.emp_id 
from employees es
where es.exp>10)
order by e.exp;
-------------------------------------------------------------------------------------------------------------------
#12)Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. 

delimiter //
create procedure mid_experience()
begin
select * from employees
where exp>3
order by exp;
end //
delimiter ;

call mid_experience();

------------------------------------------------------------------------------------------------------------------------------------
#14)Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).

select emp_id,concat(first_name,last_name) as NAME , salary, emp_rating,
(select emp_rating * (select salary * .05)) as bonus
from employees
group by emp_id
order by bonus desc;
---------------------------------------------------------------------------------------------------------------------------------------
#15)Write a query to calculate the average salary distribution based on the continent and country.

use employee;
select country, continent, round(avg(salary),2) as Average_Salary
from employees
group by country,continent
order by Average_Salary desc;

		
    
    
