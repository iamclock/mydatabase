/*
15. Найти услуги, для которых выполнится по крайней мере 4 условия из следующего списка
1) Ими пользовались хотя бы половина клиентов
2) Нет жалоб на заказы, в которые входила эта услуга
3) Эта услуга есть во всех филиалах
4) Эту услугу не оказывают отделы, в которых самые большие зарплаты
5) Если выбрать все заказы и за единицу принять отдельные услуги в заказах, то эта услуга должна составлять не менее 15% от общего количества единиц.
Вывод: Название услуги, Цена услуги
*/


# схема строения базы данных
# (idService) ordered_service (idOrder) -> (id) _order (idClient) -> (id) client
#  |
# \ /
#  V
# (id) service (idDepart) -> (name) department (idOffice) -> (address) office (idBranch) -> (id) branch_office (idCompany) -> (name) company




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
		+ if(
					#считается количество филиалов
					(select count(*) as numb_of_branch_offices
						from branch_office
					)
					=
					#считается количество филиалов с нужной услугой
					/*
					(select sum(numb_of_broffs_w_serv_tbl.service_exists)
						from #таблица в которой, 1 - услуга есть в филиале
								#									 0 - услуги в филиале нет
							(select service.name as serv_name, if(service.name = subservice.name, 1, 0)
								from branch_office join office on branch_office.id = office.idBranch
									join department on office.address = department.idOffice
									join service on department.name = service.idDepart
							) as numb_of_broffs_w_serv_tbl
					), 1, 0*/
					)
				 
		#проверка четвёртого условия
		#+ if(exists(), 1, 0)
		#проверка пятого условия
		#+ if(exists(), 1, 0)
		as conds
		from service as subservice
		) as subservice
		on service.id = subservice.id
	where conds > 3








/*
if(exists
		(select service.id

		), 1, 0
	)


#считается количество филиалов
(select count(*) as numb_of_branch_offices
	from branch_office
)
=
#считается количество филиалов с нужной услугой
(select sum(numb_of_broffs_w_serv_tbl.service_exists)
	from #таблица в которой, 1 - услуга есть в филиале
			 #									 0 - услуги в филиале нет
		(select service.name as serv_name, if(service.name = subservice.name, 1, 0)
			from branch_office join office on branch_office.id = office.idBranch
				join department on office.address = department.idOffice
				join service on department.name = service.idDepart
		) as numb_of_broffs_w_serv_tbl
) as numb_of_broffs
*/



























