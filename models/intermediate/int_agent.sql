WITH agents AS (
  SELECT 
    DISTINCT {{ dbt_utils.generate_surrogate_key(['agent', 'city_agent', 'region']) }} AS agent_id,
    agent AS agent_name,
    city_agent AS agent_hq_city,
    region
 
  FROM {{ ref('int_sightings') }}
)

SELECT
  agent_id,
  agent_name,
  agent_hq_city,
  region

FROM agents
