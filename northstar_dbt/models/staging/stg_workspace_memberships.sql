WITH 
source AS (
    SELECT * FROM {{ source('northstar_raw', 'workspace_memberships') }}
),
staged AS (
    SELECT 
        NULLIF(TRIM(payload:membership_id::VARCHAR),'') AS membership_id,
        NULLIF(TRIM(payload:workspace_id::VARCHAR),'') AS workspace_id,
        NULLIF(TRIM(payload:user_id::VARCHAR),'') AS user_id,
        LOWER(NULLIF(TRIM(payload:role::VARCHAR),'')) AS membership_role,
        LOWER(NULLIF(TRIM(payload:status::VARCHAR),'')) AS membership_status,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:joined_at::VARCHAR),'')) AS membership_joined_at,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(TRIM(payload:left_at::VARCHAR),'')) AS membership_left_at,
        _source_file AS source_file,
        loaded_at AS raw_loaded_at
    FROM source
)
SELECT * FROM staged;