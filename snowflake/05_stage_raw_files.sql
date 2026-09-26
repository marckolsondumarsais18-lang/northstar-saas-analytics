/* ============================================================================
   Northstar Raw File Upload
   Purpose: Upload local CSV files to the internal Snowflake stage.
   ============================================================================ */

   -- Replace <LOCAL_PROJECT_ROOT> with the actual path to your local project root directory
   PUT 'file://<LOCAL_PROJECT_ROOT>/data/raw/account.csv' 
    @NORTHSTAR_RAW_STAGE
    AUTO_COMPRESS = TRUE
    OVERWRITE = FALSE;


