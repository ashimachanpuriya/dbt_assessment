select 
    id as listing_id,
    name as listing_name,
    host_id,
    host_name,
    host_since::date as host_since,
    host_location,
    parse_json(host_verifications) as host_verifications,
    neighborhood,
    property_type,
    room_type,
    accommodates,
    bathrooms_text,
    bedrooms,
    beds,
    parse_json(amenities) as amenities,
    price,
    number_of_reviews,
    first_review,
    last_review,
    review_scores_rating
from {{ ref('LISTINGS') }}
where id is not null
and host_id > 0  -- filters out test records with dummy negative IDs