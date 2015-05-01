select ordered_service.id
from orderdered_service where count(service.id) = 1
order by ordered_service.id