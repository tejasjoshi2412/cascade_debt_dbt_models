WITH source AS (
  SELECT
    sighting_id,
    date_witness,
    date_agent,
    region,
    country,
    city,
    agent,
    city_agent,
    witness,
    behavior,
    has_weapon,
    has_hat,
    has_jacket

  FROM {{ ref('int_sightings') }}
),

witness AS (
    SELECT * FROM {{ ref('dim_sighting_witness') }}
),
agent AS (
    SELECT * FROM {{ ref('dim_agent') }}
),
location AS (
    SELECT * FROM {{ ref('dim_sighting_location') }}
),
behavior AS (
    SELECT * FROM {{ ref('dim_sighting_behavior') }}
),

final AS (
  SELECT
    s.sighting_id,
    s.date_witness,
    s.date_agent,
    s.region,
    w.witness_id,
    a.agent_id,
    l.location_id,
    b.behavior_id,
    s.has_weapon,
    s.has_hat,
    s.has_jacket

  FROM source s
  LEFT JOIN witness w
    ON s.witness = w.witness_name
  LEFT JOIN agent a
    ON s.agent = a.agent_name
      AND s.city_agent = a.agent_hq_city
      AND s.region = a.region
  LEFT JOIN location l
    ON s.city = l.city
      AND s.country = l.country
      AND s.region = l.region
  LEFT JOIN behavior b
      ON s.behavior = b.behavior_name
)

SELECT
  sighting_id,
  date_witness,
  date_agent,
  region,
  witness_id,
  agent_id,
  location_id,
  behavior_id,
  has_weapon,
  has_hat,
  has_jacket

FROM final