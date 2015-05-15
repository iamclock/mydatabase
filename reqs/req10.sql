/*
select	of.address, dep.name as department,
		count(ser.id) as number
from office as of join department as dep join service as ser
on of.address = dep.idOffice and dep.name = ser.idDepart
order by of.address
*/
#найти максимальный count



/*
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
*/


#


/*
	(select office.address as address, t1.depart_name, t1.number_of_services
		from office join
			(select department.name as depart_name,
						count(service.id) as number_of_services, service.id
					from department join service on department.id = service.idDepart
					group by department.name
					) as t1 on office.address = t1.depart_name
					order by count(service.id)
*/




#o_s_t - office_services_table
#d_s_t - department_services_table
#


/*
select o_s_t.address,
		o_s_t.depart_name,
		d_s_t.number_of_department_services,
		o_s_t.number_of_office_services #sum(o_s_t.)
	from
		(select office.address as address,
				department.name as depart_name,
				count(*) as number_of_office_services
			from office join department join service
				on office.address = department.idOffice
				and department.name = service.idDepart
			group by office.address
		) as o_s_t,
		(select department.name as depart_name,
				count(*) as number_of_department_services
			from department join service
				on department.name = service.idDepart
			group by department.name
		) as d_s_t
	where o_s_t.address = d_s_t.depart_name
		and o_s_t.number_of_office_services =
			(select max(o_s_t.number_of_office_services)
				from 
					(select office.address as address,
						department.name as depart_name,
						count(*) as number_of_office_services
					from office join department join service
						on office.address = department.idOffice
						and department.name = service.idDepart
					group by office.address
					) as t1
			)
	order by o_s_t.address
*/


select s_t.address,
		s_t.depart_name,
		s_t.number_of_department_services,
		sum(s_t.)
	from (select office.address as address,
				department.name as depart_name,
				count(*) as number_of_depart_services
			from office join department join service
				on office.address = department.idOffice
				and department.name = service.idDepart
			group by department.name
		) as s_t
	where 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	