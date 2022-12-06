WITH source as (
    SELECT * FROM {{ source('rds', 'customers') }} 
), 
stg_hubspot_companies as (
    SELECT * FROM {{ ref('stg_rds_companies') }}
), 
renamed as (
    SELECT CUSTOMER_ID, COUNTRY, 
    SPLIT_PART(CONTACT_NAME, ' ', 1) as first_name,
    SPLIT_PART(CONTACT_NAME, ' ', -1) as last_name,
    PHONE, COMPANY_NAME
    FROM source
)
SELECT CUSTOMER_ID, first_name, last_name, PHONE, company_id FROM renamed
JOIN stg_rds_companies ON stg_rds_companies.COMPANY_NAME = renamed.COMPANY_NAME
