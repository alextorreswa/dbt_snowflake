WITH source as (
    SELECT * FROM {{ source('rds', 'customers') }} 
),
renamed as (
    SELECT CUSTOMER_ID, COUNTRY, 
    SPLIT_PART(CONTACT_NAME, ' ', 1) as first_name,
    SPLIT_PART(CONTACT_NAME, ' ', -1) as last_name
    FROM source
)
SELECT * FROM renamed
