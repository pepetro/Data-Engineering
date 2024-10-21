select
    a.`jurisdiction_id`,
    a.`source_system`,
    a.`jurisdiction`
from
    {{ ref('transformation_bitso_user_level_jurisdiction') }} as a