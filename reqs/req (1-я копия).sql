select employee.*
from employee
where	employee.name not like 'Т%' and
		(year(date())-year(employee.bday)) as age > 25 and
		vacancy > 0 and
		-- month(employee.vacancy) as vac_month < 6 and
		-- vac_month > 8
		employee.salary < 15000
group by employee.name;