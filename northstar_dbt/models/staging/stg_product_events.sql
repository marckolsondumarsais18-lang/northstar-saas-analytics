WITH
source AS (
        SELECT * FROM {{source('northstar_raw', 'product_events')}}
),
staged AS (
    SELECT
        NULLIF(TRIM(payload:event_id::VARCHAR), '') AS event_id,
        NULLIF(TRIM(payload:account_id::VARCHAR), '') AS account_id,
        NULLIF(TRIM(payload:workspace_id::VARCHAR), '') AS workspace_id,
        NULLIF(TRIM(payload:user_id::VARCHAR), '') AS user_id,
        LOWER(NULLIF(TRIM(payload:name::VARCHAR), '')) AS event_name,
        LOWER(NULLIF(TRIM(payload:feature::VARCHAR), '')) AS event_feature,
        LOWER(NULLIF(TRIM(payload:session::VARCHAR), '')) AS event_session,
        LOWER(NULLIF(TRIM(payload:test_flag::VARCHAR), '')) AS test_flag,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:occurred_at::VARCHAR), '')) AS event_occurred_at,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:recorded_at::VARCHAR), '')) AS event_recorded_at,
        _source_file AS source_file,
        loaded_at AS raw_loaded_at
    FROM source
)
SELECT * FROM staged;