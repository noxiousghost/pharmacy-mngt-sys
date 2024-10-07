# Pharmacy Management System

The Pharmacy Management System centralizes key pharmacy operations, including customers, employees, medicines, orders, and bills. It records customer details, manages employee tasks, and streamlines workflow, enhancing efficiency, customer satisfaction, and operational effectiveness.

## Technology Stack

- **SQL Database**: Oracle SQL Database
- **NoSQL Database**: MongoDB

## Queries

1. **Join Query**  
   This query provides a comprehensive overview of pharmacy orders over 200, including order ID, customer details, employee details, and associated bills. It provides a detailed snapshot of transactional activities, highlighting roles, financial details, and payment status for each order.

2. **Union Query**  
   The query lists customers and employees involved in transactions, ensuring each is listed once, providing a comprehensive list of all individuals involved in order transactions.

3. **Query Using Nested or sub table**  
   The query displays a comprehensive list of medicines in each pharmacy order, including medicine name, price, quantity, and total cost. It resembles a detailed receipt for each order.

4. **Query Using temporal features**  
   The query determines the days left until a specific date, like medicine expiration. MongoDB lacks stored functions but uses aggregation pipeline for calculating days until December 31, 2024, for each medicine.

5. **Query Using OLAP**  
   The OLAP-based query is valuable for strategic planning and analysis, offering insights into sales distribution over time and correlation with medicine expiration and order dates. The MongoDB query also analyzes pharmacy sales multidimensionally, aggregating data from Orders, Medicine, and Bill collections to understand sales patterns. Unlike SQL, MongoDB uses pipeline stages for data aggregation.

## Project Setup

### Prerequisites

- OracelDB
- SQL Developer Tool
- MongoDB
- Studio 3t or Mongodb Compass

### Installation

1.  Clone the repository:

    ```bash
    git clone https://github.com/noxiousghost/pharmacy-mngt-sys.git
    cd pharmacy-mngt-sys
    ```

2.  Create SQL Database:

    ```
    - Import pharmacy-final.sql script in SQL Developer tool. This will created necessary tables, types, stored procedures.
    ```

3.  Create Mongodb Database:

    ```
    - Import pharmacy-final.js script in studio 3t. This will created necessary collections and insert values in them.
    ```

4.  Run the Queries for SQL database.

        ```

    - Copy the query code form each files in /sql/queries and paste them in the SQL developer tool's working environment

    ```

    ```

5.  Run the Queries for Mongodb database.

        ```

    - Copy the query code form each files in /mongodb/queries and paste them in theStudio-3t's working environment
      ``
