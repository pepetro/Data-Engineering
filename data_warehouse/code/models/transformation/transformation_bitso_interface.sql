select distinct
    to_base64(sha256(a.`interface`)) as `interface_id`,
    'bitso' as `source_system`,
    a.`interface`
from
    {{ ref('source_demo_withdrawals') }} as a
