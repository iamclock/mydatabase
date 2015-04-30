/*
create temporary table tmp(
			department.name varchar(255) not null,
			rand() double not null
			);
select department.name, employee.name, employee.bday, employee.post, employee.salary from tmp limit 2
*/
select department.name, employee.name, employee.bday, employee.post, employee.salary
from department order by rand() limit 2 where department.name = employee.idDepart