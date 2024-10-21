with `base` as (
    select
        a.`deposit_id` as `source_tx_type_id`,
        a.`event_timestamp`,
        a.`event_date_id`,
        a.`user_id`,
        'deposit' as `type`,
        a.`amount`,
        a.`currency_id`,
        a.`status`
    from
        {{ ref('relational_bitso_deposit') }} as a

    union all

    select
        a.`withdrawal_id` as `source_tx_type_id`,
        a.`event_timestamp`,
        a.`event_date_id`,
        a.`user_id`,
        'withdraw' as `type`,
        a.`amount`,
        a.`currency_id`,
        a.`status`
    from
        {{ ref('relational_bitso_withdrawal') }} as a
)

select
    to_base64(sha256(concat(a.`event_timestamp`, '::', a.`user_id`, '::', a.`type`, '::', a.`amount`,
    '::', a.`currency_id`, '::', a.`status`))) as `tx_id`,
    a.`event_timestamp`,
    a.`event_date_id`,
    a.`source_tx_type_id`,
    a.`user_id`,
    a.`type`,
    a.`amount`,
    a.`currency_id`,
    a.`status`
from
  `base` as a
