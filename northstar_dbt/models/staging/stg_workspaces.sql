WITH
source AS (
        SELECT * FROM {{ source('northstar_raw', 'workspaces') }}
),
staged AS (
    SELECT
        NULLIF(TRIM(payload:workspace_id::VARCHAR), '') AS workspace_id,
        NULLIF(TRIM(payload:account_id::VARCHAR), '') AS account_id,
        LOWER(NULLIF(TRIM(payload:status::VARCHAR), '')) AS workspace_status,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:activated_at::VARCHAR), '')) AS workspace_activated_at,
        _source_file AS source_file,
        loaded_at AS raw_loaded_at
    FROM source
)
SELECT * FROM staged;