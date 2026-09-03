-- Initial setup
USE CATALOG chinook;

-- Create data layer schemas
-- Raw layer: preserves source data into taw tables
CREATE SCHEMA IF NOT EXISTS chinook_raw;

-- Clean layer: cleaned and standardized data
CREATE SCHEMA IF NOT EXISTS chinook_clean;

-- Mart layer: business-ready dimensional/fact models
CREATE SCHEMA IF NOT EXISTS chinook_mart;

-- Visualization layer: datasets prepared for reporting and analysis
CREATE SCHEMA IF NOT EXISTS chinook_visualization;

-- Verify schemas
SHOW SCHEMAS;
