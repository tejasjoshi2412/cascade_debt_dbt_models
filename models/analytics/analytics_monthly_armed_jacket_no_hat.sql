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

monthly AS (
  SELECT
    to_char(date_witness::DATE, 'YYYY-MM') AS sighting_month,
    count(*) AS total_sightings,
    count(*) FILTER (WHERE has_weapon AND has_jacket AND NOT has_hat) AS armed_jacket_no_hat -- see if we can add a new cte for this

  FROM sightings
  
  GROUP BY sighting_month
)

SELECT
  sighting_month,
  total_sightings,
  armed_jacket_no_hat,
  ROUND(armed_jacket_no_hat::NUMERIC / total_sightings, 4) AS probability_armed_jacket_no_hat

FROM monthly

ORDER BY sighting_month
