select ordered_service.id
from ordered_service where max(count(claim.id))