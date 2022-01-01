
#Done

select client.name, bday as birthday
	from client join _order on client.id = _order.idClient
		join /*создаётся таблица соответствия идентификатора
				заказа и количества жалоб на него*/
			(select _order.id as order_id, count(*) as numb_of_claims
				from _order join claim on _order.id = claim.idOrder
				group by _order.id
			) as claims_numb_tbl1 on _order.id = claims_numb_tbl1.order_id
	where numb_of_claims = 
		(select max(claims_numb)
			from /*создаётся таблица соответствия идентификатора заказа и количества жалоб на него и затем ищется наибольшее значение*/
				(select _order.id as order_id, count(*) as claims_numb
					from _order join claim on _order.id = claim.idOrder
					group by _order.id
				) as claims_numb_tbl2
		)
	order by name

