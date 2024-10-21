<h2>Data Warehouse Philosophy</h2>

This repository maintains the standard `dbt` structure.

### *Standard Directories*

- **`macros`**: This folder contains Jinja based templates to support the standardization of the repository build.  It include common patterns for naming conventions, calculations, and database standards.
- **`models`**: This folder contains the complete set of "calculated" entities build, loaded, and physically persisted as tables via SQL. They include three major areas:
   - `transformation`: area utilizing business logic and conversion from the raw source into valuable data
      - Executions
      - Reshape, Rename, Recast
      - Enrich (Business Logic)
      - Deduplicate
      - Aggregate, Nest
      - Join/union/except/interest for homoginization & normalization purposes
   - `relational`:
     - Table objects built from transformation layer
     - Executions
     - Union, Except, Intersect
     - Join for conformation purposes (e.g. key lookups)
   - `dimensional`:
     - Table objects built from relational layer
     - Subset of Relational data
     - Executions
     - Reshape (for denormalization purposes)
     - Join (for data mart purposes)
     - Enrich (**Limited** business logic, e.g. non-relational measurements)
- **`sources`**:
  - Raw match to the Data Lake
  - "Ticked" attributes in proper ordinal
  - No `select *`
  - "Soft deleted" records removed
  - Non-materialized view object

### *Extended Directories*

- **answers** : Contains the queries in txt format (one file per query) and results that were run to cover the following questions:
  - Query 1 - How many users were active on a given day (they made a deposit or withdrawal)
  - Query 2 - Identify users haven't made a deposit
  - Query 3 - Identify on a given day which users have made more than 5 deposits historically
  - Query 4 - When was the last time a user made a login
  - Query 5 - How many times a user has made a login between two dates
  - Query 6 - Number of unique currencies deposited on a given day
  - Query 7 - Number of unique currencies withdrew on a given day
  - Query 8 - Total amount deposited of a given currency on a given day
