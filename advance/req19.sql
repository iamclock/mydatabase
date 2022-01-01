

select company.name, broff_sumavg_tbl1.summary as maximum
	from company join branch_office on company.name = branch_office.idCompany
		join 
			(select branch_office.id as br_off_id, sum(offaddr_avgemp_tbl1.average) as summary
				from branch_office join office on branch_office.id = office.idBranch
				join #таблица адресов оффисов и среднее число их сотрудников
					(select office.address as office_address, avg(sumemp) as average
						from office join department on office.address = department.idOffice
							join #название отдела и количество сотрудников в нём
							(select department.name as depname, count(*) as sumemp
								from department join employee on department.name = employee.idDepart
								group by department.name
							) as depname_sumemp_tbl2 on department.name =  depname_sumemp_tbl2.depname
						group by office.address
					) as offaddr_avgemp_tbl1 on offaddr_avgemp_tbl1.office_address = office.address
				group by branch_office.id
			) as broff_sumavg_tbl1 on broff_sumavg_tbl1.br_off_id = branch_office.id
	where broff_sumavg_tbl1.summary =
		(select max(summary) as maxum
			from #таблица с суммарными значениями усреднённых величин
				(select branch_office.id, sum(offaddr_avgemp_tbl2.average) as summary
					from branch_office join office on branch_office.id = office.idBranch
					join #таблица адресов оффисов и среднее число их сотрудников
						(select office.address as office_address, avg(sumemp) as average
							from office join department on office.address = department.idOffice
								join #название отдела и количество сотрудников в нём
								(select department.name as depname, count(*) as sumemp
									from department join employee on department.name = employee.idDepart
									group by department.name
								) as depname_sumemp_tbl2 on department.name =  depname_sumemp_tbl2.depname
							group by office.address
						) as offaddr_avgemp_tbl2 on offaddr_avgemp_tbl2.office_address = office.address
					group by branch_office.id
				) as broff_sumavg_tbl2
			group by broff_sumavg_tbl2.id
		)
	order by company.name
	
	
	
	
	
	
	
	
	
	
	
			
			
			
			
			
			
			
			
			
	