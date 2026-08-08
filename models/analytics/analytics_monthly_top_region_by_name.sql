with sightings as (

    select * from {{ ref('fact_sighting') }}

),

monthly_region as (

    select
        to_char(date_witness::date, 'Month') as month_name,
        date_part('month', date_witness::date)::int as month_num,
        region,
        count(*) as sightings

    from sightings
    group by 1, 2, 3

),

ranked as (

    select
        month_name,
        month_num,
        region,
        sightings,
        sum(sightings) over (partition by month_name) as total_sightings,
        row_number() over (partition by month_name order by sightings desc) as rn

    from monthly_region

),

final as (

    select
        month_name,
        month_num,
        region as most_likely_region,
        sightings,
        total_sightings,
        round(100.0 * sightings / total_sightings, 2) as likelihood_pct

    from ranked

    where rn = 1

)

select
    month_name,
    most_likely_region,
    likelihood_pct

from final

order by month_num