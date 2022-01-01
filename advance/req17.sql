
#Done

select concat(
	'Сотрудник ', employee.name,
	' родился ', dayofmonth(employee.bday), ' ', month(employee.bday), ' ', year(employee.bday),
	'. Сотрудник работает в отделе ', department.name,
	' филиала г. ', branch_office.city_name, 'а',
	' компании ', company.name,
	', заработная плата сотрудника: ', employee.salary,
	'. В настоящий момент сотрудник ', if(employee.vacancy, 'находится в отпуске', 'не находится в отпуске'),
	'. Отдел, в котором работает сотрудник оказывает ', newt1.numb_of_dep_servs,
	' услуг, количество других работников в отделе равно ', newt2.numb_of_dep_empls, '.'
	)
	from
		company join branch_office on company.name = branch_office.idCompany
		join office on office.idBranch = branch_office.id
		join department on department.idOffice = office.address
		join employee on employee.idDepart = department.name
		join #подсчёт количества услуг в отделе
		(select department.name, count(*) as numb_of_dep_servs
			from department join service
				on department.name = service.idDepart
			group by department.name
		) as newt1 on department.name = newt1.name
		join #подсчёт количества сотрудников в отделе
		(select department.name, count(*) as numb_of_dep_empls
			from department join employee
				on department.name = employee.idDepart
			group by department.name
		) as newt2 on department.name = newt2.name
	