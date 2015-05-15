select
	department.name, employee.name, employee.bday,
	employee.post, employee.salary
	from (select name
					from department
					order by rand() limit 2
				)
	department join employee on department.name = employee.idDepart
	order by department.name
