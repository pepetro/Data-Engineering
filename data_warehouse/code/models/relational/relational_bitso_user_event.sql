select
    a.`event_id`,
    a.`source_system`,
    a.`source_id`,
    a.`user_id`,
    a.`event_name`,
   {{ calendar_key('event_date', 'a') }} as `event_date_id`,
    a.`event_timestamp`
from
    {{ ref('transformation_bitso_user_event') }} as a
