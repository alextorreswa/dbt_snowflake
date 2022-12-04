WITH source as (
    SELECT * FROM {{ source('hubspot', 'contacts') }} 
),
stg_hubspot_companies as (
    SELECT * FROM {{ ref('stg_hubspot_companies') }}
), 
renamed as (
    SELECT CONCAT('hubspot-', id) as contact_id, first_name, last_name, PHONE, business_name
    FROM source
)
SELECT *, company_id FROM renamed
JOIN stg_hubspot_companies ON stg_hubspot_companies.business_name = renamed.business_name


