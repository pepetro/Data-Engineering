with `base_currency` as (
    select distinct
        a.`currency`
    from
        {{ ref('source_demo_withdrawals') }} as a

    union all

    select distinct
        a.`currency`
    from
        {{ ref('source_demo_deposits') }} as a
)
select distinct
    to_base64(sha256(a.`currency`)) as `currency_id`,
    'bitso' as `source_system`,
    a.`currency`
from
    `base_currency` as a
