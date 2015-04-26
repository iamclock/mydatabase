



select	idDepart, idOffice
		count(employee.idDepart)
from employee, department
group by department.idOffice;