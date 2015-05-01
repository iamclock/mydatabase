select	Office.address, count(employee.id)
from department, office where department.name = employee.idDepart and Office.address = department.idOffice
group by Office.address;