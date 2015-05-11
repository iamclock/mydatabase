select ordered_service.id, sum(service.cost) as summ
from ordered_service, service
where 
summ < maxum and summ > minum