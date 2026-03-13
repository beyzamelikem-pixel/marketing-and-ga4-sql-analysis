WITH facebook_data AS (
   SELECT
       d.ad_date,
       'Facebook' AS media_source,
       c.campaign_name,
       s.adset_name,   
       d.spend,
       d.impressions,
       d.clicks,
       d.value
   FROM facebook_ads_basic_daily d
   LEFT JOIN facebook_adset s ON d.adset_id = s.adset_id
   LEFT JOIN facebook_campaign c ON d.campaign_id = c.campaign_id
),
google_data AS (
   SELECT
       ad_date,
       'Google' AS media_source,
       campaign_name,
       adset_name,  
       spend,
       impressions,
       clicks,
       value
   FROM google_ads_basic_daily
),
combined_data AS (
   SELECT * FROM facebook_data
   UNION ALL
   SELECT * FROM google_data
)
SELECT
   ad_date,
   media_source,
   AVG(spend) AS avg_spend,
   MAX(spend) AS max_spend,
   MIN(spend) AS min_spend
FROM combined_data
GROUP BY 1, 2
ORDER BY ad_date DESC;