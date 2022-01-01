select	company.name, branch_office.city_name,
		department.name, service.name, service.cost,
		service.requirements
	from company, branch_office, office, department, service
	where	branch_office.idCompany = company.name and
		office.idBranch = branch_office.id and
		department.idOffice = office.address and
		service.idDepart = department.name
	order by company.name;