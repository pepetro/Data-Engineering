select
    a.`deposit_id`,
    a.`source_system`,
    a.`source_id`,
    a.`user_id`,
    a.`amount`,
    a.`currency_id`,
    a.`status`,
    {{ calendar_key('event_date', 'a') }} as `event_date_id`,
    a.`event_timestamp`
from
    {{ ref('transformation_bitso_deposit') }} as a