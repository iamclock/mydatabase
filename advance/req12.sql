




#Done

select newt.id as Order_id, _order.submission_date
		 #таблица идентификаторов заказа и число их услуг
	from (select _order.id, count(*) as number_of_services
			from _order join ordered_service
				on _order.id = ordered_service.idOrder
			group by _order.id
		 ) as newt join _order on _order.id = newt.id
	where							#общее число оказываемыч услуг
		newt.number_of_services = (select count(*) as entire_number_of_services
									from service
								  )
		and #вектор идентификаторов заказов без жалоб
		newt.id = any(select _order.id as id_Order
						from _order left outer join
							#таблица заказов с жалобами
							(select distinct _order.id as id_Order
								from _order join claim on claim.idOrder = _order.id
							) as newt1 on _order.id = newt1.id_Order
							where newt1.id_Order is null
					)
	order by Order_id