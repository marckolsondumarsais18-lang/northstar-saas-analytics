WITH
source AS (
        SELECT * FROM {{ source('northstar_raw', 'support_tickets') }}
),
staged AS (
    SELECT
        NULLIF(TRIM(payload:ticket_id::VARCHAR), '') AS ticket_id,
        NULLIF(TRIM(payload:account_id::VARCHAR), '') AS account_id,
        NULLIF(TRIM(payload:workspace_id::VARCHAR), '') AS workspace_id,
        NULLIF(TRIM(payload:user_id::VARCHAR), '') AS user_id,
        LOWER(NULLIF(TRIM(payload:category::VARCHAR), '')) AS ticket_category,
        LOWER(NULLIF(TRIM(payload:status::VARCHAR), '')) AS ticket_status,
        LOWER(NULLIF(TRIM(payload:channel::VARCHAR), '')) AS ticket_channel,
        TRY_TO_DECIMAL(NULLIF(TRIM(payload:satisfaction_score::VARCHAR), ''), 18, 0) AS ticket_satisfaction_score,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:created_at::VARCHAR), '')) AS ticket_created_at,
        _source_file AS source_file,
        loaded_at AS raw_loaded_at
    FROM source
)
SELECT * FROM staged;