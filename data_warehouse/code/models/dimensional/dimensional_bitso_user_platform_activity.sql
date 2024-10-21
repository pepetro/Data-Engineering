with `tx_dates` as (
    select distinct *
    from (
        select
            a.`event_date_id`
        from
            {{ ref('relational_bitso_deposit') }} as a
        where
            a.`status` = 'complete'

        union all

        select
            a.`event_date_id`
        from
            {{ ref('relational_bitso_withdrawal') }} as a
        where
            a.`status` = 'complete'
    )
),
`user_deposits` as (
    select
        a.`event_date_id`,
        count(distinct a.`user_id`) as `users`
    from
        {{ ref('relational_bitso_deposit') }} as a
    where
        a.`status` = 'complete'
    group by
        a.`event_date_id`
),
`user_withdraw` as (
    select
        a.`event_date_id`,
        count(distinct a.`user_id`) as `users`
    from
        {{ ref('relational_bitso_withdrawal') }} as a
    where
        a.`status` = 'complete'
    group by
        a.`event_date_id`
),
`base` as (
    select
        a.`event_date_id`,
        (case when b.`users` is null then 0 else b.`users` end) as `active_users_deposit`,
        (case when c.`users` is null then 0 else c.`users` end) as `active_users_withdraw`
    from
        `tx_dates` as a
    left join
        `user_deposits` as b using(`event_date_id`)
    left join
        `user_withdraw` as c using(`event_date_id`)
)
select
    to_base64(sha256(cast(a.`event_date_id` as string))) as `user_platform_activity_id`,
    a.`event_date_id`,
    a.`active_users_deposit`,
    a.`active_users_withdraw`,
    a.`active_users_deposit` + a.`active_users_withdraw` as `active_users`
from
    `base` as a
order by
    a.`event_date_id` desc
