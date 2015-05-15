select employee.*
	from employee
	where	employee.name not like 'Т%' and
		date_add(employee.bday, interval 25 year) < curdate() and
		employee.vacancy = true and
		employee.salary < 15000
	order by employee.name;