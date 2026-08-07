WITH source AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(['date_witness', 'witness', 'city', 'country']) }} AS sighting_id,
    date_witness,
    agent,
    witness,
    date_agent,
    region_hq AS city_agent,
    country,
    city,
    latitude,
    longitude,
    has_weapon,
    has_hat,
    has_jacket,
    behavior,
    'America' AS region

  FROM {{ source('interpol', 'america') }}

)

SELECT
  sighting_id,
  date_witness,
  agent,
  witness,
  date_agent,
  city_agent,
  country,
  city,
  latitude,
  longitude,
  has_weapon,
  has_hat,
  has_jacket,
  behavior,
  region

FROM source
  