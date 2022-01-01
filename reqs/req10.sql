
#o_s_t - office_services_table
#d_s_t - department_services_table



select address,
		name,
		number_of_dep_services
	from office join department on office.address = department.idOffice join
		(select department.name as depart_name,
				count(*) as number_of_dep_services
			from department join service
				on
				department.name = service.idDepart
			group by department.name
		) as table1
		on department.name = table1.depart_name
	where table1.number_of_dep_services = 
		(select max(t1.number_of_dep_services)
			from 
				(select count(*) as number_of_dep_services
					from department join service
						on department.name = service.idDepart
					group by department.name
				) as t1
		)
	order by office.address


/*
select 
	from
		(select )
*/