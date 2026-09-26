/* ==================================================================================
   Northstar Deployment Validation
   Purpose: Verify infrastructure, grants, raw loads, and VARIANT payload strucuture.
   Read-only validation queries.
   ================================================================================== */

-- Infrastructure Validation
USE ROLE SYSADMIN;
SHOW WAREHOUSES LIKE 'TRANSFORM_WH';
SHOW DATABASES LIKE 'NORTHSTAR_DB';
SHOW SCHEMAS IN DATABASE NORTHSTAR_DB;

-- Check row counts by source file and validate VARIANT payload structure
USE WAREHOUSE TRANSFORM_WH;
USE DATABASE NORTHSTAR_DB;
USE SCHEMA RAW;

SELECT 
    'ACCOUNTS' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM ACCOUNTS
GROUP BY _source_file

UNION ALL

SELECT 
    'INVOICES' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM INVOICES
GROUP BY _source_file

UNION ALL

SELECT
    'PAYMENT_ATTEMPTS' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM PAYMENT_ATTEMPTS
GROUP BY _source_file

UNION ALL

SELECT 
    'PLANS' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM PLANS
GROUP BY _source_file

UNION ALL

SELECT 
    'SUBSCRIPTIONS' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM SUBSCRIPTIONS
GROUP BY _source_file

UNION ALL

SELECT 
    'SUBSCRIPTION_HISTORY' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM SUBSCRIPTION_HISTORY
GROUP BY _source_file

UNION ALL

SELECT 
    'SUPPORT_TICKETS' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM SUPPORT_TICKETS
GROUP BY _source_file

UNION ALL

SELECT 
    'USERS' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM USERS
GROUP BY _source_file

UNION ALL

SELECT
    'WORKSPACES' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM WORKSPACES
GROUP BY _source_file

UNION ALL

SELECT 
    'WORKSPACE_MEMBERSHIPS' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM WORKSPACE_MEMBERSHIPS
GROUP BY _source_file

UNION ALL

SELECT 
    'PRODUCT_EVENTS' AS table_name,
    _source_file,
    COUNT(*) AS row_count,
    COUNT_IF(payload IS NULL) as null_payloads,
    COUNT_IF(payload IS NOT NULL AND NOT IS_OBJECT(payload)) as non_object_payloads
FROM PRODUCT_EVENTS
GROUP BY _source_file;


-- Validate dbt security grants
USE ROLE SECURITYADMIN;
SHOW GRANTS TO ROLE DBT_ROLE;
SHOW GRANTS TO USER DBT_USER;

