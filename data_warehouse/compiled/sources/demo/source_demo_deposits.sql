/*
 Model Name  : demo_deposits.sql
 Model Path  : sources\source\demo
 Alias       : deposits
 Jinja       : ref('demo_deposits')
 SQL         : SELECT <cols> FROM `<db>`.`source`.`demo_deposits`
 Note:       : This is an auto-generated dbt model, do not alter
               below as it may be overwritten at any time.
*/
select
    `id`,                                                   -- int64
    `event_timestamp`,                                      -- timestamp
    `user_id`,                                              -- string
    `amount`,                                               -- float64
    `currency`,                                             -- string
    `tx_status`,                                            -- string
    current_timestamp() as `min_data_last_updated_at`,           -- timestamp
    current_timestamp() as `max_data_last_updated_at`           -- timestamp
from
    `andela-data-lake-dev`.`demo`.`deposits`