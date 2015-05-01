select office.address, department.name, max(count(service.id))
from office where department.idOffice = office.address and
department.name = service.idDepart