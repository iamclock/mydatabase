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








(select service.name, service.cost
	from 
		
		
	
	
)




	from company join branch_office on company.name = branch_office.idCompany
		join office on branch_office.id = office.idBranch
		join department on office.address = department.idOffice
		join service on department.name = service.idDepart
		join ordered_service on service.id = ordered_service.idService
		join _order on ordered_service.idOrder = _order.id
		join claim on _order.id = claim.idOrder








if(select 
	from
		#количество клиентов воспользовавшихся услугой
		(select service.id, count(*) as numb_of_clients
			from company join branch_office on company.name = branch_office.idCompany
				join office on branch_office.id = office.idBranch
				join department on office.address = department.idOffice
				join service on department.name = service.idDepart
				join ordered_service on service.id = ordered_service.idService
				join _order on ordered_service.idOrder = _order.id
				join client on _order.idClient = client.id
				group by service
		) as numb_clients_serv_tbl
		join
		#общее количество клиентов у компании
		(select company.name as comp_name, count(distinct client.id) as entire_numb_of_clients
			from company join branch_office on company.name = branch_office.idCompany
				join office on branch_office.id = office.idBranch
				join department on office.address = department.idOffice
				join service on department.name = service.idDepart
				join ordered_service on service.id = ordered_service.idService
				join _order on ordered_service.idOrder = _order.id
				join client on _order.idClient = client.id
		) as numb_clients_comp_tbl on numb_clients_serv_tbl.id = numb_clients_comp_tbl.


