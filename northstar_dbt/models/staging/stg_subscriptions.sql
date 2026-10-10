WITH
source AS (
    SELECT * FROM {{ source('northstar_raw', 'subscriptions') }}
),

staged AS (
    SELECT 
        NULLIF(TRIM(payload:subscription_id::VARCHAR),'') AS subscription_id,
        NULLIF(TRIM(payload:account_id::VARCHAR),'') AS account_id,
        NULLIF(TRIM(payload:plan_id::VARCHAR),'') AS plan_id,
        LOWER(NULLIF(TRIM(payload:status::VARCHAR),'')) AS subscription_status,
        TRY_TO_DECIMAL(NULLIF(TRIM(payload:seats_count::VARCHAR),''), 18, 0) AS subscription_seats_count,
        LOWER(NULLIF(TRIM(payload:change_type::VARCHAR),'')) AS subscription_change_type,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:start_date::VARCHAR),'')) AS subscription_start_date,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:end_date::VARCHAR),'')) AS subscription_end_date,
        _source_file AS source_file,
        loaded_at AS raw_loaded_at
    FROM source
)
Select * FROM staged;