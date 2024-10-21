select
    cast(format_date('%Y%m%d', `date`) as int64) as `calendar_id`,
    `date` as `calendar_date`,
    case
        when extract(dayofweek from `date`) = 1
        then 7
        else extract(dayofweek from `date`) - 1
    end as `day_of_week`,
    case when date_trunc(`date`, month) = `date` then true else false end as `is_first_date_of_month`,
    case when date_add(date_add(date_trunc(`date`, month), interval 1 month), interval -1 day) = `date` then true else false end as `is_last_date_of_month`,
    case when date_trunc(`date`, quarter) = `date` then true else false end as `is_first_date_of_quarter`,
    case when date_add(date_add(date_trunc(`date`, quarter), interval 1 quarter), interval -1 day) = `date` then true else false end as `is_last_date_of_quarter`,
    case when date_trunc(`date`, year) = `date` then true else false end as `is_first_date_of_year`,
    case when date_add(date_add(date_trunc(`date`, year), interval 1 year), interval -1 day) = `date` then true else false end as `is_last_date_of_year`,
    case
        when extract(dayofweek from `date`) in (1, 7)
        then false
        else true
    end as `is_weekday`,
    cast(format_date('%Y%m', `date`) as integer) as `fiscal_period_id`,
    cast(format_date('%G%V', `date`) as integer) as `fiscal_week_id`,
    case when `date` <= current_date('America/New_York') then true else false end as `is_historical_date`,
    case
        when `date` > current_date('America/New_York')
        then true else false
    end as `is_future_date`,
    extract(day from last_day(`date`)) as `number_of_days_in_month`
from
    unnest(generate_date_array(date('2020-01-01'), date('2030-12-31'))) as `date`