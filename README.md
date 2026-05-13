# Elist Sales Analysis

## Background
Founded in 2018, Elist is an e-commerce company that sells popular electronics products and has since expanded to a global customer base. Like most e-commerce companies, Elist sells products through their online site as well as through their mobile app. They use a variety of marketing channels to reach customers, including Email campaigns, SEO, and affiliate links. Over the last few years, their more popular products have been products from Apple, Samsung, and ThinkPad.

My job is to deliver insights to teams across the company, including finance, sales, product, and marketing. The focus of my work is to help these stakeholders understand Elist’s performance so they can improve their day-to-day processes and help the company deliver top-notch products to customers around the world. 

## The Data
The company has a core dataset consisting of orders, order statuses, customers, products, and geographic information. Their data is quite messy and contains plenty of insights that have not yet been discovered by the company. Before beginning the exploratory analysis, I cleaned the data by correcting for things like incosistent data format, inconsistent names for products, missing prices, missing marketing channels and region names.

The entity relationship diagram (ERD) is as follows: 

![ERD](https://github.com/collinaustin/Elist_Sales_Analysis/raw/main/Elist%20ERD.png)

## Summary of Insights

The SQL scripts can be found [here](https://github.com/collinaustin/Elist_Sales_Analysis/blob/main/sql_analysis.sql).

**Yearly Sales Trends**: From 2019 to 2022, Elist averaged roughly 27,000 orders per year, generating about $7M in annual revenue at an average order value (AOV) of $254. Sales grew at a 9% compounded annual growth rate (CAGR) over the period, though performance was highly volatile. 2020 was the standout year, with a roughly 3x surge in revenue driven by a combination of higher AOV and order count. That momentum partially carried into 2021, which saw the highest order volume despite a modest revenue decline caused by a 15% drop in AOV. 2022 marked a sharp reversal, with sales contracting 46% YoY and Q4 2022 representing the lowest quarterly performance across the entire four-year period.

![aov_vs_sales](https://github.com/collinaustin/Elist_Sales_Analysis/raw/main/aov_vs_sales_growth.png)

**Seasonality**: Q3 and Q4 were consistently the strongest quarters, with August, September, and December outperforming the monthly average. February and October were reliably the weakest months, averaging roughly 20% below the monthly baseline. The longest sustained expansion ran from Q3 2019 through Q4 2020, six consecutive quarters of growth, followed by five consecutive declining quarters from Q4 2021 through Q4 2022.

![sales index](https://github.com/collinaustin/Elist_Sales_Analysis/raw/main/monthly_sales_index.png)

**Product Performance**: Revenue concentration was a recurring theme. In 2020, three products (Macbook Air, 27in 4K Gaming Monitor, and Apple AirPods) accounted for 85% of the year's revenue increase. When those same products declined, there was no secondary tier to offset the losses: the Macbook Air dropped 35% in 2021, while the gaming monitor and AirPods both fell sharply in 2022, with the monitor alone accounting for roughly one-third of the total 2022 revenue decline. Fulfillment remained a consistent strength throughout, with average time-to-ship holding at 2 days and time-to-deliver at 5.5 days even during the 2020/2021 volume surge.

![individual product](https://github.com/collinaustin/Elist_Sales_Analysis/raw/main/individual_product.png)

**Regional Performance**: North American region (NA), and Europe, the Middle East, and Africa region (EMEA) together accounted for 81% of total sales, but both regions experienced significant declines in the back half of the period. NA was the single largest driver of revenue decline in both 2021 ($845K, 82% of total decline) and 2022 ($1.75M, 42% of total decline), while EMEA suffered the steepest percentage drop in 2022 ($1.4M, -51%), compounding the contraction. Asia-Pacific region (APAC), while third in total sales and order volume, posted the highest AOV in both the loyalty ($261) and non-loyal ($292) segments, suggesting a high-value but underpenetrated customer base. The Latin-America region (LATAM) was the weakest region across nearly all measures.

![regional](https://github.com/collinaustin/Elist_Sales_Analysis/raw/main/region_summary.png)

**Loyalty Program Performance**: The loyalty program, launched in 2019, underperformed the non-loyal segment in absolute terms over the full period: roughly $6M less in total sales, $34 lower AOV, and about 16K fewer orders. However, the growth trajectory told a different story. Loyalty sales grew at an 87% CAGR vs. -13.4% for non-loyal, order volume grew 76.9% vs. -11%, and AOV increased 5.7% vs. -2.7%. By 2021 and 2022, loyalty sales and order counts had surpassed the non-loyal segment. That said, the program has not yet shifted core customer behavior: loyal customers had lower repeat purchase rates (17% vs. 22%) and lower average revenue per customer ($294 vs. $343). Loyalty customers also showed notably higher mobile app adoption (24% vs. 12% for non-loyal). Early-period comparisons should be interpreted with caution, as the program launched with roughly 2K orders in 2019 compared to 15K for the non-loyal segment.

![loyalty](https://github.com/collinaustin/Elist_Sales_Analysis/raw/main/loyalty_program.png)

**Apple Refund Rates**: Between 2019 and 2021 (2022 refund data was excluded due to apparent incompleteness), all products averaged a 6% refund rate, while Apple products averaged 7%. Apple refund rates peaked at 10% in 2020 before declining to 4% in 2021, mirroring the overall trend. Among Apple products, the Macbook Air had the highest refund rate at 13%, while AirPods had the lowest rate at 7% but the highest refund volume in the entire catalog at 2,636 units, nearly 1,200 more than the next highest product. Apple products accounted for 58% of all refunded orders while representing 50% of total orders. However, two non-Apple products posted higher individual refund rates (27in 4K Gaming Monitor at 8%, ThinkPad Laptop at 14%), indicating Apple products are not uniquely problematic on a rate basis. Loyal customers refunded at a higher rate than non-loyal across all products (8% vs. 6%), a pattern that held within the Apple segment as well (8% vs. 6%).

![refunds](https://github.com/collinaustin/Elist_Sales_Analysis/raw/main/apple_refund.png)

## Recommendations

### Sales Trends
**Recommendation: Elist should boost AOV through bundling discounts, run targeted promotions during consistently underperforming months, and conduct a root-cause analysis of the 2022 decline before committing to any long-term growth strategy.**

Elist generated $28.1M in revenue across ~108K orders from 2019–2022, averaging $7M/year at a $254 AOV, but the topline was volatile. A pandemic-driven ~3x surge in 2020 was followed by a 10% dip in 2021 (driven by a 15% AOV decline that offset order growth) and a steep 46% contraction in 2022. To stabilize and grow revenue, **Elist should introduce bundling discounts, potentially tied to the loyalty program or offered as larger incentives for repeat purchases during low-volume months, to increase basket size and address the AOV softness that dragged down 2021 results even as order counts grew.**

Additionally, **targeted promotions in February and October, the two most consistently underperforming months (~16–19% below the monthly average), would be low-cost opportunities to capture incremental revenue: a Valentine's Day campaign in February, and a Halloween or early Black Friday tie-in for October.** 

More critically, the 46% decline in 2022, which wiped out $4.2M in revenue and represented the steepest contraction in the dataset, demands further investigation. **Elist should conduct a root-cause analysis to determine whether this contraction reflects broader macroeconomic conditions, increased competition, or a product assortment that is no longer meeting consumer demand, as the answer will fundamentally shape which growth strategies are worth pursuing.**

### Concentration Risk
**Recommendation: Elist should diversify both its product catalog and its regional footprint to ensure that weakness in any single product or market does not cascade into a company-wide contraction.**

Elist's revenue is dangerously concentrated on both the product and regional level. Three products (Macbook Air, 27in 4K Gaming Monitor, and Apple AirPods) accounted for 85% of the 2020 revenue surge, and those same three drove the subsequent collapse, with the gaming monitor alone responsible for roughly one-third of the 2022 decline and the Macbook Air falling 35% in 2021 and 55% in 2022. Regionally, NA and EMEA make up 81% of total sales, and when those two markets stumbled (NA down 16% in 2021, EMEA down 51% in 2022), there was no offsetting growth elsewhere to absorb the impact. 

On the product side, that means assessing whether the gaming monitor and Macbook Air will remain competitive and expanding into new categories that reduce dependence on a three-product core. On the regional side, APAC should be the top expansion priority: it already posts the highest AOV in both loyalty ($261) and non-loyal ($292) segments despite ranking third in volume, signaling a high-value, underpenetrated market. Elist's fulfillment team, which has consistently delivered 2-day ship times and 5.5-day delivery averages even through peak volume years, is well positioned to scale into new regions.

### Loyalty Program
**Recommendation: The loyalty program should be continued but redesigned.**

Although it trails non-loyal customers in absolute sales (~$6M less), AOV ($34 lower), and repeat purchase rate (17% vs. 22%), it demonstrates stronger growth on every metric: 87% sales CAGR vs. −13.4%, 5.7% AOV growth vs. −2.7%, and 76.9% order volume growth vs. −11%. By 2021, loyalty orders and sales had surpassed non-loyal totals. **The program should be rebuilt around mobile**: loyal customers already over-index on app usage (24% vs. 12%), with a rewards structure focused on increasing order frequency and basket size through expiring points, tiered spending thresholds, and referral bonuses. The mobile app also allows for Elist to track more customer data, which can help Elist offer products and services better in line with customer demand.
