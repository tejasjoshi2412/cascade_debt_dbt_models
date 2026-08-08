with sightings as (

    select * from {{ ref('fact_sighting') }}

),

top_behaviors as (

    select behavior_id from {{ ref('analytics_top_behaviors') }}

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
    month_name,
    round(100.0 * top_behavior_sightings / total_sightings, 2) as probability_of_top_behaviors_pct

from monthly

order by month_num