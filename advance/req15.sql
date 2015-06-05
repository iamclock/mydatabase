# схема строения базы данных
# (idService) ordered_service (idOrder) -> (id) _order (idClient) -> (id) client
#  |
# \ /
#  V
# (id) service (idDepart) -> (name) department (idOffice) -> (address) office (idBranch) -> (id) branch_office (idCompany) -> (name) company
#															 /\
#															/  \
#															 ||
#														(idDepart) employee








select service.name, service.cost
	from service join
		(select subservice.id,
		# проверяется первое условие
		if(exists
				(select company.name
					from #в целом таблица показывает общее количество клиентов компании, и количество клиентов воспользовавшихся одной конкретной услугой
					#все клиенты компании
						(select company.name as comp_name, count(distinct client.id) as entire_numb_of_clients
							from company join branch_office on company.name = branch_office.idCompany
								join office on branch_office.id = office.idBranch
								join department on office.address = department.idOffice
								join service on department.name = service.idDepart
								join ordered_service on service.id = ordered_service.idService
								join _order on ordered_service.idOrder = _order.id
								join client on _order.idClient = client.id
							group by company.name
						) as numb_clients_comp_tbl
						join company on numb_clients_comp_tbl.comp_name = company.name
						join branch_office on company.name = branch_office.idCompany
						join office on branch_office.id = office.idBranch
						join department on office.address = department.idOffice
						join service on department.name = service.idDepart
						join #количество клиентов воспользовавшихся услугой
						(select service.id as serv_id, count(distinct client.id) as numb_of_clients
							from service join ordered_service on service.id = ordered_service.idService
								join _order on ordered_service.idOrder = _order.id
								join client on _order.idClient = client.id
							group by service.id
						) as numb_clients_serv_tbl on service.id = numb_clients_serv_tbl.serv_id
					where serv_id = subservice.id and (entire_numb_of_clients/2)-1 < numb_of_clients
				), 1, 0
			)
		#проверка второго условия
		+ if(exists
					(select service.id
						from service join ordered_service on service.id = ordered_service.idService
							join #количество жалоб на каждый заказ
							(select _order.id as ord_id, count(*) as claims
								from service join ordered_service on service.id = ordered_service.idService
									join _order on ordered_service.idOrder = _order.id
									join claim on _order.id = claim.idOrder
								group by _order.id
							) as ord_claims_tbl on ordered_service.idOrder = ord_claims_tbl.ord_id
						where claims = 0 and subservice.id = service.id
					), 1, 0
				)
		#проверка третьего условия
		+ if(exists
					(select serv_name
						from #считается количество филиалов
							(select count(*) as numb_of_branch_offices
								from branch_office
							) as count_branch_offs_tbl
							join
							#считается количество филиалов с нужной услугой
							(select distinct service.name as serv_name, count(*) as count_of_servs_in_comp
								from branch_office join office on branch_office.id = office.idBranch
									join department on office.address = department.idOffice
									join service on department.name = service.idDepart
								group by service.name
							) as same_servs_tbl
						where subservice.name = serv_name and numb_of_branch_offices = count_of_servs_in_comp
					), 1, 0
				)
		#проверка четвёртого условия
		+ if(exists
					(select service.id
						from service join
							(select department.name as depart_name, sum(salary) as entire_department_salary
								from department join employee on department.name = employee.idDepart
								group by department.name
							) as depart_salaries_tbl1 on service.idDepart = depart_name
							join
							(select max(entire_department_salary) as max_dep_sal
								from
									(select department.name as depart_name, sum(salary) as entire_department_salary
										from department join employee on department.name = employee.idDepart
										group by department.name
									) as depart_salaries_tbl1
							) max_salary_in_dep
							where service.id = subservice.id and max_dep_sal != entire_department_salary
					), 1, 0
				)
		#проверка пятого условия
		+ if(exists
					(select serv_name
						from #ищится число всех заказанных услуг
							(select count(*) as all_orders
								from ordered_service join service on ordered_service.idService = service.id
									join _order on ordered_service.idOrder = _order.id
								group by _order.id
							) as numb_of_ords_tbl
							join #ищится число заказов конкретной услуги
							(select service.name as serv_name, count(*) as available
								from ordered_service join service on ordered_service.idService = service.id
									join _order on ordered_service.idOrder = _order.id
							) as numb_of_ordered_service_tbl
						where available*100/all_orders >= 15 and numb_of_ordered_service_tbl.serv_name = subservice.id
					), 1, 0
				) as conds
		from service as subservice
		) as subservice_new
		on service.id = subservice_new.id
	where conds > 3



