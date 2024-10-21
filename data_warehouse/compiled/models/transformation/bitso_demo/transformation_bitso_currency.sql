with `base_currency` as (
    select distinct
        a.`currency`
    from
        `andela-data-warehouse-dev`.`source_pep`.`demo_withdrawals` as a

    union all

    select distinct
        a.`currency`
    from
        `andela-data-warehouse-dev`.`source_pep`.`demo_deposits` as a
)
select distinct
    to_base64(sha256(a.`currency`)) as `currency_id`,
    'bitso' as `source_system`,
    a.`currency`
from
    `base_currency` as a