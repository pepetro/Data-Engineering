select
    a.`interface_id`,
    a.`source_system`,
    a.`interface`
from
    {{ ref('transformation_bitso_interface') }} as a