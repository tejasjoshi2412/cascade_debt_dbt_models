WITH source AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(['witnessed', 'observer', 'place', 'nation']) }} AS sighting_id,
    witnessed AS date_witness,
    field_chap AS agent,
    observer AS witness,
    reported AS date_agent,
    interpol_spot AS city_agent,
    nation AS country,
    place AS city,
    lat AS latitude,
    long AS longitude,
    has_weapon,
    has_hat,
    has_jacket,
    state_of_mind AS behavior,
    'Australia' AS region

  FROM {{ source('interpol', 'australia') }}

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
  