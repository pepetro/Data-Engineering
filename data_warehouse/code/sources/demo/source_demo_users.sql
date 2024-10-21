/*
 Model Name  : demo_users.sql
 Model Path  : sources\source\demo
 Alias       : users
 Jinja       : ref('demo_users')
 SQL         : SELECT <cols> FROM `<db>`.`source`.`demo_users`
 Note:       : This is an auto-generated dbt model, do not alter
               below as it may be overwritten at any time.
*/
select
    `user_id`                                              -- string
from
    {{ source('demo', 'users') }}
