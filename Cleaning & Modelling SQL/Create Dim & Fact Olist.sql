--create staging_geolocation_aggregates table

CREATE TABLE staging_geolocation_aggregates AS
WITH ranked_geo AS (
    SELECT 
        geolocation_zip_code_prefix,
        geolocation_city,
        geolocation_state,
        AVG(geolocation_lat) as avg_lat,
        AVG(geolocation_lng) as avg_lng,
        COUNT(*) as frequency,
        ROW_NUMBER() OVER(
            PARTITION BY geolocation_zip_code_prefix 
            ORDER BY COUNT(*) DESC, geolocation_city ASC 
        ) as rn
    FROM staging_geolocation
    GROUP BY 1, 2, 3
)
SELECT 
    geolocation_zip_code_prefix,
    avg_lat,
    avg_lng,
    geolocation_city,
    geolocation_state
FROM ranked_geo
WHERE rn = 1;

-- create view fact_sales
DROP VIEW IF EXISTS fact_sales;

CREATE VIEW fact_sales AS
SELECT * FROM staging_order_items;





--create view dim_review
CREATE VIEW dim_review AS
SELECT order_id,
COUNT(review_id) AS total_reviews,
ROUND(AVG(review_score), 1) AS avg_review_score, 
MIN(DATE(review_creation_date)) AS min_review_creation_date, 
MIN(DATE(review_answer_timestamp)) AS min_review_answer_timestamp
FROM staging_reviews
GROUP BY order_id
ORDER BY avg_review_score DESC;


--create view dim_payment
DROP VIEW IF EXISTS dim_payment;
CREATE OR REPLACE VIEW dim_payment AS
WITH payment_counts AS (
    SELECT 
        order_id, 
        payment_type,
        COUNT(*) as occurrence_count,
        SUM(payment_value) as total_payment_value,
        MAX(payment_installments) as max_installments
    FROM staging_payments
    GROUP BY order_id, payment_type
),
ranked_payments AS (
    SELECT 
        *,
        ROW_NUMBER() OVER(
            PARTITION BY order_id 
            ORDER BY occurrence_count DESC, total_payment_value DESC
        ) as rn
    FROM payment_counts
)
SELECT 
    order_id,
    payment_type AS most_used_payment_type,
    total_payment_value,
    max_installments
FROM ranked_payments
WHERE rn = 1;
--create view dim_customers
CREATE VIEW dim_customers AS SELECT * FROM staging_customers;

--create view dim_geolocation
CREATE VIEW dim_geolocation AS SELECT * FROM staging_geolocation_aggregates;

--create view dim_products
CREATE VIEW dim_products AS SELECT * FROM staging_products;

--create view dim_sellers
CREATE VIEW dim_sellers AS SELECT * FROM staging_sellers;


SELECT * FROM staging_payments
WHERE order_id IN (SELECT order_id FROM staging_payments GROUP BY order_id HAVING COUNT(*) > 1)
ORDER BY order_id;

--create view dim_orders_reviews_payment

CREATE VIEW dim_orders_payments_reviews AS
SELECT o.*,
    p.most_used_payment_type,
    p.total_payment_value,
    p.max_installments,
    r.total_reviews,
    r.avg_review_score,
    r.min_review_creation_date,
    r.min_review_answer_timestamp     
FROM staging_orders o
LEFT JOIN dim_payment p ON o.order_id = p.order_id
LEFT JOIN dim_review r ON o.order_id = r.order_id;

