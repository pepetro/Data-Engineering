select distinct
    to_base64(sha256(a.`interface`)) as `interface_id`,
    'bitso' as `source_system`,
    a.`interface`
from
    `andela-data-warehouse-dev`.`source_pep`.`demo_withdrawals` as a