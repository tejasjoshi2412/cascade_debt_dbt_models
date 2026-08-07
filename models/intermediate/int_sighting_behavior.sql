WITH sighting_behavior AS (
  SELECT 
    DISTINCT {{ dbt_utils.generate_surrogate_key(['behavior']) }} as behavior_id,
    behavior as behavior_name
  
  FROM {{ ref('int_sightings') }}
)

SELECT
  behavior_id,
  behavior_name

FROM sighting_behavior
