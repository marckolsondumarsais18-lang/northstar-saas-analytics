WITH
source AS (
        SELECT * FROM {{ source('northstar_raw', 'plans') }}
), 

staged AS (
    SELECT
    NULLIF(TRIM(payload:plan_id::VARCHAR), '') AS plan_id,
    LOWER(NULLIF(TRIM(payload:name::VARCHAR), '')) AS plan_name,
    LOWER(NULLIF(TRIM(payload:status::VARCHAR), '')) AS plan_status,
    LOWER(NULLIF(TRIM(payload:tier::VARCHAR), '')) AS plan_tier, 
    TRY_TO_DECIMAL(NULLIF(TRIM(payload:rank::VARCHAR), ''), 18, 0) AS plan_rank,
    TRY_TO_DECIMAL(NULLIF(TRIM(payload:price::VARCHAR), ''), 18, 2) AS plan_price,
    LOWER(NULLIF(TRIM(payload:billing_frequency::VARCHAR), '')) AS plan_billing_frequency,
    TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:created_at::VARCHAR), '')) AS plan_created_at,
    _source_file AS source_file,
    loaded_at AS raw_loaded_at
    FROM source
)
SELECT * FROM staged;
