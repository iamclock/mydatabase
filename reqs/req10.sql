select	obj1.address, obj2.name as department,
		count(obj3.id) as number
from office as obj1 join department obj2 join service as obj3
on obj1.address = obj2.idOffice and obj2.name = obj3.idDepart
order by obj1.address

#найти максимальный count