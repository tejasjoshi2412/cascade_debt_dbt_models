with sightings as (

    select * from {{ ref('fact_sighting') }}

),

monthly_region as (

    select
        to_char(date_witness::date, 'YYYY-MM') as sighting_month,
        region,
        count(*) as sightings

    from sightings
    group by sighting_month, region

),

ranked as (

    select
        sighting_month,
        region,
        sightings,
        sum(sightings) over (partition by sighting_month) as total_sightings,
        row_number() over (partition by sighting_month order by sightings desc) as rn

    from monthly_region

)

select
    sighting_month,
    region as most_likely_region,
    sightings,
    total_sightings,
    round(sightings::numeric / total_sightings, 4) as likelihood

from ranked

where rn = 1

order by sighting_month