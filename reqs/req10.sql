
#o_s_t - office_services_table
#d_s_t - department_services_table



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
	where o_s_t.depart_name = d_s_t.depart_name
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


/*
select 
	from
		(select )
*/