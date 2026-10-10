WITH
source AS (
        SELECT * FROM {{ source('northstar_raw', 'users') }}
),
staged AS (
    SELECT
        NULLIF(TRIM(payload:user_id::VARCHAR), '') AS user_id,
        NULLIF(TRIM(payload:account_id::VARCHAR), '') AS account_id,
        LOWER(NULLIF(TRIM(payload:status::VARCHAR), '')) AS user_status,
        LOWER(NULLIF(TRIM(payload:role::VARCHAR), '')) AS user_role,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:created_at::VARCHAR), '')) AS user_created_at,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:last_seen_at::VARCHAR), '')) AS user_last_seen_at,
        _source_file AS source_file,
        loaded_at AS raw_loaded_at
    FROM source
)
SELECT * FROM staged;