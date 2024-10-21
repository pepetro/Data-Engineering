select
    to_base64(sha256(cast(a.`id` as string))) as `deposit_id`,
    'bitso' as `source_system`,
    a.`id` as `source_id`,
    to_base64(sha256(a.`user_id`)) as `user_id`,
    a.`amount`,
    to_base64(sha256(a.`currency`)) as `currency_id`,
    a.`tx_status` as `status`,
    date(a.`event_timestamp`) as `event_date`,
    a.`event_timestamp`
from
    {{ ref('source_demo_deposits') }} as a
-- Identified entries with same timestamp, amount, currency, user_id BUT DIFFERENT id
-- As this seems to be bad quality data, we will keep one record for that scenario
qualify row_number() over (partition by a.event_timestamp, a.`user_id`, cast(a.amount as string),
currency_id, a.`tx_status` order by a.event_timestamp desc) = 1
