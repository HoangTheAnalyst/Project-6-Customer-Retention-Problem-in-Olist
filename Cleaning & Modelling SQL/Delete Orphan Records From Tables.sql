--delete orphan records from staging_customers from staging_geolocation_aggregates

DELETE FROM staging_customers
WHERE NOT EXISTS (SELECT geolocation_zip_code_prefix FROM staging_geolocation_aggregates WHERE staging_customers.customer_zip_code_prefix = staging_geolocation_aggregates.geolocation_zip_code_prefix);

--delete orphan records from staging_sellers from staging_geolocation_aggregates

DELETE FROM staging_sellers
WHERE NOT EXISTS (SELECT geolocation_zip_code_prefix FROM staging_geolocation_aggregates WHERE staging_sellers.seller_zip_code_prefix = staging_geolocation_aggregates.geolocation_zip_code_prefix);


--delete orphan records from staging_orders from staging_customers
DELETE FROM staging_orders
WHERE NOT EXISTS (SELECT customer_id FROM staging_customers WHERE staging_orders.customer_id = staging_customers.customer_id);

--delete orphan records from staging_order_items from staging_orders, staging_products and staging_sellers

DELETE FROM staging_order_items
WHERE NOT EXISTS (SELECT order_id FROM staging_orders WHERE staging_order_items.order_id = staging_orders.order_id)
OR NOT EXISTS (SELECT product_id FROM staging_products WHERE staging_order_items.product_id = staging_products.product_id)
OR NOT EXISTS (SELECT seller_id FROM staging_sellers WHERE staging_order_items.seller_id = staging_sellers.seller_id);
