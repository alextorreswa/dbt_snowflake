with contacts as (
     select * from {{ ref('stg_hubspot_companies') }}
 ), customers as (
     select * from {{ ref('stg_rds_companies') }} 
 ),
  merged_companies as (
    SELECT 
    company_id as hubspot_company_id,
    null as rds_company_id,
    business_name
     FROM stg_hubspot_companies
    union all 
    SELECT 
    null as hubspot_company_id,
    company_id as rds_company_id,
    company_name as business_name
    FROM stg_rds_companies
 ), final as (
     select 
     max(hubspot_company_id) as hubspot_company_id, max(rds_company_id) as rds_company_id,
        business_name  
     from merged_companies
      group by business_name
 )  select {{ dbt_utils.surrogate_key(['business_name']) }} as company_pk, hubspot_company_id, rds_company_id,
  business_name from final 