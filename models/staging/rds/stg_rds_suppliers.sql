WITH source as (
    SELECT * FROM {{ source('rds', 'suppliers') }} 
),
renamed as (
    SELECT SUPPLIER_ID, COUNTRY, 
    SPLIT_PART(CONTACT_NAME, ' ', 1) as contact_first_name,
    SPLIT_PART(CONTACT_NAME, ' ', -1) as contact_last_name,    
    ADDRESS, CITY, PHONE, COMPANY_NAME, REGION, POSTAL_CODE, FAX, CONTACT_TITLE, HOMEPAGE
    FROM source
)
SELECT * FROM renamed