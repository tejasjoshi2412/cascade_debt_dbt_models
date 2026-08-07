with source as (

    select * from {{ ref('int_sightings') }}

),

final as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['behavior']) }} as behavior_id,
        behavior as behavior_name

    from source

)

select * from final