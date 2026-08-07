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

behavior_counts AS (
  SELECT
    b.behavior_id,
    b.behavior_name,
    COUNT(*) AS occurrences

    FROM sightings s

    JOIN {{ ref('dim_sighting_behavior') }} b
      USING (behavior_id)
      
    GROUP BY 
      b.behavior_id,
      b.behavior_name
)

SELECT
  behavior_id,
  behavior_name,
  occurrences

FROM behavior_counts

ORDER BY occurrences DESC

LIMIT 3