/*
Here's the first-touch query, in case you need it
*/

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp;


1) How many campaigns and sources does CoolTShirts use? Which source is used for each campaign?

SELECT COUNT(DISTINCT utm_campaign) AS 'Number of Campaigns'
FROM page_visits;


SELECT COUNT(DISTINCT utm_source) AS 'Number of Sources'
FROM page_visits;


SELECT DISTINCT utm_campaign AS 'Campaign', utm_source AS 'Source'
FROM page_visits;
	

2) What pages are on the CoolTShirts website?

SELECT DISTINCT page_name AS 'Page Names'
FROM page_visits;

3) How many first touches is each campaign responsible for?

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign, pv.utm_source, COUNT(*)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 1;

4) How many last touches is each campaign responsible for?

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign, pv.utm_source, COUNT(*)
FROM last_touch AS lt
JOIN page_visits AS pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 1;

5) How many visitors make a purchase?

SELECT COUNT(DISTINCT user_id)
FROM page_visits
WHERE page_name IS '4 - purchase';

6) How many last touches on the purchase page is each campaign responsible for?

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
  	WHERE page_name IS '4 - purchase' 
    GROUP BY user_id)
SELECT pv.utm_campaign, pv.utm_source, COUNT(*)
FROM last_touch AS lt
JOIN page_visits AS pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 1;