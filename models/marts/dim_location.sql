with source as (

    select * from {{ ref('int_sightings') }}

),

final as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['city', 'country', 'region']) }} as location_id,
        city,
        country,
        region

    from source

)

select * from final