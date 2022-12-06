with contacts as (
     select * from {{ ref('stg_hubspot_contacts') }}
 ), customers as (
     select * from {{ ref('stg_rds_customers') }} 
 ),
  merged_contacts as (
    SELECT 
    contact_id as hubspot_contact_id,
    null as rds_contact_id,
    first_name, 
    last_name,
    phone, 
    company_id as hubspot_company_id,
    null as rds_company_id
     FROM stg_hubspot_contacts
    union all 
    SELECT 
    null as hubspot_contact_id,
    customer_id as rds_contact_id,
    first_name, 
    last_name,
    phone, 
    null as hubspot_company_id,
    company_id as rds_company_id
    FROM stg_rds_customers
 ) 
 select * from merged_contacts;