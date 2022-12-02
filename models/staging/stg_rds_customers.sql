WITH source as (
    SELECT * FROM "FIVETRAN_DATABASE"."POSTGRES_NORTHWINDS_RDS_PUBLIC"."CUSTOMERS"
),
renamed as (
    SELECT CUSTOMER_ID, COUNTRY, 
    SPLIT_PART(CONTACT_NAME, ' ', 1) as first_name,
    SPLIT_PART(CONTACT_NAME, ' ', -1) as last_name
    FROM source
)
SELECT * FROM renamed
