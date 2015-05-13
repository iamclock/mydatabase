/*
select	of.address, dep.name as department,
		count(ser.id) as number
from office as of join department as dep join service as ser
on of.address = dep.idOffice and dep.name = ser.idDepart
order by of.address
*/
#найти максимальный count




select	office.address, department.name as department,
		t1.count as number
from office, department,
		(select department.name as name,
				count(service.id) as count
			from department, service
			where department.name = service.idDepart
			) as t1
where department.name = t1.name and
		t1.count = (select max(t1.count)
			) and
		department.idOffice = office.address
order by office.address