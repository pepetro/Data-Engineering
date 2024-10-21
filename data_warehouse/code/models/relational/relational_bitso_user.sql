with `users_deposit` as (
    select
        distinct a.`user_id`
    from
        {{ ref('relational_bitso_deposit') }} as a
    where a.`status` = "complete"
),
`user_withdraw` as (
    select
        distinct a.`user_id`
    from
        {{ ref('relational_bitso_withdrawal') }} as a
    where a.`status` = "complete"
),
`user_base` as (
    select
        a.`user_id`,
        'deposit' as `tx`
    from
        `users_deposit` as a

    union all

    select
        a.`user_id`,
        'withdraw' as `tx`
    from
        `user_withdraw` as a
),
`user_tx` as (
    select
        a.`user_id`,
        logical_or(case when a.`tx` = "deposit" then true else false end) as `user_made_deposit`,
        logical_or(case when a.`tx` = "withdraw" then true else false end) as `user_made_withdraw`,
    from
        `user_base` as a
    group by
        a.`user_id`
),
`user_activity` as (
    select
        a.`user_id`,
        max(b.`event_date_id`) as `last_login_date_id`,
        min(c.`event_date_id`) as `first_deposit_date_id`,
        max(c.`event_date_id`) as `last_deposit_date_id`,
        min(c.`event_date_id`) as `first_withdraw_date_id`,
        max(c.`event_date_id`) as `last_withdraw_date_id`
    from
       {{ ref('transformation_bitso_user') }} as a
    left join
       {{ ref('relational_bitso_user_event') }} as b on b.`user_id` = a.`user_id` and
      b.`event_name` in ('login_api', '2falogin', 'login')  -- Assumed these are the login-type events
    left join
       {{ ref('relational_bitso_deposit') }} as c on c.`user_id` = a.`user_id` and c.`status` = "complete"
    left join
       {{ ref('relational_bitso_withdrawal') }} as d on d.`user_id` = a.`user_id` and d.`status` = "complete"
    group by
        a.`user_id`
)
select
    a.`user_id`,
    a.`source_system`,
    a.`source_id`,
    b.`user_made_deposit`,
    b.`user_made_withdraw`,
    c.`last_login_date_id`,
    c.`first_deposit_date_id`,
    c.`last_deposit_date_id`,
    c.`first_withdraw_date_id`,
    c.`last_withdraw_date_id`
from
    {{ ref('transformation_bitso_user') }} as a
left join
    `user_tx` as b using(`user_id`)
left join
    `user_activity` as c using(`user_id`)
