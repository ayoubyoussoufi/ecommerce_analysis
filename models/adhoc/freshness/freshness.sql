{{ config(alias='freshness', materialized='view') }}

{%- set adhoc_sales_analyis_ds = generate_schema_name('adhoc_sales_analyis') | trim -%}

SELECT
    project_id,
    dataset_id,
    'adhoc_sales_analysis' AS source,
    table_id,
    TIMESTAMP_MILLIS(last_modified_time) AS last_updated_time,
    DATETIME(TIMESTAMP_MILLIS(last_modified_time), 'Europe/Paris') AS last_updated_time_paris

FROM `{{ model.database }}.{{ adhoc_sales_analyis_ds }}.__TABLES__`

WHERE table_id = 'sales_analysis'