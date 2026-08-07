WITH source AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(['date_witness', 'witness', 'city', 'country']) }} AS sighting_id,
    date_witness,
    agent,
    witness,
    date_filed AS date_agent,
    region_hq AS city_agent,
    country,
    city,
    lat_ AS latitude,
    long_ AS longitude,
    "armed?" AS has_weapon,
    "chapeau?" AS has_hat,
    "coat?" AS has_jacket,
    observed_action AS behavior,
    'Europe' AS region

  FROM {{ source('interpol', 'europe') }}

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
  