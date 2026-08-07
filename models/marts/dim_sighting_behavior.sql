WITH source AS (
  SELECT 
    behavior_id,
    behavior_name

  FROM {{ ref('int_sighting_behavior') }}
)

SELECT
  behavior_id,
  behavior_name

FROM source
