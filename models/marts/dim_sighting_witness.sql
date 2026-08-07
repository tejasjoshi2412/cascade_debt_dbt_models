WITH source AS (
  SELECT 
    witness_id,
    witness_name
    
  FROM {{ ref('int_sighting_witness') }}

)

SELECT
  witness_id,
  witness_name

FROM source
