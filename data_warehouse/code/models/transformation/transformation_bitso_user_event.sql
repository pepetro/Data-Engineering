select
    to_base64(sha256(cast(a.`id` as string))) as `event_id`,
    'bitso' as `source_system`,
    a.`id` as `source_id`,
    to_base64(sha256(a.`user_id`)) as `user_id`,
    a.`event_name`,
    date(a.`event_timestamp`) as `event_date`,
    a.`event_timestamp`
from
    {{ ref('source_demo_events') }} as a
