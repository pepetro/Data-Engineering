select distinct
    to_base64(sha256(a.`jurisdiction`)) as `jurisdiction_id`,
    'bitso' as `source_system`,
    a.`jurisdiction`
from
    {{ ref('source_demo_user_level_event') }} as a
