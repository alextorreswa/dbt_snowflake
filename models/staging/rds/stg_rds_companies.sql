WITH source as (
    SELECT * FROM {{ source('rds', 'customers') }} 
),
renamed as (
    SELECT concat('rds-',replace(lower(company_name), ' ', '-')) as company_id, company_name
    FROM source
    GROUP BY company_name    
)
SELECT * FROM renamed