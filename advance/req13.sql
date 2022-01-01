
#Done

# схема строения базы данных
# (idService) ordered_service (idOrder) -> (id) _order (idClient) -> (id) client
#  |
# \ /
#  V
# (id) service (idDepart) -> (name) department (idOffice) -> (address) office (idBranch) -> (id) branch_office (idCompany) -> (name) company





select _order.id, _order.submission_date,
if(count(*)*100/entire_numb_of_orders > 74,"Последние заказы",if(count(*)*100/entire_numb_of_orders > 24,"Основные заказы","Первые заказы")) as commentary
	from _order
		join # создаётся таблица соответствия даты одного заказа к количеству дат других заказов заказанных раньше
			(select ord1.id as ord_id, count(*) as grater_sub_dates
				from _order as ord1
					join _order as ord2 on ord1.id != ord2.id and ord1.submission_date > ord2.submission_date
				group by ord1.id
			) as numbs_greater_sub_dates_tbl on _order.id = numbs_greater_sub_dates_tbl.ord_id
		join #общее количество заказов
			(select count(distinct _order.id) as entire_numb_of_orders
				from _order
			) as numb_of_orders_tbl
	order by _order.id




