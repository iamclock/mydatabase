

#Done


select serv1.name, serv2.name
	from service as serv1 inner join
		(select * from service) as serv2 on serv1.id < serv2.id
	where
	(select count(*)
		from service join department on service.idDepart = department.name
		where service.id = serv1.id
	)
	=
	(select count(*)
		from service join department on service.idDepart = department.name
		where service.id = serv2.id
	)
	and serv1.cost = serv2.cost