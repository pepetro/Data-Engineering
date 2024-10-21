select
    a.`user_id`,
    a.`user_made_deposit`,
    a.`user_made_withdraw`,
    a.`first_deposit_date_id`,
    a.`last_deposit_date_id`,
    a.`first_withdraw_date_id`,
    a.`last_withdraw_date_id`,
    a.`last_login_date_id`
from
     {{ ref('relational_bitso_user') }} as a
