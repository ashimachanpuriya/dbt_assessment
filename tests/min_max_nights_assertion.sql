-- minimum night should not be more than than maximum_nights
select 
    *
from {{ ref('fact_listing_calendar') }}
where minimum_nights > maximum_nights