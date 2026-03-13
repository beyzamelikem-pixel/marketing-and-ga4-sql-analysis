# 📊 Digital Marketing & E-Commerce Funnel Analysis with SQL

## 🎯 Project Overview
This project focuses on analyzing digital marketing campaigns (Facebook & Google Ads) and user conversion funnels using Google Analytics 4 (GA4) data. The goal is to evaluate marketing performance, calculate Return on Marketing Investment (ROMI), and identify conversion drop-offs in the e-commerce user journey.

## 🛠️ Tech Stack & Tools
* **Language:** SQL
* **Database:** Google BigQuery / PostgreSQL
* **Concepts Used:** Common Table Expressions (CTEs), Window Functions (`LAG`, `ROW_NUMBER`), Aggregate Functions, Data Unioning, Gaps and Islands Problem.

## 📂 Project Structure

### Part 1: Marketing Campaign Performance (SQL 1-5)
Merged dataset from `facebook_ads_basic_daily` and `google_ads_basic_daily` using `UNION ALL` and `JOIN`s to track cross-channel performance.

* **Overall Metrics:** Calculated Average, Minimum, and Maximum spend across different platforms.
* **ROMI Calculation:** Measured the Return on Marketing Investment to evaluate campaign profitability.
* **Weekly & Monthly Trends:** Used `DATE_TRUNC` and `LAG()` window functions to track monthly reach growth.
* **Campaign Streaks:** Solved the *Gaps and Islands* problem to find the longest uninterrupted active days for specific adsets.

### Part 2: GA4 E-Commerce Conversion Funnel
Extracted raw event data from the `ga4_obfuscated_sample_ecommerce` dataset to build a user journey funnel.

* Fixed attribution issues by pulling `source`, `medium`, and `campaign` directly from the `traffic_source` record instead of nested `event_params`.
* Filtered critical events (`session_start`, `add_to_cart`, `begin_checkout`, `purchase`).
* Calculated deep **Conversion Rates** (e.g., Visit-to-Cart, Visit-to-Purchase) using `SAFE_DIVIDE` to avoid division by zero and handle unengaged traffic.

## 💡 Key Takeaways & Skills Demonstrated
* Writing clean, readable, and highly optimized SQL queries using **CTEs**.
* Reducing query computing costs in BigQuery by applying early `WHERE` filters before aggregation.
* Handling real-world GA4 schemas and complex nested data structures.
