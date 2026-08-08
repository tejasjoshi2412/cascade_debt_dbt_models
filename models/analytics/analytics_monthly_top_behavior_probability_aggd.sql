with sightings as (

    select * from {{ ref('fact_sighting') }}

),

top_behaviors as (

    select
        behavior_id,
        behavior_name

    from {{ ref('analytics_top_behaviors') }}

),

top_behavior_names as (

    select string_agg(behavior_name, ', ' order by behavior_name) as behavior_names

    from top_behaviors

),

monthly as (

    select
        to_char(s.date_witness::date, 'Month') as month_name,
        date_part('month', s.date_witness::date)::int as month_num,
        count(*) as total_sightings,
        count(*) filter (where s.behavior_id in (select behavior_id from top_behaviors)) as top_behavior_sightings

    from sightings as s
    group by 1, 2

)

select
    m.month_name,
    tb.behavior_names,
    round(100.0 * m.top_behavior_sightings / m.total_sightings, 2) as probability_of_top_behaviors_pct

from monthly as m
cross join top_behavior_names as tb

order by m.month_num