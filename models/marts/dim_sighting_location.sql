WITH source AS (
  SELECT
    location_id,
    city,
    country,
    region

  FROM {{ ref('int_sighting_locations') }}
)

SELECT
  location_id,
  city,
  country,
  region

FROM source