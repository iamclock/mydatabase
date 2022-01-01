select office.address, count(employee.id)
from department, office, employee
group by employee.idDepart
#where department.name = employee.idDepart and
#			office.address = department.idOffice
order by office.address desc;