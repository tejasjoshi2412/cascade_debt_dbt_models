WITH sighting_location AS (
  SELECT 
    DISTINCT {{ dbt_utils.generate_surrogate_key(['city', 'country', 'region']) }} AS location_id,
    city,
    country,
    region 

  FROM {{ ref('int_sightings') }}
)

SELECT
  location_id,
  city,
  country,
  region

FROM sighting_location
