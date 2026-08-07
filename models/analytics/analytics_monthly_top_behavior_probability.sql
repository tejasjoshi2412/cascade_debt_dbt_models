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

top_behaviors AS (
  SELECT 
    behavior_id 
  
  FROM {{ ref('analytics_top_behaviors') }}
),

monthly AS (
  SELECT
    to_char(s.date_witness::DATE, 'YYYY-MM') AS sighting_month,
    count(*) AS total_sightings,
    count(*) FILTER (WHERE s.behavior_id IN (
        SELECT behavior_id FROM top_behaviors)
    ) AS top_behavior_sightings -- SE IF WE CAN WRITE A DIFFERENT CTE FOR THIS

  FROM sightings s
  
  GROUP BY sighting_month

)

SELECT
  sighting_month,
  total_sightings,
  top_behavior_sightings,
  ROUND(top_behavior_sightings::NUMERIC / total_sightings, 4) AS probability_of_top_behaviors

FROM monthly

ORDER BY sighting_month
