select ordered_service.id, sum(service.cost) as summ
from ordered_service ignore max(summ) and ignore min(summ)