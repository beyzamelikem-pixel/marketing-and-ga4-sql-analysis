WITH combined_data AS (
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
  
   UNION ALL
  
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
active_days AS (
   SELECT DISTINCT
       adset_name,
       ad_date
   FROM combined_data
   WHERE spend > 0
),
streak_groups AS (
   SELECT
       adset_name,
       ad_date,
       ad_date - (ROW_NUMBER() OVER (PARTITION BY adset_name ORDER BY ad_date) * INTERVAL '1 day') AS grp
   FROM active_days
)
SELECT
   adset_name,
   MIN(ad_date) AS streak_start,
   MAX(ad_date) AS streak_end,
   COUNT(*) AS streak_length
FROM streak_groups
GROUP BY adset_name, grp
ORDER BY streak_length DESC;