
--cleaning customers table
UPDATE staging_customers
SET customer_id = LOWER(TRIM(customer_id)),
    customer_unique_id = LOWER(TRIM(customer_unique_id)),
    customer_zip_code_prefix = TRIM(customer_zip_code_prefix),
    customer_city = LOWER(TRIM(customer_city)),
    customer_state = UPPER(TRIM(customer_state));


--cleaning geolocation table
UPDATE staging_geolocation
SET geolocation_zip_code_prefix = TRIM(geolocation_zip_code_prefix),
    geolocation_lat = CAST(geolocation_lat AS FLOAT),
    geolocation_lng = CAST(geolocation_lng AS FLOAT),
    geolocation_city = LOWER(TRIM(geolocation_city)),
    geolocation_state = UPPER(TRIM(geolocation_state));
DELETE FROM staging_geolocation
WHERE geolocation_lat > 5.27 OR geolocation_lat < -33.75 OR geolocation_lng > -34.79 OR geolocation_lng < -73.99;

UPDATE staging_geolocation
SET geolocation_city = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        LOWER(geolocation_city), 
    'ã', 'a'), 'á', 'a'), 'à', 'a'), 'â', 'a'),
    'é', 'e'), 'ê', 'e'),
    'í', 'i'),
    'ó', 'o'), 'õ', 'o'), 'ô', 'o'),
    'ú', 'u'),
    'ç', 'c'
);

UPDATE staging_geolocation
SET geolocation_city = 'rio de janeiro' WHERE geolocation_city = 'rio de janeiro, rio de janeiro';


--cleaning order_items table

SELECT * FROM staging_order_items;
UPDATE staging_order_items
SET order_id = LOWER(TRIM(order_id)),
    order_item_id = LOWER(TRIM(order_item_id)),
    product_id = LOWER(TRIM(product_id)),
    seller_id = LOWER(TRIM(seller_id)),
    shipping_limit_date = LOWER(TRIM(shipping_limit_date)),
    price = LOWER(TRIM(price)),
    freight_value = LOWER(TRIM(freight_value));

ALTER TABLE staging_order_items
ADD COLUMN total_price_items FLOAT
GENERATED ALWAYS AS (price + freight_value) STORED;

UPDATE staging_order_items
SET shipping_limit_date = DATE(shipping_limit_date);

--cleaning payments table
UPDATE staging_payments
SET order_id = LOWER(TRIM(order_id)),
    payment_sequential = LOWER(TRIM(payment_sequential)),
    payment_type = LOWER(TRIM(payment_type)),
    payment_installments = LOWER(TRIM(payment_installments)),
    payment_value = LOWER(TRIM(payment_value));


DELETE FROM staging_payments
WHERE payment_value <= 0 OR payment_type = 'not_defined';


--cleaning reviews table
UPDATE staging_reviews
SET review_id = LOWER(TRIM(review_id)),
    order_id = LOWER(TRIM(order_id)),
    review_score = LOWER(TRIM(review_score)),
    review_comment_title = LOWER(TRIM(review_comment_title)),
    review_comment_message = LOWER(TRIM(review_comment_message)),
    review_creation_date = LOWER(TRIM(review_creation_date)),
    review_answer_timestamp = LOWER(TRIM(review_answer_timestamp));


DELETE FROM staging_reviews
WHERE review_creation_date > review_answer_timestamp;


--cleaning orders table
UPDATE staging_orders
SET order_id = LOWER(TRIM(order_id)),
    customer_id = LOWER(TRIM(customer_id)),
    order_status = LOWER(TRIM(order_status)),
    order_purchase_timestamp = LOWER(TRIM(order_purchase_timestamp)),
    order_approved_at = LOWER(TRIM(order_approved_at)),
    order_delivered_carrier_date = LOWER(TRIM(order_delivered_carrier_date)),
    order_delivered_customer_date = LOWER(TRIM(order_delivered_customer_date)),
    order_estimated_delivery_date = LOWER(TRIM(order_estimated_delivery_date));


UPDATE staging_orders
SET order_purchase_timestamp = CASE WHEN order_purchase_timestamp = '' THEN NULL ELSE DATE(order_purchase_timestamp) END,
    order_approved_at = CASE WHEN order_approved_at = '' THEN NULL ELSE DATE(order_approved_at) END,
    order_delivered_carrier_date = CASE WHEN order_delivered_carrier_date = '' THEN NULL ELSE DATE(order_delivered_carrier_date) END,
    order_delivered_customer_date = CASE WHEN order_delivered_customer_date = '' THEN NULL ELSE DATE(order_delivered_customer_date) END,
    order_estimated_delivery_date = CASE WHEN order_estimated_delivery_date = '' THEN NULL ELSE DATE(order_estimated_delivery_date) END; 

DELETE FROM staging_orders
WHERE order_purchase_timestamp > order_approved_at OR order_approved_at > order_delivered_carrier_date OR order_delivered_carrier_date > order_delivered_customer_date;


--cleaning products table
UPDATE staging_products
SET product_id = LOWER(TRIM(product_id)),
    product_category_name = LOWER(TRIM(product_category_name)),
    product_name_length = LOWER(TRIM(product_name_length)),
    product_description_length = LOWER(TRIM(product_description_length)),
    product_photos_qty = LOWER(TRIM(product_photos_qty)),
    product_weight_g = LOWER(TRIM(product_weight_g)),
    product_length_cm = LOWER(TRIM(product_length_cm)),
    product_height_cm = LOWER(TRIM(product_height_cm)),
    product_width_cm = LOWER(TRIM(product_width_cm));

SELECT * FROM staging_products;

DELETE FROM staging_products
WHERE product_weight_g <= 0 
OR product_length_cm <= 0 
OR product_height_cm <= 0 
OR product_width_cm <= 0 
OR product_weight_g IS NULL 
OR product_length_cm IS NULL 
OR product_height_cm IS NULL 
OR product_width_cm IS NULL;

UPDATE staging_products sp 
JOIN staging_category_translations sct ON sp.product_category_name = sct.product_category_name
SET sp.product_category_name = sct.product_category_name_english;

--cleaning sellers table
UPDATE staging_sellers
SET seller_id = LOWER(TRIM(seller_id)),
    seller_zip_code_prefix = TRIM(seller_zip_code_prefix),
    seller_city = LOWER(TRIM(seller_city)),
    seller_state = UPPER(TRIM(seller_state));

