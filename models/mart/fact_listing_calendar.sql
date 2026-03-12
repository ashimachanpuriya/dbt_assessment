select
    base.listing_id,
    base.date,
    base.is_available,
    base.reservation_id,
    case when base.reservation_id is not null then true else false end as is_reserved,
    base.price,
    base.minimum_nights,
    base.maximum_nights,
    base.change_at,
    base.amenities,
    l.listing_name,
    l.host_id,
    l.host_name,
    l.host_since,
    l.host_location,
    l.neighborhood,
    l.property_type,
    l.room_type,
    l.accommodates,
    l.bathrooms_text,
    l.bedrooms,
    l.beds,
    l.number_of_reviews,
    l.first_review,
    l.last_review,
    l.review_scores_rating
 /*
 Note: left join preserves calendar rows for listing 276450 which exists
 in calendar but has no corresponding listing record. Host details will
 be null for this listing but revenue data is preserved.
*/
from {{ ref('int_amenities_date_wise') }} as base  
left join {{ ref('stg_listings') }} l
    on base.listing_id = l.listing_id