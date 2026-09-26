/* =================================================================================
   Northstar Load Raw Files
   Purpose: Load staged files into raw tables using COPY INTO statements.
   ================================================================================= */

-- Role context
USE ROLE SYSADMIN;
USE WAREHOUSE TRANSFORM_WH;
USE DATABASE NORTHSTAR_DB;
USE SCHEMA RAW;

-- 1. Load accounts
COPY INTO ACCOUNTS (payload, _source_file)
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'account_id', $1,
                'name',       $2,
                'country',    $3,
                'industry',   $4,
                'status',     $5,
                'created_at', $6,
                'updated_at', $7
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/account.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 2. Load invoices
COPY INTO INVOICES (payload, _source_file)
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'invoice_id',      $1,
                'account_id',      $2,
                'subscription_id', $3,
                'issued_at',       $4,
                'due_at',          $5,
                'amount',          $6,
                'status',          $7,
                'paid_amount',     $8,
                'remaining_amount',$9
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/invoices.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 3. Load payment attempts 
COPY INTO PAYMENT_ATTEMPTS (payload, _source_file)
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'payment_attempt_id', $1,
                'account_id',         $2,
                'invoice_id',         $3,
                'occurred_at',        $4,
                'method',             $5,
                'status',             $6,
                'attempted_amount',   $7,
                'captured_amount',    $8,
                'failure_reason',     $9
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/payment_attempt.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 4. Load plans 
COPY INTO PLANS (payload, _source_file)
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'plan_id',           $1,
                'name',              $2,
                'tier',              $3,
                'price',             $4,
                'billing_frequency', $5,
                'status',            $6,
                'rank',              $7,
                'created_at',        $8
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/plan.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 5. Load subscriptions 
COPY INTO SUBSCRIPTIONS (payload, _source_file)
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'subscription_id', $1,
                'account_id',      $2,
                'plan_id',         $3, 
                'status',          $4,
                'start_date',      $5,
                'end_date',        $6,
                'seats_count',     $7,
                'change_type',     $8
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/subscriptions.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 6. Load subscription history 
COPY INTO SUBSCRIPTION_HISTORY (payload, _source_file)
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'subscription_history_id',      $1,
                'subscription_id',              $2,
                'account_id',                   $3,
                'plan_id',                      $4,
                'status',                       $5,
                'effective_from',               $6,
                'effective_to',                 $7,
                'seats_count',                  $8,
                'change_type',                  $9
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/subscription_history.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 7. Load support tickets
COPY INTO SUPPORT_TICKETS (payload, _source_file)
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'ticket_id',            $1,
                'account_id',           $2,
                'workspace_id',         $3,
                'user_id',              $4,
                'created_at',           $5,
                'category',             $6,
                'status',               $7,
                'channel',              $8,
                'satisfaction_score',   $9
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/support_ticket.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 8. Load users
COPY INTO USERS (payload, _source_file)
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'user_id',       $1,
                'account_id',    $2,
                'status',        $3,
                'role',          $4,
                'created_at',    $5,
                'last_seen_at',  $6
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/user.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 9. Load workspaces
COPY INTO WORKSPACES (payload, _source_file)
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'workspace_id',  $1,
                'account_id',    $2,
                'activated_at',  $3,
                'status',        $4
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/workspace.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 10. Load workspace memberships
COPY INTO WORKSPACE_MEMBERSHIPS (payload, _source_file) 
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'membership_id',    $1,
                'workspace_id',     $2,
                'user_id',          $3,
                'joined_at',        $4,
                'left_at',          $5,
                'role',             $6,
                'status',           $7
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE/workspace_membership.csv.gz
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    ON_ERROR = 'SKIP_FILE';

-- 11. Load product events 
COPY INTO PRODUCT_EVENTS (payload, _source_file) 
    FROM (
        SELECT
            OBJECT_CONSTRUCT(
                'event_id',     $1,
                'account_id',   $2,
                'workspace_id', $3,
                'user_id',      $4,
                'name',         $5,
                'feature',      $6,
                'occurred_at',  $7,
                'recorded_at',  $8,
                'session',      $9,
                'test_flag',    $10
            )::VARIANT AS payload,
            METADATA$FILENAME AS _source_file
        FROM @NORTHSTAR_RAW_STAGE
    )
    FILE_FORMAT = (FORMAT_NAME = NORTHSTAR_CSV_FILE_FORMAT)
    PATTERN = '.*product_event_.*\\.csv\\.gz'
    ON_ERROR = 'SKIP_FILE';