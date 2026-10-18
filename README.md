# Zomato Restaurant Analysis --- SQL Server & Power BI

## Project Overview

This portfolio project analyses restaurant-level Zomato data for
Bengaluru (Bangalore). It explores restaurant distribution, restaurant
types, ratings, votes, approximate pricing, online-order availability,
and table-booking availability.

The project demonstrates a descriptive analytics workflow: SQL Server
queries, data preparation in Power Query, DAX measures, and an
interactive three-page Power BI report.

> **Scope and limitation:** This is restaurant-level listing data, not
> customer transaction data. It does not provide actual orders, revenue,
> profit, or individual customer behaviour. Votes indicate engagement
> and should not be interpreted as sales.

## Project Objectives

-   Compare restaurant distribution across Bengaluru locations.
-   Analyse restaurant types by count, rating, votes, and approximate
    cost.
-   Examine online-ordering and table-booking availability.
-   Explore rating and vote patterns.
-   Compare locations and restaurant categories using dashboard filters.
-   Translate descriptive findings into business observations without
    claiming causation.

## Tools and Technologies

-   **SQL Server:** 22 analysis questions using aggregations, filtering,
    conditional logic, subqueries, CTEs, and window functions.
-   **Power Query:** Data cleaning and transformation, including
    preparing the rating field for numerical analysis.
-   **Power BI:** Three-page interactive report with KPI cards, charts,
    and a city slicer.
-   **DAX:** Measures for restaurant count, average rating, votes, and
    average cost for two.

## Dataset and Data Preparation

The analysis uses the `Zomato_Raw` table and Bengaluru restaurant-level
data. Project documentation references approximately **51,717 rows**;
confirm the exact count against the final imported table if the dataset
or cleaning steps change.

The raw `rate` field contains values such as `3.1/5`, as well as text
such as `NEW` and missing values. In Power Query, the numeric portion
before `/` was extracted and converted to a number; values that could
not be converted were treated as null for rating analysis.

Example Power Query expression:

``` powerquery
try Number.FromText(Text.BeforeDelimiter([rate], "/")) otherwise null
```

## SQL Analysis

The SQL Server script contains **22 questions (Q1--Q22)** covering:

-   Row counts and basic inspection
-   NULL and missing-rating analysis
-   Percentages and conditional aggregation with `CASE`
-   Restaurant counts by city and restaurant type
-   Distinct cuisine values by city
-   Vote totals and average votes
-   Average and maximum ratings
-   Subqueries using overall averages
-   CTEs and window functions to rank restaurants by city, retaining
    ties for the highest vote total
-   Online-ordering percentages and minimum group-size filters

See the SQL script in this repository for the complete questions and
queries.

## Power BI Dashboard

The report has three pages.

### 1. Restaurant Overview

-   KPI cards: Total Restaurants, Average Rating, Total Votes, and
    Average Cost for Two
-   City slicer
-   Restaurant counts by city
-   Top restaurants by votes

![Restaurant Overview](screenshots/01_Restaurant_Overview.png)

### 2. Restaurant & Location Analysis

-   Restaurant-type comparisons by count, average rating, average votes,
    and approximate cost
-   Votes-versus-rating scatter chart
-   Top 10 restaurants by votes
-   Interactive location filtering

![Restaurant and Location
Analysis](screenshots/02_Restaurant_Location_Analysis.png)

### 3. Customer & Ordering Analysis

-   Online-order and table-booking availability
-   Average-rating comparisons across availability categories
-   Restaurant types by online-order availability
-   Average cost for two compared with restaurant rating

![Customer and Ordering
Analysis](screenshots/03_Customer_Ordering_Analysis.png)

> **Screenshot note:** The image paths above are suggested repository
> paths. Add actual exported dashboard screenshots with these filenames,
> or update the paths to match your repository.

## Selected Business Observations

The following observations were recorded from the project's dashboard
screenshots. KPI values can change with slicer selections, so state the
filter context when presenting them.

-   In one overview screenshot with **Brigade Road** selected, KPI cards
    displayed approximately **2K restaurants**, an **average rating of
    3.80**, **648K total votes**, and an **average cost for two of
    ₹767.09**.
-   The restaurant-type count chart displayed **Quick Bites (480)** and
    **Casual Dining (398)** as the two largest categories in that view,
    followed by **Cafe (150)**.
-   Average rating was shown as **3.81** for restaurants offering online
    ordering and **3.79** for those not offering it. This small
    descriptive difference does not prove online ordering causes higher
    ratings.
-   Average rating was shown as **4.16** for restaurants offering table
    booking and **3.69** for those not offering it. This is an
    association, not evidence of causation.
-   The table-booking chart showed approximately **19.79% available**
    and **80.21% unavailable** in the displayed context.
-   **Hammered** had approximately **27.9K votes** in the overview
    visual's displayed filter context.

These values are observations from supplied dashboard screenshots, not
universal values for every slicer selection. Recheck the final dashboard
before using them in a presentation or interview.

## Potential Business Recommendations

These are hypotheses to investigate, not proven outcomes from this
dataset:

1.  **Compare locations before expanding:** Use restaurant counts,
    ratings, votes, and price indicators together to identify locations
    for further investigation.
2.  **Investigate category differences:** Compare restaurant types by
    rating and engagement rather than relying on restaurant count alone.
3.  **Review ordering features carefully:** Online-order availability
    and ratings can be compared descriptively, but this dataset cannot
    establish whether online ordering improves ratings or revenue.
4.  **Treat votes as engagement, not sales:** High vote counts indicate
    recorded engagement; they do not directly measure customers, orders,
    or profitability.
5.  **Validate with operational data:** Before investment or expansion
    decisions, combine this analysis with actual orders, revenue, costs,
    footfall, and customer-level data.

## Suggested Repository Structure

``` text
zomato-restaurant-analysis/
├── README.md
├── sql/
│   └── ZomatoProject.sql
├── power-bi/
│   └── Zomato_Dashboard.pbix
├── screenshots/
│   ├── 01_Restaurant_Overview.png
│   ├── 02_Restaurant_Location_Analysis.png
│   └── 03_Customer_Ordering_Analysis.png
└── docs/
    └── Business_Insights_and_Recommendations.pdf
```

Rename or move files to match your actual repository. Do not include the
raw dataset if its licence or redistribution terms do not permit it;
link to the original source instead.

## How to Review the Project

1.  Open the SQL script in SQL Server Management Studio and review
    Q1--Q22.
2.  Open the `.pbix` file in Power BI Desktop.
3.  Use the city slicer and other filters to explore how visuals change.
4.  Compare dashboard observations with SQL results, remembering that
    visual filters and aggregation levels may differ.

## Key Takeaway

This project demonstrates SQL-based analysis, data preparation, DAX
measures, interactive Power BI reporting, and interpretation of
restaurant-level data. Its value lies in showing the analytical workflow
and explaining data limitations---not claiming business outcomes that
the dataset cannot measure.
