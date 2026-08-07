WITH sightings AS (
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
    
  FROM {{ ref('fact_sighting') }}
),

monthly_region AS (
  SELECT
    to_char(date_witness::DATE, 'YYYY-MM') AS sighting_month,
    region,
    count(*) AS sightings

  FROM sightings
  
  GROUP BY sighting_month, region
),

ranked AS (
  SELECT
    sighting_month,
    region,
    sightings,
    SUM(sightings) OVER (PARTITION BY sighting_month) AS total_sightings,
    ROW_NUMBER() OVER (PARTITION BY sighting_month ORDER BY sightings DESC) AS rn

  FROM monthly_region
)

SELECT
  sighting_month,
  region AS most_likely_region,
  sightings,
  total_sightings,
  round(sightings::NUMERIC / total_sightings, 4) AS likelihood

FROM ranked

WHERE rn = 1

ORDER BY sighting_month
