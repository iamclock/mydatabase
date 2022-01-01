

#Done

select city_name, office_address, average
	from branch_office join office on office.idBranch = branch_office.id
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
	order by city_name