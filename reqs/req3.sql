select office.address, count(employee.id) as number
	from employee join department
		on employee.idDepart = department.name, office
	where office.address = department.idOffice
	group by office.address;