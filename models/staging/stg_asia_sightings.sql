WITH source AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(['sighting', 'citizen', 'city', 'nation']) }} AS sighting_id,
    sighting AS date_witness,
    officer AS agent,
    citizen AS witness,
    报道 AS date_agent,
    city_interpol AS city_agent,
    nation AS country,
    city,
    纬度 AS latitude,
    经度 AS longitude,
    has_weapon,
    has_hat,
    has_jacket,
    behavior,
    'Asia' AS region

  FROM {{ source('interpol', 'asia') }}

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
