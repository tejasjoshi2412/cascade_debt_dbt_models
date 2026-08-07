with source as (

    select * from {{ ref('int_sightings') }}

),

witness as (
    select * from {{ ref('dim_witness') }}
),
agent as (
    select * from {{ ref('dim_agent') }}
),
location as (
    select * from {{ ref('dim_location') }}
),
behavior as (
    select * from {{ ref('dim_behavior') }}
),

final as (

    select
        s.sighting_id,
        s.date_witness,
        s.date_agent,
        s.region,
        w.witness_id,
        a.agent_id,
        l.location_id,
        b.behavior_id,
        s.has_weapon,
        s.has_hat,
        s.has_jacket

    from source as s
    left join witness as w
        on s.witness = w.witness_name
    left join agent as a
        on s.agent = a.agent_name
        and s.city_agent = a.agent_hq_city
        and s.region = a.region
    left join location as l
        on s.city = l.city
        and s.country = l.country
        and s.region = l.region
    left join behavior as b
        on s.behavior = b.behavior_name

)

select * from final