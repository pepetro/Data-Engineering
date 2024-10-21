select
    to_base64(sha256(a.`user_id`)) as `user_id`,
    'bitso' as `source_system`,
    a.`user_id` as `source_id`
from
    `andela-data-warehouse-dev`.`source_pep`.`demo_users` as a