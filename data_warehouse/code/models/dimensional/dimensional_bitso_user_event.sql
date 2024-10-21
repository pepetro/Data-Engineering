select
    a.`event_id`,
    a.`user_id`,
    a.`event_name`,
    a.`event_date_id`,
    a.`event_timestamp`
from
    {{ ref('relational_bitso_user_event') }} as a
left join
    {{ ref('relational_bitso_user') }} as b using(`user_id`)
inner join
    {{ ref('relational_bitso_calendar') }} as c on a.`event_date_id` = c.`calendar_id`
