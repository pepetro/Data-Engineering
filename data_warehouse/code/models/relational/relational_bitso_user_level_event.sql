select
    a.`user_level_event_id`,
    a.`source_system`,
    a.`user_id`,
    a.`jurisdiction_id`,
    a.`level`,
    {{ calendar_key('event_date', 'a') }} as `event_date_id`,
    a.`event_timestamp`
from
    {{ ref('transformation_bitso_user_level_event') }} as a