with sightings as (

    select * from {{ ref('fact_sighting') }}

),

behavior_counts as (

    select
        b.behavior_id,
        b.behavior_name,
        count(*) as occurrences

    from sightings as s
    join {{ ref('dim_behavior') }} as b
        on s.behavior_id = b.behavior_id

    group by b.behavior_id, b.behavior_name

)

select
    behavior_id,
    behavior_name,
    occurrences

from behavior_counts

order by occurrences desc

limit 3