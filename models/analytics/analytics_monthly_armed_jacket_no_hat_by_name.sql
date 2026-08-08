with sightings as (

    select * from {{ ref('fact_sighting') }}

),

monthly as (

    select
        to_char(date_witness::date, 'Month') as month_name,
        date_part('month', date_witness::date)::int as month_num,
        count(*) as total_sightings,
        count(*) filter (where has_weapon and has_jacket and not has_hat) as armed_jacket_no_hat

    from sightings
    group by 1, 2

)

select
    month_name,
    round(100.0 * armed_jacket_no_hat / total_sightings, 2) as probability_pct

from monthly

order by month_num