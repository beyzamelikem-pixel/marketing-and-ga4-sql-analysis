/* MISSION 2 & 3: GA4 E-Commerce Conversion Funnel Analysis
   - Source/Medium tracking via traffic_source
   - Event filtering & CTE optimization
   - Conversion Rate calculations (SAFE_DIVIDE)
*/

WITH events AS (
    SELECT
        user_pseudo_id,
        event_name,
        traffic_source.source AS source,
        traffic_source.medium AS medium,
        traffic_source.name AS campaign
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    WHERE event_name IN ('session_start', 'add_to_cart', 'begin_checkout', 'purchase')
),

funnel_counts AS (
    SELECT
        source,
        medium,
        campaign,
        COUNT(DISTINCT CASE WHEN event_name = 'session_start' THEN user_pseudo_id END) AS total_sessions,
        COUNT(DISTINCT CASE WHEN event_name = 'add_to_cart' THEN user_pseudo_id END) AS users_added_to_cart,
        COUNT(DISTINCT CASE WHEN event_name = 'begin_checkout' THEN user_pseudo_id END) AS users_reached_checkout,
        COUNT(DISTINCT CASE WHEN event_name = 'purchase' THEN user_pseudo_id END) AS users_purchased
    FROM events
    GROUP BY 1, 2, 3
)

SELECT
    source,
    medium,
    campaign,
    total_sessions,
    users_added_to_cart,
    users_purchased,
    -- Visit to Purchase Conversion Rate
    SAFE_DIVIDE(users_purchased, total_sessions) AS visit_to_purchase_rate,
    -- Visit to Cart Conversion Rate
    SAFE_DIVIDE(users_added_to_cart, total_sessions) AS visit_to_cart_rate
FROM funnel_counts
WHERE total_sessions > 0
ORDER BY users_purchased DESC;
