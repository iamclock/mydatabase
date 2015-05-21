

select idOrder, entire_cost
	from
		(select ordered_service.idOrder, sum(service.cost) as entire_cost
			from ordered_service join service
				on ordered_service.idService = service.id
			group by ordered_service.idOrder
		) as table1,
		(select max(cost)as maxum, min(cost) as minum from
			(select ordered_service.idOrder, sum(service.cost) as cost
				from ordered_service join service
					on ordered_service.idService = service.id
				group by ordered_service.idOrder
			) as temp1
		) as table2
		where table1.entire_cost != maxum and table1.entire_cost != minum
			order by idOrder