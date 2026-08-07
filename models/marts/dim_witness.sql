with source as (

    select * from {{ ref('int_sightings') }}

),

final as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['witness']) }} as witness_id,
        witness as witness_name

    from source

)

select * from final