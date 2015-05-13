select ordered_service.idOrder, summary.summ as entire
from ordered_service, (select sum(t3.cost) as summ, t2.idOrder
			from _order as t1 join ordered_service as t2 join service as t3
			on t1.id = t2.idOrder and t2.idService = t3.id
			) as summary
where	summary.summ < (select max(summary.summ)
			#from summary
			) and
		summary.summ > (select min(summary.summ)
			#from summary
			) and
		summary.idOrder = ordered_service.idOrder
order by ordered_service.idOrder


# Invalid use of group function в строках 6 и 7