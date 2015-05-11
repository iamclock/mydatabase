select
	department.name, employee.name, employee.bday,
	employee.post, employee.salary
from department join employee on department.name = employee.idDepart
order by rand() limit 2