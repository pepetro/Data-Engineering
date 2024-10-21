select
    a.`user_level_event_id`,
    a.`source_system`,
    a.`user_id`,
    a.`jurisdiction_id`,
    a.`level`,
    cast(format_date('%Y%m%d', a.`event_date`) as integer) as `event_date_id`,
    a.`event_timestamp`
from
    `andela-data-warehouse-dev`.`transformation_pep`.`bitso_demo_transformation_bitso_user_level_event` as a