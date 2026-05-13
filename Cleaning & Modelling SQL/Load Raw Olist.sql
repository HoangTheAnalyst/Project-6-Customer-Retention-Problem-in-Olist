--Create & Use Database

DROP DATABASE IF EXISTS olist;
CREATE DATABASE IF NOT EXISTS olist;

USE olist;

--Create Raw Tables
CREATE TABLE IF NOT EXISTS raw_customers (
    customer_id VARCHAR(255),
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix VARCHAR(255),
    customer_city VARCHAR(255),
    customer_state VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS raw_geolocation (
    geolocation_zip_code_prefix VARCHAR(255),
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS raw_order_items (
    order_id VARCHAR(255),
    order_item_id INT,
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    shipping_limit_date VARCHAR(255),
    price FLOAT,
    freight_value FLOAT
);

CREATE TABLE IF NOT EXISTS raw_payments (
    order_id VARCHAR(255),
    payment_sequential INT,
    payment_type VARCHAR(255),
    payment_installments INT,
    payment_value FLOAT
);

CREATE TABLE IF NOT EXISTS raw_reviews (
    review_id VARCHAR(255),
    order_id VARCHAR(255),
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date VARCHAR(255),
    review_answer_timestamp VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS raw_orders (
    order_id VARCHAR(255),
    customer_id VARCHAR(255),
    order_status VARCHAR(255),
    order_purchase_timestamp VARCHAR(255),
    order_approved_at VARCHAR(255),
    order_delivered_carrier_date VARCHAR(255),
    order_delivered_customer_date VARCHAR(255),
    order_estimated_delivery_date VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS raw_products (
    product_id VARCHAR(255),
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT
);

CREATE TABLE IF NOT EXISTS raw_sellers (
    seller_id VARCHAR(255),
    seller_zip_code_prefix VARCHAR(255),
    seller_city VARCHAR(255),
    seller_state VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS raw_category_translations (
    product_category_name VARCHAR(255),
    product_category_name_english VARCHAR(255)
);

--Load Data into Raw Tables
SET GLOBAL local_infile = 1;


LOAD DATA LOCAL INFILE "E:/DA/DA/SQL - Sales E - Commerce/Dataset/olist_customers_dataset.csv"
INTO TABLE raw_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "E:/DA/DA/SQL - Sales E - Commerce/Dataset/olist_geolocation_dataset.csv"
INTO TABLE raw_geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "E:/DA/DA/SQL - Sales E - Commerce/Dataset/olist_order_items_dataset.csv"
INTO TABLE raw_order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "E:/DA/DA/SQL - Sales E - Commerce/Dataset/olist_order_payments_dataset.csv"
INTO TABLE raw_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "E:/DA/DA/SQL - Sales E - Commerce/Dataset/olist_order_reviews_dataset.csv"
INTO TABLE raw_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "E:/DA/DA/SQL - Sales E - Commerce/Dataset/olist_orders_dataset.csv"
INTO TABLE raw_orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "E:/DA/DA/SQL - Sales E - Commerce/Dataset/olist_products_dataset.csv"
INTO TABLE raw_products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "E:/DA/DA/SQL - Sales E - Commerce/Dataset/olist_sellers_dataset.csv"
INTO TABLE raw_sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "E:/DA/DA/SQL - Sales E - Commerce/Dataset/product_category_name_translation.csv"
INTO TABLE raw_category_translations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
