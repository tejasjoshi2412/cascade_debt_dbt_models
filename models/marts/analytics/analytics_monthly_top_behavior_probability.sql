with sightings as (

    select * from {{ ref('fact_sighting') }}

),

top_behaviors as (

    select behavior_id from {{ ref('analytics_top_behaviors') }}

),

monthly as (

    select
        to_char(s.date_witness::date, 'YYYY-MM') as sighting_month,
        count(*) as total_sightings,
        count(*) filter (where s.behavior_id in (select behavior_id from top_behaviors)) as top_behavior_sightings

    from sightings as s
    group by sighting_month

)

select
    sighting_month,
    total_sightings,
    top_behavior_sightings,
    round(top_behavior_sightings::numeric / total_sightings, 4) as probability_of_top_behaviors

from monthly

order by sighting_month