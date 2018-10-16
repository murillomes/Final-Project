# Final-Project
Codecademy - SQL From Scratch Final Project

Project: Attribution Queries

SELECT COUNT (DISTINCT utm_campaign)
FROM page_visits;

---------

SELECT COUNT (DISTINCT utm_source)
FROM page_visits;

---------

SELECT DISTINCT utm_source, utm_campaign
FROM page_visits
ORDER BY 1 ASC;

---------

SELECT DISTINCT page_name
FROM page_visits;

---------

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
   ft_attr AS (
     SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM first_touch AS 'ft'
  JOIN page_visits AS 'pv'
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source AS 'First Touch Source',
       ft_attr.utm_campaign AS 'First Touch Campaign',
       COUNT(*) AS 'Total'
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

---------

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign,
         pv.page_name
  FROM last_touch AS 'lt'
  JOIN page_visits AS 'pv'
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source AS 'Last Touch Source',
       lt_attr.utm_campaign AS 'Last Touch Campaign',
       COUNT(*) AS 'Total'
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

---------

SELECT page_name AS 'Page Name’, 
       COUNT (DISTINCT user_id) AS 'Total Users'
FROM page_visits
GROUP BY page_name;


OR

SELECT COUNT (DISTINCT user_id)
FROM page_visits
WHERE page_name = '4 - purchase';

---------

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign,
         pv.page_name
  FROM last_touch AS 'lt'
  JOIN page_visits AS 'pv'
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source AS 'LT Purchase Page Source',
       lt_attr.utm_campaign AS 'LT Purchase Page Campaign',
       COUNT(*) AS 'Total'
FROM lt_attr
WHERE page_name = '4 - purchase'
GROUP BY 1, 2
ORDER BY 3 DESC;
