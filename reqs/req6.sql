select ordered_service.idOrder
from ordered_service join claim on
	ordered_service.idOrder = claim.idOrd_ordered_serv
order by count(claim.id) desc limit 1