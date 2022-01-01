select _order.id
	from ordered_service join _order on ordered_service.idOrder = _order.id
	group by _order.id
	having count(ordered_service.idOrder) = 1
	order by _order.id