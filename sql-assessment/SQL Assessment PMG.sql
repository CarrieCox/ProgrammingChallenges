----------------------------------------
-- SQL Assessment: Carrie Cox--
----------------------------------------

-- 1 Write a query to get the sum of impressions by day

select date_, sum(impressions) as "Total Impressions"
from marketing_performance
group by date_
order by date_;


-- 2 Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?

select state, sum(revenue) as "Total Revenue"
from website_revenue
group by state
order by "Total Revenue" desc
fetch first 3 rows only;
--- The third best state had $37,577 generated in revenue.


-- 3 Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.

select c.name, 
    a.campaign_id, 
    sum(a.cost) as "Total Cost", 
    sum(a.impressions) as "Total Impressions", 
    sum(a.clicks) as "Total Clicks", 
    sum(b.revenue) as "Total Revenue"
from marketing_performance a
join website_revenue b
on a.campaign_id = b.campaign_id 
join campaign_info c
on a.campaign_id = c.id
group by c.name, a.campaign_id
order by c.name


-- 4 Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?

select b.state, sum(a.conversions) as "Total Conversions"
from marketing_performance a
join website_revenue b
on a.campaign_id = b.campaign_id 
join campaign_info c
on a.campaign_id = c.id
where c.name = 'Campaign5'
group by b.state
order by "Total Conversions" desc
-- Georgia generated the most conversions for Campaign5


-- 5 In your opinion, which campaign was the most efficient, and why?

select c.name as "Campaign Name",
    c.id as "Campaign Name",
    sum(b.revenue) as "Total Revenue",
    sum(a.cost) as "Total Cost", 
    sum(b.revenue) - sum(a.cost) as "Total Profit",
    sum(a.conversions) as "Total Conversions", 
    sum(a.impressions) as "Total Impressions", 
    sum(a.clicks) as "Total Clicks"
from marketing_performance a
join website_revenue b
on a.campaign_id = b.campaign_id 
join campaign_info c
on a.campaign_id = c.id
group by  c.name, c.id
order by "Total Profit" desc

-- In my opinion, Campaign3 is the most efficient campagin. I first evaluated which campaign was returning the highest profit (website revenue - marketing cost) and 
-- found that Campaign3 has the highest profit by $376,437. It also has performs the best in terms of conversions, impressions and clicks. So, if the marketing cost 
-- is not a constraint, I'd say that Campaign3 is the most efficient. If cost is a constraint, Campaign4 is the second highest in profit, conversions and impressions 
-- and could be a good campaign option if a company is not willing to pay the cost for Campaign3. 


-- 6 Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.

WITH DayOfWeek AS (
    select campaign_id, TO_CHAR(date_, 'Day') AS day_of_week
    from website_revenue
)

select b.day_of_week, 
    sum(a.revenue) as "Total Revenue",
    sum(c.cost) as "Total Cost", 
    sum(a.revenue) - sum(c.cost) as "Total Profit",
    sum(c.conversions) as "Total Conversions", 
    sum(c.impressions) as "Total Impressions", 
    sum(c.clicks) as "Total Clicks"
from website_revenue a
join DayofWeek b
on a.campaign_id = b.campaign_id
join marketing_performance c
on a.campaign_id = c.campaign_id
group by b.day_of_week
order by "Total Revenue" desc
--- Monday brings in the most revenue from campaigns, and has the highest amount of conversions, impressions and clicks. 