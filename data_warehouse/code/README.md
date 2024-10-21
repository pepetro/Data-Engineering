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
- **models/transformation or relational or dimensional/tables** : This folder contains **sample data** from models built at every layer (transformation, relational and dimensional)
- **answers** : Contains the queries in txt format (one file per query) and results that were run to cover the following questions:
  - Query 1 - How many users were active on a given day (they made a deposit or withdrawal)
  - Query 2 - Identify users haven't made a deposit
  - Query 3 - Identify on a given day which users have made more than 5 deposits historically
  - Query 4 - When was the last time a user made a login
  - Query 5 - How many times a user has made a login between two dates
  - Query 6 - Number of unique currencies deposited on a given day
  - Query 7 - Number of unique currencies withdrew on a given day
  - Query 8 - Total amount deposited of a given currency on a given day

## Development Standards
### Keyword Consistencies
All keywords need to be lower case. Additionally, this should not be Pascal Case, Camel Case, or 
any combination of the aforementioned casings:

```sql
select
    `attribute`
from
    ...
```
### Naked References
Use BigQuery ticks ( `` ) around your schemas, entities, objects, and attributes - this clearly designates the 
difference between database objects and keywords:

```sql
SELECT
    `attribute`
FROM
    `schema`.table_name`
```
### Use of Aliases
Using aliases not only it allows for better readability, it allows for easier authoring. 
While it is very common to use some form of mnemonic device, i.e. `od` for OrderDetails , that recall mechanism might 
not be easy for the next developer to review/update, if the query has a series of common 
table expressions, sub-queries, and/or recursio, start with a and move to z .

```sql
SELECT
    a.`OrderNumber`,
    b.`OrderQuantity`
FROM
    `public`.`Order` a
INNER JOIN
    `public`.`OrderDetail` b ON a.`OrderID`= b.`OrderID`
WHERE
    a.`OrderDate` >= getdate()
```
### Leading Commas
Commas need to trail attribute names BEFORE the return is in place. While placing the comma before the attribute can 
be handy when debugging, developing, hacking, and/or troubleshooting, it is not appropriate for production code. 
When writing, a comma, a return, and a semicolon signal the end of something, not the beginning. This makes it easier 
for future developers to 'pick up' production code, and it enhances its readability.

```sql
SELECT
     a.`attrbute_1`,
     a.`attrbute_2`,
     ...
FROM
    `schema`.`table_name` AS a
WHERE
    ...
```
