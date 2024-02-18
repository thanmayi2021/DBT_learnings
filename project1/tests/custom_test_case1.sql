{{ config(severity='warn')}}

WITH order_details AS(
    SELECT
        product_id,
        COUNT(*) AS num_of_products
    FROM {{ref('stg_ecommerce__order_items')}}
    GROUP BY 1
)
SELECT
    p.*,
    od.*
FROM {{ ref('stg_ecommerce__products')}} AS p 
FULL OUTER JOIN order_details AS od USING(product_id)
WHERE
    -- All orders should have at least 1 item and every item should tie to an order
    p.product_id IS NULL
    OR od.product_id IS NULL#
    OR p.retail_price <=2