select department.name as department, e1.name, e1.post, e1.bday
from department, employee as e1 join employee as e2
on month(e1.bday) = month(e2.bday)
where e2.id is null and department.name = e1.idDepart
order by department.name

