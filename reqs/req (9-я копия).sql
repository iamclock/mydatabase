select employee.name, employee.post, employee.bday, department.name
from employee where employee.idDepart = department.name and
employee