/*
-----------------------------
ELIST ANALYSIS -- SQL QUERIES
-----------------------------
*/

-- 1A) What were the order counts, sales, and AOV for Macbooks sold in North America for each quarter across all years? 
-- 1B) What is the average quarterly order count and total sales for Macbooks sold in North America?
WITH quarterly_results AS (
SELECT date_trunc(o.purchase_ts, quarter) AS purchase_quarter,
  o.product_name AS name,
  COUNT(distinct o.id) AS order_count,
  round(sum(o.usd_price),2) AS total_sales,
  round(avg(o.usd_price),2) AS aov
FROM core.orders o
LEFT JOIN core.customers c
  ON o.customer_id = c.id
LEFT JOIN core.geo_lookup g
  ON c.country_code = g.country_code
WHERE lower(o.product_name) like '%macbook%'
	AND region = 'NA'
GROUP BY 1,2
ORDER BY 1 DESC;
)

SELECT AVG(total_sales) AS avg_quarter_sales,
  AVG(order_count) AS avg_quarter_orders
FROM quarterly_results;

-- 2) For products purchased in 2022 on the website or products purchased on mobile in any year, which region has the average highest time to deliver? 
-- Clarifying Questions: 
-- is time to deliver calculated delivery ts - purchase ts?
-- do you only want 2022 for website and all years for mobile?
SELECT date_trunc(os.purchase_ts, year) AS year,
  ROUND(AVG(date_diff(os.delivery_ts, os.purchase_ts, day)),2) AS avg_time_to_deliver,
  o.purchase_platform AS platform,
  g.region AS region
FROM core.order_status os
LEFT JOIN core.orders o
ON os.order_id = o.id
LEFT JOIN core.customers c
ON c.id = o.customer_id
LEFT JOIN core.geo_lookup g
ON c.country_code = g.country_code
WHERE (extract(year FROM os.purchase_ts) = 2022 AND o.purchase_platform = 'website') OR (o.purchase_platform = 'mobile app')
GROUP BY 1,3,4
ORDER BY 2 DESC;


-- 3) What was the refund rate and refund count for each product overall? 
SELECT INITCAP(REPLACE(o.product_name, '"','')) AS name,
  SUM(CASE WHEN os.refund_ts IS NOT NULL THEN 1 ELSE 0 END) AS refund_count,
  ROUND(AVG(CASE WHEN os.refund_ts IS NOT NULL THEN 1 ELSE 0 END)*100, 4) AS refund_rate
FROM core.orders o
LEFT JOIN core.order_status os
  ON os.order_id = o.id
GROUP BY 1
ORDER BY 3 DESC;


-- 4) Within each region, what is the most popular product?
-- Clarifying question: is popularity based on sales or count sold?
WITH region_totals AS (
SELECT INITCAP(REPLACE(o.product_name, '"','')) AS product,
  g.region AS region,
  COUNT(o.id) AS orders,
  ROW_NUMBER() OVER (PARTITION BY g.region ORDER BY COUNT(o.id) DESC) AS ranking
FROM core.orders o
LEFT JOIN core.customers c
  ON o.customer_id = c.id
LEFT JOIN core.geo_lookup g 
  ON c.country_code = g.country_code
GROUP BY 1,2
ORDER BY 2,3 DESC
)

SELECT *
FROM region_totals
WHERE ranking = 1
GROUP BY 1,2,3,4
ORDER BY 2;

-- 5) How does the time to make a purchase differ between loyalty customers vs. non-loyalty customers? 
--    Split the time to purchase per loyalty program, per purchase platform. Return the number of records to benchmark the severity of nulls.
SELECT o.purchase_platform AS platform,
  c.loyalty_program AS is_loyal,
  ROUND(AVG(DATE_DIFF(o.purchase_ts,c.created_on,day)),1) AS days_purchase_time,
  ROUND(AVG(DATE_DIFF(o.purchase_ts,c.created_on,month)),1) AS month_purchase_time,
  COUNT(*) AS row_count
FROM core.customers c
LEFT JOIN core.orders o
  ON c.id = o.customer_id
GROUP BY 1,2;
