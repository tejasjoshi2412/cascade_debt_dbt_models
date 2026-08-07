with source as (

    select * from {{ source('interpol', 'AFRICA') }}

),

renamed as (

    select
        date_witness,
        agent,
        witness,
        date_agent,
        region_hq as city_agent,
        country,
        city,
        latitude,
        longitude,
        has_weapon,
        has_hat,
        has_jacket,
        behavior,

        -- deterministic surrogate key for the sighting grain
        {{ dbt_utils.generate_surrogate_key(['date_witness', 'witness', 'city', 'country']) }} as sighting_id,

        'AFRICA' as region

    from source

)

select * from renamed