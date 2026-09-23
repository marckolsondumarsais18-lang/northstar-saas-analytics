/* ============================================================================
   Northstar Snowflake Foundation
   Purpose: Create the project warehouse, database, and schemas.
   ============================================================================ */

-- Role Context
   USE ROLE SYSADMIN;

-- Dedicated warehouse for dbt transformations and developement. 
CREATE WAREHOUSE IF NOT EXISTS TRANSFORM_WH
    WAREHOUSE_TYPE = STANDARD
    WAREHOUSE_SIZE = XSMALL
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Dedicated X-Small warehouse for Northstar dbt transformations and development';

-- Central database for Northstar analytical data. 
CREATE DATABASE IF NOT EXISTS NORTHSTAR_DB;

CREATE SCHEMA IF NOT EXISTS NORTHSTAR_DB.RAW
    COMMENT = 'Immutable landing zone for uncleaned operational source extracts';

CREATE SCHEMA IF NOT EXISTS NORTHSTAR_DB.ANALYTICS
    COMMENT = 'Modeled analytical layer built by dbt';
