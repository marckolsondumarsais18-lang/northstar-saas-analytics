WITH 
source AS (  
    SELECT * FROM {{ source('northstar_raw', 'accounts') }}
),
staged AS (
    SELECT 
        NULLIF(TRIM(payload:account_id::VARCHAR),'') AS account_id,
        NULLIF(TRIM(payload:name::VARCHAR),'') AS account_name,
        LOWER(NULLIF(TRIM(payload:status::VARCHAR),'')) AS account_status,
        LOWER(NULLIF(TRIM(payload:industry::VARCHAR),'')) AS industry,
        UPPER(NULLIF(TRIM(payload:country::VARCHAR),'')) AS country_code,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:created_at::VARCHAR),'')) AS created_at,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:updated_at::VARCHAR),'')) AS updated_at,
        _source_file AS source_file,
        loaded_at AS raw_loaded_at
    FROM source
)
SELECT * FROM staged;

