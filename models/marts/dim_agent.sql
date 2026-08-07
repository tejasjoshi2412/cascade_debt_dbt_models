WITH source AS (
  SELECT
    agent_id,
    agent_name,
    agent_hq_city,
    region

  FROM {{ ref('int_agent') }}
)

SELECT
  agent_id,
  agent_name,
  agent_hq_city,
  region

FROM source