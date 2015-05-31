
# Done

# схема строения базы данных
# (idService) ordered_service (idOrder) -> (id) _order (idClient) -> (id) client
#  |
# \ /
#  V
# (id) service (idDepart) -> (name) department (idOffice) -> (address) office (idBranch) -> (id) branch_office (idCompany) -> (name) company



select company.name
	from company
		join #подзапрос будет возвращать название компании и число не повторяющихся клиентов в базе данных
		(select company.name as comp_name, count(distinct client.id) as number_of_clients
			from company join branch_office on company.name = branch_office.idCompany
				join office on branch_office.id = office.idBranch
				join department on office.address = department.idOffice
				join service on department.name = service.idDepart
				join ordered_service on service.id = ordered_service.idService
				join _order on ordered_service.idOrder = _order.id
				join client on _order.idClient = client.id
		) as comp_clients on company.name = comp_clients.comp_name
		join #подзапрос будет возвращать название компании и число оказываемых не повторяющихся услуг
		(select company.name as comp_name, count(distinct service.id) as number_of_services
			from company join branch_office on company.name = branch_office.idCompany
				join office on branch_office.id = office.idBranch
				join department on office.address = department.idOffice
				join service on department.name = service.idDepart
		) as comp_services on company.name = comp_services.comp_name
	where comp_clients.number_of_clients =
		#общее количество клиентов в базе данных
		(select count(distinct client.id) as entire_numb_of_clients
			from client
		)
	and comp_services.number_of_services =
		#общее количество услуг в базе данных
		(select count(distinct service.id) entire_numb_of_services
			from service
		)

