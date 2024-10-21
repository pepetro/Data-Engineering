select
    a.`withdrawal_id`,
    a.`source_system`,
    a.`source_id`,
    a.`user_id`,
    a.`amount`,
    a.`currency_id`,
    a.`interface_id`,
    a.`status`,
    cast(format_date('%Y%m%d', a.`event_date`) as integer) as `event_date_id`,
    a.`event_timestamp`
from
    `andela-data-warehouse-dev`.`transformation_pep`.`bitso_demo_transformation_bitso_withdrawal` as a