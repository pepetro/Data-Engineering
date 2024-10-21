/*
 Model Name  : demo_events.sql
 Model Path  : sources\source\demo
 Alias       : events
 Jinja       : ref('demo_events')
 SQL         : SELECT <cols> FROM `<db>`.`source`.`demo_events`
 Note:       : This is an auto-generated dbt model, do not alter
               below as it may be overwritten at any time.
*/
select
    `id`,                                                   -- int64
    `event_timestamp`,                                      -- timestamp
    `user_id`,                                              -- string
    `event_name`                                          -- string
from
    {{ source('demo', 'events') }}
