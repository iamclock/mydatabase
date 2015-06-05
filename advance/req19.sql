

select company.name, broff_sumavg_maxsumavg_tbl.maxum
	from company join branch_office on company.name = branch_office.idCompany
		join #таблица с идентификаторами филиалов с максимальными значениями
		(select broff_sumavg_tbl.id as br_off_id, summary, max(summary) as maxum
			from #таблица с суммарными значениями усреднённых величин
				(select branch_office.id, sum(offaddr_avgemp_tbl.average) as summary
					from branch_office join office on branch_office.id = office.idBranch
					join #таблица адресов оффисов и среднее число их сотрудников
						(select office.address as office_address, avg(sumemp) as average
							from office join department on office.address = department.idOffice
								join #название отдела и количество сотрудников в нём
								(select department.name as depname, count(*) as sumemp
									from department join employee on department.name = employee.idDepart
									group by department.name
								) as depname_sumemp_tbl on department.name =  depname_sumemp_tbl.depname
							group by office.address
						) as offaddr_avgemp_tbl on offaddr_avgemp_tbl.office_address = office.address
					group by branch_office.id
				) as broff_sumavg_tbl
		) as broff_sumavg_maxsumavg_tbl on broff_sumavg_maxsumavg_tbl.br_off_id = branch_office.id
	where broff_sumavg_maxsumavg_tbl.summary = broff_sumavg_maxsumavg_tbl.maxum
	order by company.name