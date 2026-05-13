CREATE TABLE IF NOT EXISTS staging_customers LIKE raw_customers;

CREATE TABLE IF NOT EXISTS staging_geolocation LIKE raw_geolocation;

CREATE TABLE IF NOT EXISTS staging_order_items LIKE raw_order_items;

CREATE TABLE IF NOT EXISTS staging_payments LIKE raw_payments;

CREATE TABLE IF NOT EXISTS staging_reviews LIKE raw_reviews;

CREATE TABLE IF NOT EXISTS staging_orders LIKE raw_orders;

CREATE TABLE IF NOT EXISTS staging_products LIKE raw_products;

CREATE TABLE IF NOT EXISTS staging_sellers LIKE raw_sellers;

CREATE TABLE IF NOT EXISTS staging_category_translations LIKE raw_category_translations;

INSERT INTO staging_customers SELECT * FROM raw_customers;
INSERT INTO staging_geolocation SELECT * FROM raw_geolocation;
INSERT INTO staging_order_items SELECT * FROM raw_order_items;

INSERT INTO staging_payments SELECT * FROM raw_payments;
INSERT INTO staging_reviews SELECT * FROM raw_reviews;
INSERT INTO staging_orders SELECT * FROM raw_orders;
INSERT INTO staging_products SELECT * FROM raw_products;
INSERT INTO staging_sellers SELECT * FROM raw_sellers;
INSERT INTO staging_category_translations SELECT * FROM raw_category_translations;

