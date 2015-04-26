



select	department.idOffice, employee.idDepart
		count(employee.idDepart)
from employee
group by department.idOffice;