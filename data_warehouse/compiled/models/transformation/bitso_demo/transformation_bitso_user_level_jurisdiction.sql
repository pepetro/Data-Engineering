select distinct
    to_base64(sha256(a.`jurisdiction`)) as `jurisdiction_id`,
    'bitso' as `source_system`,
    a.`jurisdiction`
from
    `andela-data-warehouse-dev`.`source_pep`.`demo_user_level_event` as a