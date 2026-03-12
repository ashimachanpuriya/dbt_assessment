# Rental Property Analytics — dbt Assessment

## Project Overview
This dbt project models rental property listing data for a property management company.
It transforms raw source data into an analytics-ready mart that enables revenue, 
occupancy, and amenity analysis across listings.

## Data Sources
| Table                 | Description                                                                |
|-----------------------|----------------------------------------------------------------------------|
| `listings`            | Property listing details including host info, property type, and amenities |
| `calendar`            | Availability and pricing per listing                                       |
| `amenities_changelog` | Historical record of amenity changes per listing                           |

## Model Layers

### Staging (`models/staging/`)
One model per source table. Responsibilities:
- Cast columns to correct types
- Parse JSON columns (amenities, host_verifications)
- Renaming columns for clarity
- No business logic

### Intermediate (`models/intermediate/`)
| Model                     | Description                                                                             |
|---------------------------|-----------------------------------------------------------------------------------------|
| `int_amenities_date_wise` | Joins calendar dates to the most recent changelog entry on or before that date,         |
|                           | producing historically accurate point-in-time amenities                                 |

### Marts (`models/marts/`)
| Model                  | Description                                                                                 |
|------------------------|---------------------------------------------------------------------------------------------|
| `fct_listing_calendar` | Core fact table at listing/date grain. Combines calendar,                                   |
|                        | listing details, and point-in-time amenities                                                |


**Materializations**
- Staging  → `view` 
- Intermediate and Marts → `table` 


## Data Quality Notes

### Listings Source
Two rows were found with null IDs in the source `listings` table and filtered 
out in `stg_listings`:

| Issue                   | Detail                                                       | Action                    |
|-------------------------|--------------------------------------------------------------|---------------------------|
| Real listing missing ID | "19th Century Luxury, South End" —                           | Filtered out in staging   | 
|                         | genuine listing data but no ID, cannot be joined to other    |                           |  
|                         | tables.                                                      |                           |    
| Test record             | "TESTING LISTING" — host_id=-99999,                          |                           |
|                         | 996 bathrooms, 9910 beds, "telegraph" as verification method.| Filtered out in staging   |

These rows are excluded via `where id is not null and host_id > 0` in `stg_listings`.

## How to Run
```bash
# To load csv data
dbt seed

# To run all the models
dbt run

# To run all the tests
dbt test

# Run everything
dbt build
```

