select employee.name, employee.post, employee.bday, employee.idDepart
	from employee join 
		(select month(bday) as month, count(*) as number
			from employee
			group by month(bday)
		) as emp_temp on month(employee.bday) = emp_temp.month
	where emp_temp.number = 1
	order by employee.idDepart