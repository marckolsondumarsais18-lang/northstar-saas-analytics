WITH
source AS (
        SELECT * FROM {{ source('northstar_raw', 'payment_attempts') }}
),
staged AS (
    SELECT
        NULLIF(TRIM(payload:payment_attempt_id::VARCHAR), '') AS payment_attempt_id,
        NULLIF(TRIM(payload:account_id::VARCHAR), '') AS account_id,
        NULLIF(TRIM(payload:invoice_id::VARCHAR), '') AS invoice_id,
        LOWER(NULLIF(TRIM(payload:method::VARCHAR), '')) AS payment_attempt_method,
        LOWER(NULLIF(TRIM(payload:status::VARCHAR), '')) AS payment_attempt_status,
        TRY_TO_DECIMAL(NULLIF(TRIM(payload:attempted_amount::VARCHAR), ''), 18, 2) AS attempted_amount,
        TRY_TO_DECIMAL(NULLIF(TRIM(payload:captured_amount::VARCHAR), ''), 18, 2) AS captured_amount,
        LOWER(NULLIF(TRIM(payload:failure_reason::VARCHAR), '')) AS failure_reason,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:occurred_at::VARCHAR), '')) AS payment_attempt_occurred_at,
        _source_file AS source_file,
        loaded_at AS raw_loaded_at
    FROM source
)
SELECT * FROM staged;