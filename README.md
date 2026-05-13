# Customer Retention Problem in Olist

## Tech Stack
MySQL, Power BI

## Overview
This project analyzes customer retention challenges and revenue performance for Olist, a Brazilian e-commerce enabler connecting sellers with multiple online marketplaces. The analysis examines customer behavior, logistics operations, and product category performance to understand the root causes of extremely low customer retention despite strong revenue growth.

---

## 🔗 Preview Dashboard
- [Overview Dashboard](Images/Overview.png)

---

## 🔗 Interactive Dashboard
[View on Power BI Service](https://app.powerbi.com/links/nkyBPPfJvm?ctid=7212a37c-41a9-4402-9f69-ac32c6f76e1a&pbi_source=linkShare)

---

## 📋 Business Problem & Objectives

### Problem
Olist experienced strong revenue growth between 2016 and 2018, especially after the 2017 Black Friday period. However, customer retention remained extremely low across almost all product categories, raising concerns about long-term customer loyalty and platform sustainability.

### Objectives
This project aims to analyze revenue performance, customer behavior, and logistics operations through:
- Overview analysis of revenue, orders, delivery performance, and product categories
- Customer Journey Analysis from purchasing, freight cost, delivery process, to product reviews to identify the root causes behind the low retention rate

---

## 🎯 Business Questions

- How did revenue and customer purchasing behavior change over time?
- Were product categories the main reason for low customer retention?
- Did logistics factors such as freight cost, lead time, and delivery delays affect low customer retention?

---

## 📊 Dataset & Assumptions

### Dataset Information
- **Source:** [Kaggle - Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Time Period:** 2016–2018
- **Business Type:** Brazilian e-commerce enabler connecting sellers with multiple online marketplaces
- **Tables Included:** Orders, Order Items, Products, Customers, Sellers, Reviews, Payments & Geolocation

### Data Assumptions
- Revenue is calculated as the sum of Product Price and Freight Value for all delivered order items
- Only orders with "Delivered" status and complete delivery timestamps are included in revenue analysis
- All valid customers, sellers, and deliveries must be located within Brazil
- City and state names have been standardized; invalid delivery timelines removed
- Geolocation records are consistent and validated

---

## 🔧 Key Steps Taken

- **Cleaning**: Standardized city and state names, removed invalid delivery timelines, and filtered inconsistent geolocation records using MySQL.
- **Transformation**: Aggregated Payments and Reviews into the Orders table and created dimensional tables for date and geolocation analysis.
- **Modeling**: Built fact and dimension tables to support customer journey and logistics analytics.
- **Dashboard**: Developed two Power BI dashboards: Overview and Customer Journey Analysis.

---

## 💡 Key Insights

- When Revenue increase steadily over time, Customer retention was extremely low at only 3%.
- Top products were highly diversified, ranging from one-time purchase items such as Bed & Bath products to high-repeat categories like Health & Beauty. Nevertheless, even repeat-potential categories like Health & Beauty and cross-buy categories like Housewares recorded retention rates of only 2.75% and 2.47%, despite generating thousands of orders.
- Average delivery lead time reached 12.5 days, up to 40 days in P95 in February & March 2018.
- Repeat customers had slightly higher freight ratios (2% more) and delivery delays (0.25 days less), while also giving more positive ratings (0.6 stars). However, these differences were not significant enough to explain retention performance across the platform.

---

## 📈 Implications

- Despite strong revenue growth, Olist is facing a structural retention problem, with only ~3% of customers returning. This indicates that growth is being driven mainly by acquisition rather than loyalty. Product mix and logistics performance (lead time, freight, delivery variability) do not fully explain the issue, as even repeat-friendly categories show extremely low retention.
- If this is not addressed, Olist risks becoming a "transactional platform" with high order volume but no sustainable customer base, leading to rising acquisition costs and weakening long-term profitability.

---

## 🚀 Recommendations

- Introduce guaranteed delivery windows for key product categories, with compensation mechanisms (e.g., shipping fee refund or vouchers) in case of failure, to reduce perceived delivery uncertainty.
- Implement seller tiering based on delivery performance (on-time rate, cancellation rate, delay variance) to improve product ranking transparency and reduce customer expectation mismatch.
- Improve logistics reliability by reducing long-tail delivery delays through regional shipment pooling and prioritization of high-performing logistics partners, minimizing extreme delivery time variance.
- Encourage sellers to build their own brand identities on the platform, rather than competing purely on price, to improve customer trust and long-term retention.

---

## 📝 Project Structure

```
Project 6 - Customer Retention Rate in Olist
├── README.md
├── Cleaning & Modelling SQL/
│   ├── Cleaning Olist.sql
│   ├── Create Dim & Fact Olist.sql
│   ├── Create Stagging Olist.sql
│   ├── Delete Orphan Records From Tables.sql
│   └── Load Raw Olist.sql
├── Dashboard/
│   ├── Overview Dashboard
│   └── Customer Journey Analysis Dashboard
├── Dataset/
│   ├── olist_customers_dataset.csv
│   ├── olist_geolocation_dataset.csv
│   ├── olist_order_items_dataset.csv
│   ├── olist_order_payments_dataset.csv
│   ├── olist_order_reviews_dataset.csv
│   ├── olist_orders_dataset.csv
│   ├── olist_products_dataset.csv
│   ├── olist_sellers_dataset.csv
│   └── product_category_name_translation.csv
├── Images/
└── README in DOCX/
```

---

**Last Updated:** May 2026
