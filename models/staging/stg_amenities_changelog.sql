select
    listing_id,
    change_at::timestamp as change_at,
    parse_json(amenities) as amenities
from {{ ref('AMENITIES_CHANGELOG') }}