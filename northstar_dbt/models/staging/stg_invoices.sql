WITH 
source AS (
    SELECT * FROM {{ source('northstar_raw', 'invoices') }}
),
staged AS (
    SELECT 
        NULLIF(TRIM(payload:invoice_id::VARCHAR),'') AS invoice_id,
        NULLIF(TRIM(payload:account_id::VARCHAR),'') AS account_id,
        NULLIF(TRIM(payload:subscription_id::VARCHAR),'') AS subscription_id,
        TRY_TO_DECIMAL(NULLIF(TRIM(payload:amount::VARCHAR),''), 18, 2) AS invoice_amount,
        TRY_TO_DECIMAL(NULLIF(TRIM(payload:paid_amount::VARCHAR),''), 18, 2) AS invoice_paid_amount,
        TRY_TO_DECIMAL(NULLIF(TRIM(payload:remaining_amount::VARCHAR),''), 18, 2) AS invoice_remaining_amount,
        LOWER(NULLIF(TRIM(payload:status::VARCHAR),'')) AS invoice_status,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:issued_at::VARCHAR),'')) AS invoice_issued_at,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:due_at::VARCHAR),'')) AS invoice_due_at,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:paid_at::VARCHAR),'')) AS invoice_paid_at,        
        _source_file AS source_file,
        loaded_at AS raw_loaded_at
    FROM source
)

SELECT * FROM staged;