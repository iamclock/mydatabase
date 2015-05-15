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
	from office join
		(select department.name as depart_name,
				count(service.id) as number_of_services, service.id
			from department join service on department.id = service.idDepart
			group by department.name
			) as t1 on office.address = t1.depart_name
	where department.name = t1.name and
		t1.count = #all (select max(t1.count)
			) and
		department.idOffice = office.address
	order by office.address



#


select office.address as address, department.name as depart_name, count() as number_of_services
	from
		(select 
			from 









	(select office.address as address, t1.depart_name, t1.number_of_services
		from office join
			(select department.name as depart_name,
						count(service.id) as number_of_services, service.id
					from department join service on department.id = service.idDepart
					group by department.name
					) as t1 on office.address = t1.depart_name
					order by count(service.id)