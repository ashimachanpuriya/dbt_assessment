select 
    listing_id,
    date,
    available ='t' as is_available,
    reservation_id,
    price,
    minimum_nights,
    maximum_nights,
from {{ ref('CALENDAR') }}