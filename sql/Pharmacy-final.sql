-- drop tables, types and procedures start
DROP TYPE AddressType FORCE;    
DROP TYPE PersonType FORCE;  
DROP TYPE OrderDetailType FORCE;  
DROP TYPE OrderDetailsType FORCE;  

DROP PROCEDURE GenerateBill;
DROP PROCEDURE PopulateOrderMedicine;
DROP FUNCTION CalculateDaysRemaining;

DROP TABLE Bill CASCADE CONSTRAINTS;
DROP TABLE OrderMedicine CASCADE CONSTRAINTS;
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Medicine CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;

DROP SEQUENCE bill_seq;
DROP SEQUENCE order_medicine_seq;
DROP SEQUENCE orders_seq;
DROP SEQUENCE medicine_seq;
DROP SEQUENCE employee_seq;
DROP SEQUENCE customer_seq;
-- Drop end

-- sequence creation start
CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE medicine_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE employee_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE orders_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE order_medicine_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE bill_seq START WITH 1 INCREMENT BY 1;
-- sequence creation end

-- Table and types creation start
-- Address Type Object
CREATE TYPE AddressType AS OBJECT (
    Street VARCHAR2(255),
    City VARCHAR2(255),
    State VARCHAR2(255),
    ZipCode VARCHAR2(20)
);
/

-- base type for Person
CREATE TYPE PersonType AS OBJECT (
    FirstName VARCHAR2(255),
    LastName VARCHAR2(255),
    Address AddressType,
    ContactNumber VARCHAR2(20)
);
/
 -- Customer table using Person Type
CREATE TABLE Customer (
    CustomerID NUMBER DEFAULT customer_seq.NEXTVAL PRIMARY KEY,
    PersonDetails PersonType
);
/

-- Employee Table using PersonType
CREATE TABLE Employee (
    EmployeeID NUMBER DEFAULT employee_seq.NEXTVAL PRIMARY KEY,
    PersonDetails PersonType,
    Position VARCHAR2(255)
);
/

--  Medicine Table
CREATE TABLE Medicine (
    MedicineID NUMBER DEFAULT medicine_seq.NEXTVAL PRIMARY KEY,
    Name VARCHAR2(255),
    Manufacturer VARCHAR2(255),
    Price NUMBER,
    Stock NUMBER,
    ExpDate DATE
);
/

--  Object Types for OrderDetails
CREATE TYPE OrderDetailType AS OBJECT (
    MedicineID NUMBER,
    Quantity NUMBER
);
/
-- Nested table types for order details
CREATE TYPE OrderDetailsType AS TABLE OF OrderDetailType;
/

--  Orders Table with nested table for OrderDetails
CREATE TABLE Orders (
    OrderID NUMBER DEFAULT orders_seq.NEXTVAL PRIMARY KEY,
    CustomerID NUMBER REFERENCES Customer(CustomerID),
    EmployeeID NUMBER REFERENCES Employee(EmployeeID),
    DateOrdered DATE,
    OrderDetails OrderDetailsType
) NESTED TABLE OrderDetails STORE AS OrderDetailsStore;
/

--  OrderMedicine Table 
CREATE TABLE OrderMedicine (
    OrderID NUMBER REFERENCES Orders(OrderID),
    MedicineID NUMBER REFERENCES Medicine(MedicineID),
    Quantity NUMBER,
    PRIMARY KEY (OrderID, MedicineID)
);
/

-- Bill Table 
CREATE TABLE Bill (
    BillID NUMBER DEFAULT bill_seq.NEXTVAL PRIMARY KEY,
    OrderID NUMBER UNIQUE REFERENCES Orders(OrderID),
    TotalAmount NUMBER,
    PaymentStatus VARCHAR2(50)
);
/
-- Table and type creation end

--Insert values into tables start
-- Inserting into the Customer table
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Alice', 'Johnson', AddressType('789 Oak Ln', 'Raleigh', 'NC', '27601'), '555-0303'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Bob', 'Williams', AddressType('101 Pine Ave', 'Austin', 'TX', '78701'), '555-0404'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Eva', 'Miller', AddressType('222 Birch Rd', 'Portland', 'OR', '97201'), '555-0505'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Michael', 'Brown', AddressType('333 Cedar St', 'Denver', 'CO', '80202'), '555-0606'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Olivia', 'Jones', AddressType('444 Walnut Ave', 'San Francisco', 'CA', '94105'), '555-0707'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('William', 'Davis', AddressType('555 Spruce Blvd', 'Seattle', 'WA', '98101'), '555-0808'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Sophia', 'Martinez', AddressType('666 Pine Ct', 'Chicago', 'IL', '60601'), '555-0909'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Daniel', 'Lopez', AddressType('777 Oak Dr', 'New York', 'NY', '10001'), '555-1010'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Ava', 'Garcia', AddressType('888 Maple Ln', 'Los Angeles', 'CA', '90001'), '555-1111'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Ethan', 'Rodriguez', AddressType('999 Elm Rd', 'Miami', 'FL', '33101'), '555-1212'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Mia', 'Hernandez', AddressType('123 Oak St', 'Phoenix', 'AZ', '85001'), '555-1313'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('James', 'Gomez', AddressType('456 Birch Ave', 'Dallas', 'TX', '75201'), '555-1414'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Lily', 'Cooper', AddressType('789 Cedar Blvd', 'Atlanta', 'GA', '30301'), '555-1515'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Christopher', 'Perez', AddressType('101 Pine Dr', 'Houston', 'TX', '77001'), '555-1616'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Emma', 'Baker', AddressType('202 Walnut Rd', 'Philadelphia', 'PA', '19101'), '555-1717'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Logan', 'Ward', AddressType('303 Pine Ct', 'San Diego', 'CA', '92101'), '555-1818'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Zoe', 'Fisher', AddressType('404 Cedar Dr', 'Detroit', 'MI', '48201'), '555-1919'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Jackson', 'Chen', AddressType('505 Maple Rd', 'Minneapolis', 'MN', '55401'), '555-2020'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Evelyn', 'Liu', AddressType('606 Birch Ln', 'Charlotte', 'NC', '28201'), '555-2121'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Aiden', 'Wang', AddressType('707 Oak Blvd', 'Tampa', 'FL', '33601'), '555-2222'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Grace', 'Morgan', AddressType('808 Elm Dr', 'Columbus', 'OH', '43201'), '555-2323'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Lucas', 'Lopez', AddressType('909 Pine Rd', 'San Antonio', 'TX', '78201'), '555-2424'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Stella', 'Barnes', AddressType('101 Maple St', 'Orlando', 'FL', '32801'), '555-2525'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Nathan', 'Nguyen', AddressType('202 Cedar Ave', 'Las Vegas', 'NV', '89101'), '555-2626'));
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, PersonType('Aria', 'Kim', AddressType('303 Oak Ln', 'Kansas City', 'MO', '64101'), '555-2727'));

-- Inserting into Employee Table
INSERT INTO Employee VALUES (employee_seq.NEXTVAL, PersonType('Charlie', 'Green', AddressType('123 Birch St', 'Austin', 'TX', '73301'), '555-0505'), 'Manager');
INSERT INTO Employee VALUES (employee_seq.NEXTVAL, PersonType('Diana', 'Brown', AddressType('456 Cedar Ln', 'Phoenix', 'AZ', '85003'), '555-0606'), 'Pharmacist');
INSERT INTO Employee VALUES (employee_seq.NEXTVAL, PersonType('Ethan', 'Black', AddressType('789 Willow Way', 'Nashville', 'TN', '37209'), '555-0707'), 'Cashier');
INSERT INTO Employee VALUES (employee_seq.NEXTVAL, PersonType('Fiona', 'Gray', AddressType('321 Spruce Ave', 'Miami', 'FL', '33101'), '555-0808'), 'CPhT');
INSERT INTO Employee VALUES (employee_seq.NEXTVAL, PersonType('George', 'Adams', AddressType('654 Pine St', 'Seattle', 'WA', '98101'), '555-0909'), 'Pharmacist');
INSERT INTO Employee VALUES (employee_seq.NEXTVAL, PersonType('Hannah', 'Clark', AddressType('987 Oak Blvd', 'Boston', 'MA', '02101'), '555-1010'), 'Cashier');
INSERT INTO Employee VALUES (employee_seq.NEXTVAL, PersonType('Ian', 'Davis', AddressType('432 Elm St', 'San Francisco', 'CA', '94102'), '555-1111'), 'Cashier');

-- Inserting into the Medicine table
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Ibuprofen', 'PharmaCare Ltd', 12.75, 120, TO_DATE('2025-09-30', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Amoxicillin', 'PharmaCare Ltd', 15.25, 90, TO_DATE('2025-08-20', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Cetirizine', 'HealthRx Solutions', 9.99, 200, TO_DATE('2025-11-15', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Omeprazole', 'BioMed Co', 18.50, 80, TO_DATE('2025-07-31', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Simvastatin', 'BioMed Co', 22.99, 150, TO_DATE('2025-10-10', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Losartan', 'HealthRx Solutions', 17.50, 100, TO_DATE('2025-12-15', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Metformin', 'PharmaCare Ltd', 14.99, 180, TO_DATE('2025-09-01', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Prednisone', 'PharmaWell Solutions', 25.75, 70, TO_DATE('2025-08-05', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Levothyroxine', 'VitalCure Ltd', 11.25, 120, TO_DATE('2025-10-25', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Diazepam', 'VitalCure Ltd', 30.99, 50, TO_DATE('2025-07-15', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Naproxen', 'PharmaCare Ltd', 14.50, 100, TO_DATE('2025-11-30', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Cephalexin', 'PharmaCare Ltd', 16.75, 120, TO_DATE('2025-10-15', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Loratadine', 'HealthRx Solutions', 8.25, 180, TO_DATE('2025-12-01', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Pantoprazole', 'BioMed Co', 20.99, 90, TO_DATE('2025-09-20', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Atorvastatin', 'BioMed Co', 24.50, 150, TO_DATE('2025-08-10', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Valsartan', 'HealthRx Solutions', 18.25, 110, TO_DATE('2025-11-25', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Glimepiride', 'PharmaCare Ltd', 13.99, 200, TO_DATE('2025-09-10', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Methylprednisolone', 'PharmaWell Solutions', 27.75, 80, TO_DATE('2025-07-05', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Synthroid', 'VitalCure Ltd', 10.50, 130, TO_DATE('2025-10-20', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Lorazepam', 'VitalCure Ltd', 33.25, 60, TO_DATE('2025-08-15', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Naproxen', 'PharmaCare Ltd', 14.50, 100, TO_DATE('2025-11-30', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Cephalexin', 'PharmaCare Ltd', 16.75, 120, TO_DATE('2025-10-15', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Loratadine', 'HealthRx Solutions', 8.25, 180, TO_DATE('2025-12-01', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Pantoprazole', 'BioMed Co', 20.99, 90, TO_DATE('2025-09-20', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Atorvastatin', 'BioMed Co', 24.50, 150, TO_DATE('2025-08-10', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Valsartan', 'HealthRx Solutions', 18.25, 110, TO_DATE('2025-11-25', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Glimepiride', 'PharmaCare Ltd', 13.99, 200, TO_DATE('2025-09-10', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Methylprednisolone', 'PharmaWell Solutions', 27.75, 80, TO_DATE('2025-07-05', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Synthroid', 'VitalCure Ltd', 10.50, 130, TO_DATE('2025-10-20', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Lorazepam', 'VitalCure Ltd', 33.25, 60, TO_DATE('2025-08-15', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Pantoprazole', 'BioMed Co', 20.99, 90, TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Atorvastatin', 'BioMed Co', 24.50, 150, TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Valsartan', 'HealthRx Solutions', 18.25, 110, TO_DATE('2024-01-25', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Glimepiride', 'PharmaCare Ltd', 13.99, 200, TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Methylprednisolone', 'PharmaWell Solutions', 27.75, 80, TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Synthroid', 'VitalCure Ltd', 10.50, 130, TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO Medicine VALUES (medicine_seq.NEXTVAL, 'Lorazepam', 'VitalCure Ltd', 33.25, 60, TO_DATE('2024-01-15', 'YYYY-MM-DD'));


-- Inserting into orders table
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 10, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +16, OrderDetailsType(OrderDetailType(21, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 12, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +32, OrderDetailsType(OrderDetailType(1, 1)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 13, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +16, OrderDetailsType(OrderDetailType(1, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 14, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +32, OrderDetailsType(OrderDetailType(1, 3)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 15, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +7, OrderDetailsType(OrderDetailType(2, 4)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 16, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +17, OrderDetailsType(OrderDetailType(3, 3)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 17, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +8, OrderDetailsType(OrderDetailType(11, 5)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 18, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +18, OrderDetailsType(OrderDetailType(30, 3)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 19, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +5, OrderDetailsType(OrderDetailType(20, 3)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 20, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +15, OrderDetailsType(OrderDetailType(21, 3)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 1, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +5, OrderDetailsType(OrderDetailType(22, 6)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 2, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +15, OrderDetailsType(OrderDetailType(23, 3)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 3, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +15, OrderDetailsType(OrderDetailType(24, 5)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 4, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +15, OrderDetailsType(OrderDetailType(25, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 5, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +16, OrderDetailsType(OrderDetailType(26, 1)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 6, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +16, OrderDetailsType(OrderDetailType(27, 3)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 7, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +16, OrderDetailsType(OrderDetailType(28, 7)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 8, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +16, OrderDetailsType(OrderDetailType(32, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 9, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +16, OrderDetailsType(OrderDetailType(33, 3)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 1, 3, TO_DATE('2023-01-10', 'YYYY-MM-DD'), OrderDetailsType(OrderDetailType(1, 2), OrderDetailType(2, 1)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 2, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD'), OrderDetailsType(OrderDetailType(2, 1), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 3, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +10, OrderDetailsType(OrderDetailType(3, 1), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 4, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +20, OrderDetailsType(OrderDetailType(4, 5), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 4, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +23, OrderDetailsType(OrderDetailType(5, 2), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 5, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +27, OrderDetailsType(OrderDetailType(6, 7), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 6, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +30, OrderDetailsType(OrderDetailType(7, 9), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 7, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +31, OrderDetailsType(OrderDetailType(8, 10), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 8, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +32, OrderDetailsType(OrderDetailType(9, 2), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 9, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +36, OrderDetailsType(OrderDetailType(10, 3), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 10, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +36, OrderDetailsType(OrderDetailType(11, 3), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 11, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +69, OrderDetailsType(OrderDetailType(12, 4), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 12, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +36, OrderDetailsType(OrderDetailType(13, 5), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 13, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +36, OrderDetailsType(OrderDetailType(14, 6), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 14, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +10, OrderDetailsType(OrderDetailType(15, 8), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 15, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +5, OrderDetailsType(OrderDetailType(16, 4), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 16, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +10, OrderDetailsType(OrderDetailType(17, 10), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 17, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +25, OrderDetailsType(OrderDetailType(21, 6), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 18, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +40, OrderDetailsType(OrderDetailType(22, 7), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 19, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +45, OrderDetailsType(OrderDetailType(28, 8), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 20, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +40, OrderDetailsType(OrderDetailType(30, 7), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 21, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +42, OrderDetailsType(OrderDetailType(26, 2), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 22, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +42, OrderDetailsType(OrderDetailType(23, 1), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 23, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +43, OrderDetailsType(OrderDetailType(13, 6), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 24, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +44, OrderDetailsType(OrderDetailType(5, 2), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 25, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +45, OrderDetailsType(OrderDetailType(5, 2), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 6, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +46, OrderDetailsType(OrderDetailType(5, 10), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 2, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +47, OrderDetailsType(OrderDetailType(10, 14), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 2, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +48, OrderDetailsType(OrderDetailType(11, 1), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 9, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +49, OrderDetailsType(OrderDetailType(31, 7), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 3, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +50, OrderDetailsType(OrderDetailType(30, 2), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 3, 6, TO_DATE('2023-01-11', 'YYYY-MM-DD') +60, OrderDetailsType(OrderDetailType(26, 2), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 2, 7, TO_DATE('2023-01-11', 'YYYY-MM-DD') +55, OrderDetailsType(OrderDetailType(24, 2), OrderDetailType(4, 2)));
INSERT INTO Orders VALUES (orders_seq.NEXTVAL, 4, 3, TO_DATE('2023-01-11', 'YYYY-MM-DD') +36, OrderDetailsType(OrderDetailType(8, 2), OrderDetailType(4, 2)));

-- Insert into tables end
---------------------------------------------------------------------------------------------------
--creating a procedure to automatically generate bill from orders table
CREATE OR REPLACE PROCEDURE GenerateBill(p_orderid IN NUMBER) IS
    v_totalamount NUMBER := 0;
    CURSOR medicine_cursor IS
        SELECT m.Price, od.Quantity
        FROM Medicine m, TABLE(SELECT o.OrderDetails FROM Orders o WHERE o.OrderID = p_orderid) od
        WHERE m.MedicineID = od.MedicineID;
BEGIN
      FOR medicine_rec IN medicine_cursor LOOP
        v_totalamount := v_totalamount + (medicine_rec.Price * medicine_rec.Quantity);
    END LOOP;
    INSERT INTO Bill (BillID, OrderID, TotalAmount, PaymentStatus)
    VALUES (bill_seq.NEXTVAL, p_orderid, v_totalamount, 'Unpaid');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
END GenerateBill;
/

-- loop across all the orders to get bill
BEGIN
    FOR order_rec IN (SELECT OrderID FROM Orders) LOOP
        GenerateBill(order_rec.OrderID);
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/
-----------------------------------------------------------------------------------------------------
-- creating a stored procedure to populate order medicine table
CREATE OR REPLACE PROCEDURE PopulateOrderMedicine AS
    c_defaultQuantity NUMBER := 2;  -- Default quantity for each medicine in an order
BEGIN
    FOR order_rec IN (SELECT OrderID FROM Orders) LOOP
        FOR med_rec IN (SELECT MedicineID FROM Medicine SAMPLE (30) WHERE ROWNUM <= 5) LOOP
            INSERT INTO OrderMedicine (OrderID, MedicineID, Quantity) 
            VALUES (order_rec.OrderID, med_rec.MedicineID, c_defaultQuantity);
        END LOOP;
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
END PopulateOrderMedicine;
/

EXECUTE PopulateOrderMedicine;
----------------------------------------------------------------------------------------------


