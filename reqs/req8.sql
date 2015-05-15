/*
select summary.idOrder, summary.summ as entire
	from
		(select sum(t3.cost) as summ, t2.idOrder
			from _order as t1 join ordered_service as t2 join service as t3
				on t1.id = t2.idOrder and t2.idService = t3.id
			group by t2.idOrder
		) as summary
	where summary.summ < any(select summary.summ from summary) and
		summary.summ > any(select summary.summ from summary) #или продублировать таблицу сверху
	order by summary.idOrder
*/



select idOrder, entire_cost
	from
		(select ordered_service.idOrder, sum(service.cost) as entire_cost
			from ordered_service join service
				on ordered_service.idService = service.id
			group by ordered_service.idOrder
		) as table1
	where table1.entire_cost <
		(select max(cost) from
			(select ordered_service.idOrder, sum(service.cost) as cost
				from ordered_service join service
					on ordered_service.idService = service.id
				group by ordered_service.idOrder
			) as temp1
		)
		and table1.entire_cost >
		(select min(cost) from
			(select ordered_service.idOrder, sum(service.cost) as cost
				from ordered_service join service
					on ordered_service.idService = service.id
				group by ordered_service.idOrder
			) as temp2
		)
	order by idOrder