WITH unioned AS (
  SELECT 
    * 
  FROM {{ ref('stg_africa_sightings') }}
    
  UNION ALL
    
  SELECT 
    * 
  FROM {{ ref('stg_america_sightings') }}
    
  UNION ALL
    
  SELECT 
    * 
  FROM {{ ref('stg_asia_sightings') }}
    
  UNION ALL
    
  SELECT 
    * 
  FROM {{ ref('stg_atlantic_sightings') }}
    
  UNION ALL
    
  SELECT 
    * 
  FROM {{ ref('stg_australia_sightings') }}
    
  UNION ALL
    
  SELECT 
    * 
  FROM {{ ref('stg_europe_sightings') }}
    
  UNION ALL
    
  SELECT 
    * 
  FROM {{ ref('stg_indian_sightings') }}
    
  UNION ALL
    
  SELECT 
    * 
  FROM {{ ref('stg_pacific_sightings') }}
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

FROM unioned
