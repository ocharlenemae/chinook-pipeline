# chinook-pipeline
## Project Overview
End-to-end data pipeline for analyzing the Chinook dataset on Databricks using a medallion architecture (bronze/raw → silver/clean → gold/dimensional). Implements a star schema and provides SQL queries used for BI visualizations. \
This analysis intends to inform the music store operations based on regional sales performance, and customer behavior and preferences.

## Key Findings
- **100%** of customers were classified as **Medium-tier** spenders.  
- **Chile** has the highest regional average price per unit: **$1.23**.  
- **USA** generates the **most revenue by genre**.  
- **Employee leaderboard (quarterly wins)**:
  - **Jane Peacock - 10**
  - Margaret Park - 7
  - Steve Johnson - 3
- **Top-selling tracks** were tied at **2 quantities sold**:
  - **"Don't Look Now" by Creedence Clearwater Revival - 2 sold**
  - **"Smoke On The Water" by Deep Purple - 2 sold**
  - **"Under The Bridge" by Red Hot Chili Peppers - 2 sold**
  - **...**

## Project Architecture and Structure
This pipeline uses the Medallion Architecture, implementing the following layers: Bronze for data extraction, Silver for data cleaning, and Gold for dimensional modelling and visualization. \
See [`docs/architecture.md`](docs/architecture.md) for an in-depth explanation of the architecture.
```text
├── docs/
│   ├── architecture.md       # Pipeline architecture and end-to-end data flow
│   ├── data-model.md         # Star schema, table relationships, and column definitions
│   ├── decisions.md          # Key architectural and design decisions (ADRs)
│   └── validation.md         # Data quality rules and validation checks
│
└── src/
    └── sql/
        ├── 00_setup/         # Database setup 
        ├── 01_raw/           # Bronze layer: Raw data ingestion (1 file per table)
        ├── 02_clean/         # Silver layer: Data cleaning and transformations
        ├── 03_mart/          # Gold layer: Dimensional modeling (dim_* and fact_*)
        └── 04_visualization/ # Analytics layer: Aggregated queries for dashboards
```


## Data Model
The pipeline uses a star schema focusing on the customer, date, employee, and track dimensions. \
See [`docs/data-model.md`](docs/data-model.md) for  column-level descriptions and the exact star diagram.
- **Dimensions (dim_*)**
  - dim_customer - customer attributes and corresponding employee
  - dim_date - date key
  - dim_employee - employee attributes
  - dim_track - track/album/artist attributes used for joins and filtering
- **Fact table**
  - fact_invoice_line - grain: one row per invoice line.\
   This is the primary fact used by the visualization queries.


## How to Run
**Prerequisites**
- Databricks workspace or any Spark SQL-capable environment.
- Access to Chinook source files or a source database.
- Git and an environment where you can run SQL or place SQL files into Databricks notebooks / jobs.

**Steps**
1. **Clone the repo:** \
   git clone https://github.com/ocharlenemae/chinook-pipeline.git

2. **Prepare environment:**
   - Connect the GitHub Repository to your Databricks
   - Navigate to Workspace in Databricks 
   - Click Create > Git Folder. 
   - Enter the Git repository URL 
   - Create the Git folder

3. **Create the Chinook Catalog**
   - Open Databricks Catalog
   - Click Create > Create a catalog
   - Name the catalog, chinook

4. **Execute SQL files in order:**
   - src/sql/00_setup/00_setup.sql 
      - automatically sets up the schemas
   - src/sql/01_raw/*.sql
      - extracts the dataset from the volume
   - src/sql/02_clean/*.sql
      - cleans and prepares the dataset for dimensional modelling 
   - src/sql/03_mart/*.sql
      - implements the star schema for dimensional modelling
   - src/sql/04_visualization/*.sql
      - creates tables for visualization


## Validation
For a complete rundown of the validation checks, refer to [`docs/validation.md`](docs/validation.md).

**Key Checks**
- **Primary keys:** no NULLs in cleaned primary key columns (e.g., customer_id, invoice_id).
- **Types & formatting:** type casting and string normalization were applied.
- **Uniqueness:** dimension keys are unique.
- **Referential integrity:** every fact foreign key matches a dimension row.
- **Reconciliation:** invoice totals match the sum of invoice line amounts.
- **Date coverage:** all invoice dates are present in the date dimension.
- **Basic data-quality thresholds:** no negative/zero quantities or unit prices.


## Decisions
To ensure data integrity throughout the Bronze → Silver → Gold pipeline, clear transformations were applied during the cleaning phase. A full breakdown of the decisions can be found in [`docs/decisions.md`](docs/decisions.md).

### Decisions Summary 

* **Primary Key Integrity (Drop Missing IDs):** 
  Rows missing critical primary keys (`CustomerId`, `EmployeeId`, `GenreId`, `InvoiceId`, `InvoiceLineId`) are dropped, as unidentifiable transaction records cannot be reliably joined or modeled downstream.

* **Transaction Validity (Filter Bad Quantities):** 
  Invoice line items with `Quantity <= 0` or `NULL` are removed to ensure only legitimate purchase events reach the Gold layer.

* **Null Imputation (Artist Name):** 
  Missing `artist_name` values are populated as `"Unknown"` to preserve track data.

* **Data Standardization & Precision:**
  * **Financial Metrics:** Currency values (`UnitPrice`, `Total`) are standardized to 2 decimal places to maintain consistency across aggregations.
  * **Contact Details:** Special characters and spaces are stripped from phone/fax numbers to establish a unified format.

