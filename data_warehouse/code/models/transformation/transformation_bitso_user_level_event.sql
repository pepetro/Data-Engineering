select
    to_base64(sha256(concat(a.`user_id`, '::', a.`jurisdiction`, '::', a.`level`, '::',
        a.`event_timestamp`))) as `user_level_event_id`,
    'bitso' as `source_system`,
    to_base64(sha256(a.`user_id`)) as `user_id`,
    to_base64(sha256(a.`jurisdiction`)) as `jurisdiction_id`,
    a.`level`,
    date(a.`event_timestamp`) as `event_date`,
    a.`event_timestamp`
from
    {{ ref('source_demo_user_level_event') }} as a
