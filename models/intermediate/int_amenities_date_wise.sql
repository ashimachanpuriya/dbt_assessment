select
    -- from calendar
    c.listing_id,
    c.date,
    c.is_available,
    c.reservation_id,
    c.price,
    c.minimum_nights,
    c.maximum_nights,
    -- from changelog
    a.change_at,
    a.amenities
from {{ ref('stg_calendar') }} c
left join {{ ref('stg_amenities_changelog') }} a
    on c.listing_id = a.listing_id
    and a.change_at::date <= c.date
qualify row_number() over (
    partition by c.listing_id, c.date
    order by a.change_at desc
) = 1