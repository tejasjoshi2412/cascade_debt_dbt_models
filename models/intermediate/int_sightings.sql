with

africa as (
    select * from {{ ref('stg_africa_sightings') }}
),
america as (
    select * from {{ ref('stg_america_sightings') }}
),
asia as (
    select * from {{ ref('stg_asia_sightings') }}
),
atlantic as (
    select * from {{ ref('stg_atlantic_sightings') }}
),
australia as (
    select * from {{ ref('stg_australia_sightings') }}
),
europe as (
    select * from {{ ref('stg_europe_sightings') }}
),
indian as (
    select * from {{ ref('stg_indian_sightings') }}
),
pacific as (
    select * from {{ ref('stg_pacific_sightings') }}
),

unioned as (

    select * from africa
    union all
    select * from america
    union all
    select * from asia
    union all
    select * from atlantic
    union all
    select * from australia
    union all
    select * from europe
    union all
    select * from indian
    union all
    select * from pacific

)

select
    sighting_id,
    date_witness,
    agent,
    witness,
    date_agent,
    city_agent,
    country,
    city,
    latitude,
    longitude,
    has_weapon,
    has_hat,
    has_jacket,
    behavior,
    region

from unioned