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
    `andela-data-warehouse-dev`.`source_pep`.`demo_deposits` as a