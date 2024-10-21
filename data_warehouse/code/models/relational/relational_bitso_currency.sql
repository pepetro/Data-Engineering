select
    a.`currency_id`,
    a.`source_system`,
    a.`currency`
from
    {{ ref('transformation_bitso_currency') }} as a