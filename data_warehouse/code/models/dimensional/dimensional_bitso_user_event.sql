select
    a.`event_id`,
    a.`user_id`,
    a.`event_name`,
    a.`event_date_id`,
    a.`event_timestamp`
from
    {{ ref('relational_bitso_user_event') }} as a
