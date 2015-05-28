/*
16. Вывести компании у которых обслуживались все клиенты,
которые есть в базе. При этом эти компании должны
оказывать ВСЕ услуги, которые есть в базе.
Вывод: Название компаний.
*/














(select count(*) as numb_clients
	from client
)

(select count(*) as numb_services
	from service
)

select count(*) as clients
	from
		(select _order.id as order_id, distinct client.id as client_id
			from _order join client on _order.idClient = client.id
		)





select company.name
	from company join branch_office on company.name = branch_office.idCompany
		join office on branch_office.id = office.idBranch
		join department on office.address = department.idOffice
		join service on department.name = service.idDepart
		
		
		
select 
	from _order join ordered_service on _order. = ordered_service.
		join service on ordered_service. = service
	