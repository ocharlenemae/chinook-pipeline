# 🎵 Chinook Data Pipeline — Architecture Documentation

## Overview

This document describes the **layered architecture** of the Chinook data pipeline, following the **Bronze → Silver → Gold** (Medallion) design pattern. Each layer represents a stage of data refinement, moving from raw ingested data to clean, structured data, and finally to business-ready analytical models.

![Chinook Pipeline Architecture](images/chinook-architecture.png)
---

## Data Source

The pipeline is built on the **Chinook dataset**, sourced from a **Cloudflare R2 bucket** and accessed in Databricks via a configured **Unity Catalog External Location**.

- **External Location:** `FTW-B12-DE-R2`
- **Storage provider:** Cloudflare R2 (S3-compatible object storage)
- **Access path in Databricks:** `/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/`
- **Format:** CSV files (one file per table, e.g., `Album.csv`, `Artist.csv`, `Customer.csv`, etc.)
- **Ingestion method:** `read_files()` — Databricks SQL function used to read CSV files directly from the mounted Volume path into raw tables
- **Authentication:** Managed via a Unity Catalog storage credential linked to the `FTW-B12-DE-R2` external location (credentials stored securely, not included in this document)

**Example ingestion pattern:**
```sql
SELECT * FROM read_files(
  '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/Album.csv'
)
```

---

## 🥉 Bronze Layer — `01_raw/`

**Purpose:** Ingests raw data directly from the source system (Chinook dataset) with **no transformation applied**. This layer is an exact, untouched copy of the source data — no cleaning, renaming, filtering, or restructuring — and acts as the single source of truth for raw records.

**Characteristics:**
- **No changes made to the data** — values, formats, and structure are identical to the source
- Schema mirrors the source system exactly
- Used for traceability and reprocessing if downstream layers need to be rebuilt

**Files:**
| File | Description |
|------|-------------|
| `01_raw_album.sql` | Raw ingestion of album data |
| `02_raw_artist.sql` | Raw ingestion of artist data |
| `03_raw_customer.sql` | Raw ingestion of customer data |
| `04_raw_employee.sql` | Raw ingestion of employee data |
| `05_raw_genre.sql` | Raw ingestion of genre data |
| `06_raw_invoice.sql` | Raw ingestion of invoice data |
| `07_raw_invoice_line.sql` | Raw ingestion of invoice line items |
| `08_raw_media_type.sql` | Raw ingestion of media type data |
| `09_raw_playlist.sql` | Raw ingestion of playlist data |
| `10_raw_playlist_track.sql` | Raw ingestion of playlist-track mapping |
| `11_raw_track.sql` | Raw ingestion of track data |

---

## 🥈 Silver Layer — `02_clean/`

**Purpose:** Cleans, standardizes, and validates the raw data from the Bronze layer. This includes handling nulls, correcting data types, removing duplicates, and applying consistent naming conventions.

**Characteristics:**
- Data quality rules applied
- Standardized column names and formats
- Deduplicated and validated records
- Serves as the trusted, analysis-ready foundation for the Gold layer

**Files:**
| File | Description |
|------|-------------|
| `01_clean_album.sql` | Cleaned and standardized album data |
| `02_clean_artist.sql` | Cleaned and standardized artist data |
| `03_clean_customer.sql` | Cleaned and standardized customer data |
| `04_clean_employee.sql` | Cleaned and standardized employee data |
| `05_clean_genre.sql` | Cleaned and standardized genre data |
| `06_clean_invoice.sql` | Cleaned and standardized invoice data |
| `07_clean_invoice_line.sql` | Cleaned and standardized invoice line items |
| `08_clean_media_type.sql` | Cleaned and standardized media type data |
| `09_clean_playlist.sql` | Cleaned and standardized playlist data |
| `10_clean_playlist_track.sql` | Cleaned and standardized playlist-track mapping |
| `11_clean_track.sql` | Cleaned and standardized track data |

---

## 🥇 Gold Layer — `03_mart/`

**Purpose:** Transforms cleaned data into a **dimensional model** (star schema) optimized for analytics and reporting. This layer contains dimension and fact tables built to support business intelligence use cases.

**Characteristics:**
- Star schema design (dimensions + facts)
- Business logic and aggregations applied
- Optimized for query performance and reporting tools

**Files:**
| File | Description |
|------|-------------|
| `01_dim_customer.sql` | Customer dimension table |
| `02_dim_date.sql` | Date dimension table |
| `03_dim_employee.sql` | Employee dimension table |
| `04_dim_track.sql` | Track dimension table |
| `05_fact_invoice_line.sql` | Fact table capturing invoice line-level transactions |

---

## 📊 Visualization Layer — `04_visualization/`

**Purpose:** Contains query logic that powers dashboards and reports, built on top of the Gold layer's dimensional model. These queries answer specific business questions.

**Files:**
| File | Description |
|------|-------------|
| `01_top_revenue_by_genre_per_country.sql` | Top revenue-generating genres per country |
| `02_customer_spending_segmentation.sql` | Customer segmentation based on spending behavior |
| `03_monthly_sales_trend.sql` | Monthly sales trend analysis |
| `04_employee_sales_performance.sql` | Employee sales performance metrics |
| `05_popular_tracks_by_quantity_sold.sql` | Most popular tracks by quantity sold |
| `06_regional_pricing_insights.sql` | Pricing insights segmented by region |

---

## Data Flow Summary

1. **Bronze (`01_raw`)** — Raw data lands as-is from the Chinook dataset (via Cloudflare R2), with no modifications.
2. **Silver (`02_clean`)** — Raw data is cleaned, validated, and standardized.
3. **Gold (`03_mart`)** — Clean data is modeled into dimension and fact tables for analytics.
4. **Visualization (`04_visualization`)** — Gold layer tables are queried to generate business insights and reports.
