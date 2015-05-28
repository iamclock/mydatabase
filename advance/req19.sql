







select company.name, newt4.maxum
	from company join branch_office on company.name = branch_office.idCompany
		join #таблица с идентификаторами филиалов с максимальными значениями
				(select newt3.id, max(summary) as maxum
					from #таблица с суммарными значениями усреднённых величин
						(select branch_office.id, sum(newt2.average) as summary
							from branch_office join office on branch_office.id = office.idBranch
							join #таблица адресов оффисов и среднее число их сотрудников
								(select office.address as office_address, avg(summary) as average
									from office join department on office.address = department.idOffice
										join #название отдела и количество сотрудников в нём
										(select department.name as depname, count(*) as summary
											from department join employee on department.name = employee.idDepart
											group by department.name
										) as newt on department.name = newt.depname
									group by office.address
								) as newt2 on newt2.office_address = office.address
							group by branch_office.id
						) as newt3
				) as newt4 on newt4.id = branch_office.id
	order by company.name