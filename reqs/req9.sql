select employee.name, employee.post, employee.bday, department.name
from employee where employee.idDepart = department.name and
distinct employee.bday
group by employee.name