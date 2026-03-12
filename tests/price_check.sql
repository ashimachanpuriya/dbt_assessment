-- price should not be less than 0
select 
    *
from {{ ref('fact_listing_calendar') }}
where price < 0