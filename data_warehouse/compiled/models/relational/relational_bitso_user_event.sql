select
    a.`event_id`,
    a.`source_system`,
    a.`source_id`,
    a.`user_id`,
    a.`event_name`,
   cast(format_date('%Y%m%d', a.`event_date`) as integer) as `event_date_id`,
    a.`event_timestamp`
from
    `andela-data-warehouse-dev`.`transformation_pep`.`bitso_demo_transformation_bitso_user_event` as a