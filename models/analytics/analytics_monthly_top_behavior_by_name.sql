with sightings as (

    select * from {{ ref('fact_sighting') }}

),

monthly_behavior as (

    select
        to_char(s.date_witness::date, 'Month') as month_name,
        date_part('month', s.date_witness::date)::int as month_num,
        b.behavior_name,
        count(*) as occurrences

    from sightings as s
    join {{ ref('dim_sighting_behavior') }} as b
        on s.behavior_id = b.behavior_id

    group by 1, 2, 3

),

ranked as (

    select
        month_name,
        month_num,
        behavior_name,
        occurrences,
        row_number() over (partition by month_name order by occurrences desc) as rn

    from monthly_behavior

)

select
    month_name,
    behavior_name as most_common_behavior,
    occurrences

from ranked

where rn = 1

order by month_num