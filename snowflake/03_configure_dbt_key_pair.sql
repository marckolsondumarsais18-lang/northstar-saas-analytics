/*  ==========================================================================
    Northstar dbt Security Setup
    Purpose: Register the dbt public key for key-pair authentication
    ========================================================================== */

-- Assign the public key to dbt_user
USE ROLE USERADMIN;

ALTER USER DBT_USER 
    ADD KEY PAIR DBT_PUBLIC_KEY
    PUBLIC_KEY = 'PASTE_BASE64_PUBLIC_KEY_HERE';