with source as (

    select * from {{ ref('int_sightings') }}

),

final as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['agent', 'city_agent', 'region']) }} as agent_id,
        agent as agent_name,
        city_agent as agent_hq_city,
        region

    from source

)

select * from final