/*
 Model Name  : demo_user_level_event.sql
 Model Path  : sources\source\demo
 Alias       : user_level_event
 Jinja       : ref('demo_user_level_event')
 SQL         : SELECT <cols> FROM `<db>`.`source`.`demo_user_level_event`
 Note:       : This is an auto-generated dbt model, do not alter
               below as it may be overwritten at any time.
*/
select
    `user_id`,                                              -- string
    `jurisdiction`,                                         -- string
    `level`,                                                -- string
    `event_timestamp`                                      -- timestamp
from
    {{ source('demo', 'user_level_event') }}
