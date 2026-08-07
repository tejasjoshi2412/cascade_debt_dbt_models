with sightings as (

    select * from {{ ref('fact_sighting') }}

),

monthly as (

    select
        to_char(date_witness::date, 'YYYY-MM') as sighting_month,
        count(*) as total_sightings,
        count(*) filter (where has_weapon and has_jacket and not has_hat) as armed_jacket_no_hat

    from sightings
    group by sighting_month

)

select
    sighting_month,
    total_sightings,
    armed_jacket_no_hat,
    round(armed_jacket_no_hat::numeric / total_sightings, 4) as probability_armed_jacket_no_hat

from monthly

order by sighting_month