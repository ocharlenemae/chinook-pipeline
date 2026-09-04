# Data Model


## Star Schema Design
(Insert Star Schema Image)

## Fact Table
**fact_invoice_line**

_Grain:_ One row represents one line-item purchase on an invoice.

_Primary Key:_ `invoice_line_id  `  

_Foreign Keys:_ `track_id`, `customer_id`, `employee_id`, `date_key`

_Financial Metrics:_ `quantity`, `unit_price`, `line_amount` 

_Other Fields:_ `artist_name`, `genre_name`, `country`

## Dimensions
**dim_track**

_Grain:_ One row represents one distinct audio track

_Primary Key:_ `track_id`

_Other Fields:_ `track_name`, `album_title`, `artist_name`, `genre_name`, `media_type_name`


**dim_customer**

_Grain:_ One row represents one individual customer

_Primary Key:_ `customer_id`

_Other Fields:_ `full_name`, `company`, `city`, `state`, `country`, `postal_code`, `phone`, `email`, `support_rep_id`, `support_rep_name`


**dim_employee**

_Grain:_ One row represents one company employee

_Primary Key:_ `employee_id`

_Other Fields:_ `employee_name`, `title`


**dim_date**

_Grain:_ One row represents a single calendar date when a transaction occurred

_Primary Key:_ `date_key`

_Other Fields:_ `date`, `month_and_year`, `year_and_quarter`


## Dashboard: Business Questions Answered
* **Top Revenue by Genre per Country:** Identifies top musical genres by total revenue in every country
* **Customer Segmentation by Spending Tier:** Classifies customers into spending tiers (High, Medium, Low) based on their lifetime spending
* **Monthly Sales Trend:** Tracks month-by-month revenue patterns over time to analyze trends and performance
* **Employee Sales Performance:** Ranks sales representatives to assess top-performing agents by quarter
* **Popular Tracks by Quantity Sold:** Highlights the top 20 best-selling tracks alongside their corresponding album and artist details
* **Regional Pricing Insights:** Calculates the average unit price per track across different countries


