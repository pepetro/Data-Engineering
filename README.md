# Onboarding Squad 

This repository maintains the following structure.

### *Folders*

- [**`data_lake`**](https://github.com/pepetro/bitso/tree/main/data_lake): This folder contains 
  - [**inbound**](https://github.com/pepetro/bitso/tree/main/data_lake/inbound): Python 3 scripts used to ETL data into Data Lake leveraging Ariflow for orchestration
- [**`data_warehouse`**](https://github.com/pepetro/bitso/tree/main/data_warehouse/code): This folder contains the complete set of "calculated" entities build, loaded, and physically persisted as tables via SQL. They include three major areas:
   - `answers`: SQL files with the queries that will answer the cases TXT sample output
   - `macros`: Jinja macro used for modelling
   - `models`: Transformation (or staging), relational and dimensional models more details [here](https://github.com/pepetro/bitso/blob/main/data_warehouse/code/README.md)
   - `sources`: Data sources integrated from Data Lake into the Data Warehouse
     - `tables`: CSVs with the output tables
 - [**`deliverables`**](https://github.com/pepetro/bitso/tree/main/deliverables): This folder contains supporting documentation, images and diagrams used in the solution
   - **Case**:
     - PPT presentation with proposed strategy and roadmap - see [here](https://github.com/pepetro/bitso/tree/main/deliverables/case)
   - [Challenge:](https://github.com/pepetro/bitso/tree/main/deliverables/challenge)
      - **Proposed_High_Level_Architectrure.pdf** - Visual representation of the proposed DWH/Data Lake architecture
      - **dags_to_final_tables.png** - Visual representation of the DAGs to reach the final tables
      - **Data_Modeling.pptx** - PPT explaining what modeling techniques did you use, why did you choose them pros and cons
- [**`files`**]():
  - Files provided by Bitso
