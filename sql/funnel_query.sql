-- Query ini digunakan untuk mengambil data dari BigQuery sandbox
-- Dataset: bigquery-public-data.ga4_obfuscated_sample_ecommerce
-- Periode: 2021-01-01 sampai 2021-01-31

SELECT
  event_date,
  user_pseudo_id,
  device.category AS device_type,
  traffic_source.source AS traffic_source,

  SUM(CASE WHEN event_name = 'page_view' THEN 1 ELSE 0 END) AS page_views,
  SUM(CASE WHEN event_name = 'view_item' THEN 1 ELSE 0 END) AS product_views,
  SUM(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS carts,
  SUM(CASE WHEN event_name = 'begin_checkout' THEN 1 ELSE 0 END) AS checkouts,
  SUM(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchases,

  MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased_flag

FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210131'

GROUP BY
  event_date,
  user_pseudo_id,
  device_type,
  traffic_source