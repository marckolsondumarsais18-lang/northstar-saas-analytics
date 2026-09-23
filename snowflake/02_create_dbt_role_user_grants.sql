/* ============================================================================
    Northstar dbt Security Setup
    Purpose: Create the dbt role and service user, then grant required access
   ============================================================================ */

--- Role context
USE ROLE USERADMIN;

-- Dedicated role for dbt transformations and data modeling
CREATE ROLE IF NOT EXISTS DBT_ROLE
    COMMENT = 'Dedicated role for dbt transformations and data modeling';

-- Grant Privileges to the dbt role
USE ROLE SECURITYADMIN;

-- Compute access
-- Allows the dbt role to execute SQL using the warehouse
-- Does not allow dbt to resize, alter, or drop the warehouse
GRANT USAGE 
    ON WAREHOUSE TRANSFORM_WH 
    TO ROLE DBT_ROLE;

-- Database access
-- Allows the dbt role to reference objects in the database
GRANT USAGE
    ON DATABASE NORTHSTAR_DB
    TO ROLE DBT_ROLE;

-- Grants visibility for current and future schemas
GRANT USAGE 
    ON ALL SCHEMAS IN DATABASE NORTHSTAR_DB 
    TO ROLE DBT_ROLE;

GRANT USAGE 
    ON FUTURE SCHEMAS IN DATABASE NORTHSTAR_DB 
    TO ROLE DBT_ROLE;

-- RAW: read-only source data
-- The dbt role can read existing and future source tables and views 
-- but cannot modify data in the RAW schema
GRANT SELECT 
    ON ALL TABLES IN SCHEMA NORTHSTAR_DB.RAW 
    TO ROLE DBT_ROLE;

GRANT SELECT 
    ON FUTURE TABLES IN SCHEMA NORTHSTAR_DB.RAW
    TO ROLE DBT_ROLE;

GRANT SELECT 
    ON ALL VIEWS IN SCHEMA NORTHSTAR_DB.RAW 
    TO ROLE DBT_ROLE;

GRANT SELECT
    ON FUTURE VIEWS IN SCHEMA NORTHSTAR_DB.RAW
    TO ROLE DBT_ROLE;

    
-- ANALYTICS: dbt-managed models
-- Allows dbt to create and manage models in the ANALYTICS schema
GRANT ALL PRIVILEGES
    ON SCHEMA NORTHSTAR_DB.ANALYTICS
    TO ROLE DBT_ROLE;

GRANT ALL PRIVILEGES 
    ON ALL TABLES IN SCHEMA NORTHSTAR_DB.ANALYTICS 
    TO ROLE DBT_ROLE;

GRANT ALL PRIVILEGES 
    ON FUTURE TABLES IN SCHEMA NORTHSTAR_DB.ANALYTICS 
    TO ROLE DBT_ROLE;

GRANT ALL PRIVILEGES
    ON ALL VIEWS IN SCHEMA NORTHSTAR_DB.ANALYTICS
    TO ROLE DBT_ROLE;

GRANT ALL PRIVILEGES
    ON FUTURE VIEWS IN SCHEMA NORTHSTAR_DB.ANALYTICS
    TO ROLE DBT_ROLE;
    

-- Role context
USE ROLE USERADMIN;

-- Dedicated service user for dbt
CREATE USER IF NOT EXISTS DBT_USER
TYPE = SERVICE
LOGIN_NAME = 'dbtusernorthstar'
DEFAULT_ROLE = DBT_ROLE
DEFAULT_WAREHOUSE = TRANSFORM_WH
COMMENT = 'Service user for all Northstar dbt operations'; 

-- Assign DBT_ROLE to DBT_USER

-- Role context
USE ROLE SECURITYADMIN;

GRANT ROLE DBT_ROLE 
    TO USER DBT_USER;


