WITH
source AS (
        SELECT * FROM {{ source('northstar_raw', 'subscription_history') }}
),
staged AS (
    SELECT
     NULLIF(TRIM(payload:subscription_history_id::VARCHAR), '') AS subscription_history_id,
     NULLIF(TRIM(payload:subscription_id::VARCHAR), '') AS subscription_id,
     NULLIF(TRIM(payload:account_id::VARCHAR), '') AS account_id,
     NULLIF(TRIM(payload:plan_id::VARCHAR), '') AS plan_id,
     LOWER(NULLIF(TRIM(payload:status::VARCHAR), '')) AS subscription_history_status,
     TRY_TO_DECIMAL(NULLIF(TRIM(payload:seats_count::VARCHAR), ''), 18, 0) AS subscription_history_seats_count,
     LOWER(NULLIF(TRIM(payload:change_type::VARCHAR), '')) AS subscription_history_change_type,
     TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:effective_from::VARCHAR), '')) AS subscription_history_effective_from,
     TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:effective_to::VARCHAR), '')) AS subscription_history_effective_to,
     _source_file AS source_file,
     loaded_at AS raw_loaded_at
     FROM source
)
SELECT * FROM staged;