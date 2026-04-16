{{ config(materialized='table') }}
with source as (

    select * from {{ source('e_commerce_1', 'product_category_name_translation') }}

),

renamed as (

    select
        product_category,
        product_category_name_english

    from source

)

select * from renamed

