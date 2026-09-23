/*  ==========================================================================
    Northstar Raw Ingestion Objects
    Purpose: Create the CSV file format, internal stage, and VARIANT raw tables.
    ========================================================================== */

-- Role Context
USE ROLE SYSADMIN;
USE WAREHOUSE TRANSFORM_WH;
USE DATABASE NORTHSTAR_DB;
USE SCHEMA RAW;

-- Create the csv file format for the raw data
CREATE FILE FORMAT IF NOT EXISTS NORTHSTAR_CSV_FILE_FORMAT
  TYPE = 'CSV'
  FIELD_DELIMITER = ','
  RECORD_DELIMITER = '\n'
  SKIP_HEADER = 1;

-- Create the stage for the raw data
CREATE STAGE IF NOT EXISTS NORTHSTAR_RAW_STAGE
    FILE_FORMAT = NORTHSTAR_CSV_FILE_FORMAT;

-- Create the tables for the raw data
-- Account raw data table
CREATE TABLE IF NOT EXISTS ACCOUNTS (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- Invoice raw data table
CREATE TABLE IF NOT EXISTS INVOICES (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- Payment attempts raw data table
CREATE TABLE IF NOT EXISTS PAYMENT_ATTEMPTS (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- Plan raw data table
CREATE TABLE IF NOT EXISTS PLANS (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- Subscription raw data table
CREATE TABLE IF NOT EXISTS SUBSCRIPTIONS (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- Subscription history raw data table
CREATE TABLE IF NOT EXISTS SUBSCRIPTION_HISTORY (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- Support tickets raw data table
CREATE TABLE IF NOT EXISTS SUPPORT_TICKETS (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- User raw data table
CREATE TABLE IF NOT EXISTS USERS (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- Workspace raw data table
CREATE TABLE IF NOT EXISTS WORKSPACES (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- Workspace memberships raw data table
CREATE TABLE IF NOT EXISTS WORKSPACE_MEMBERSHIPS (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
-- Product events raw data table
CREATE TABLE IF NOT EXISTS PRODUCT_EVENTS (
    payload VARIANT,
    _source_file VARCHAR,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);





