select office.address, count(employee.id) as count
from employee join department
on employee.idDepart = department.name, office
where office.address = department.idOffice
order by office.address desc;