select summary.idOrder, summary.summ as entire
	from
		(select sum(t3.cost) as summ, t2.idOrder
			from _order as t1 join ordered_service as t2 join service as t3
				on t1.id = t2.idOrder and t2.idService = t3.id
			group by t2.idOrder
		) as summary
	where	summary.summ < #any (select max(summary.summ)
			#from summary
			) and
		summary.summ > #any (select min(summary.summ) или продублировать таблицу сверху
			) and
		#summary.idOrder = ordered_service.idOrder
	order by summary.idOrder

