

#Done

# схема строения базы данных
# (idService) ordered_service (idOrder) -> (id) _order (idClient) -> (id) client
#  |
# \ /
#  V
# (id) service (idDepart) -> (name) department (idOffice) -> (address) office (idBranch) -> (id) branch_office (idCompany) -> (name) company





select _order.id, _order.submission_date,
if(count(*)*100/entire_numb_of_orders > 74,"Последние заказы",if(count(*)*100/entire_numb_of_orders > 24,"Основные заказы","Первые заказы")) as commentary
	from company join branch_office on company.name = branch_office.idCompany
		join office on branch_office.id = office.idBranch
		join department on office.address = department.idOffice
		join service on department.name = service.idDepart
		join ordered_service on service.id = ordered_service.idService
		join _order on ordered_service.idOrder = _order.id
		join #заказы компании и их дата
			(select company.name as comp_name, _order.submission_date as date
				from company join branch_office on company.name = branch_office.idCompany
					join office on branch_office.id = office.idBranch
					join department on office.address = department.idOffice
					join service on department.name = service.idDepart
					join ordered_service on service.id = ordered_service.idService
					join _order on ordered_service.idOrder = _order.id
			) as submitted_dates_tbl on company.name = submitted_dates_tbl.comp_name
			and _order.submission_date > submitted_dates_tbl.date
		join #общее количество заказов у компании
			(select company.name as comp_name, count(distinct _order.id) as entire_numb_of_orders
				from company join branch_office on company.name = branch_office.idCompany
					join office on branch_office.id = office.idBranch
					join department on office.address = department.idOffice
					join service on department.name = service.idDepart
					join ordered_service on service.id = ordered_service.idService
					join _order on ordered_service.idOrder = _order.id
				group by company.name
			) as numb_of_company_orders_tbl on company.name = numb_of_company_orders_tbl.comp_name
	order by _order.id




