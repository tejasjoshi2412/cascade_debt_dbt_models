WITH source AS (
  SELECT
    {{ dbt_utils.generate_surrogate_key(['sight_on', 'sighter', 'town', 'nation']) }} AS sighting_id,
    sight_on AS date_witness,
    filer AS agent,
    sighter AS witness,
    file_on AS date_agent,
    report_office AS city_agent,
    nation AS country,
    town AS city,
    lat AS latitude,
    long AS longitude,
    has_weapon,
    has_hat,
    has_jacket,
    behavior,
    'Pacific' AS region

  FROM {{ source('interpol', 'pacific') }}

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
  