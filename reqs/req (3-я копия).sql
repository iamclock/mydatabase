



select	Office.address, count(employee.id)
from department where department.name = employee.idDepart and Office.address = department.idOffice
group by Office.address;