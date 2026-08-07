WITH sighting_witness AS (
  SELECT 
    DISTINCT {{ dbt_utils.generate_surrogate_key(['witness']) }} AS witness_id,
    witness AS witness_name
    
  FROM {{ ref('int_sightings') }}
)

SELECT
  witness_id,
  witness_name

FROM sighting_witness
