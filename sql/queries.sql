-- JOIN query

SELECT 
    o.OrderID,
    c.CustomerID,
    c.PersonDetails.FirstName AS CustomerFirstName,
    c.PersonDetails.LastName AS CustomerLastName,
    e.EmployeeID,
    e.PersonDetails.FirstName AS EmployeeFirstName,
    e.PersonDetails.LastName AS EmployeeLastName,
    e.Position,
    b.BillID,
    b.TotalAmount,
    b.PaymentStatus
FROM 
    Orders o
INNER JOIN Customer c ON o.CustomerID = c.CustomerID
INNER JOIN Employee e ON o.EmployeeID = e.EmployeeID
LEFT JOIN Bill b ON o.OrderID = b.OrderID
WHERE 
    b.TotalAmount > 200;

-----------------------------------------------

-- UNION query
SELECT DISTINCT c.PersonDetails.FirstName AS FirstName, c.PersonDetails.LastName AS LastName
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
UNION
SELECT DISTINCT e.PersonDetails.FirstName, e.PersonDetails.LastName
FROM Employee e
JOIN Orders o ON e.EmployeeID = o.EmployeeID;
------------------------------------------------------------

-- nested table
SELECT 
    o.OrderID,
    od.MedicineID,
    m.Name AS MedicineName,
    m.Price AS PricePerUnit,
    od.Quantity,
    (m.Price * od.Quantity) AS TotalCost
FROM 
    Orders o, 
    TABLE(o.OrderDetails) od
JOIN 
    Medicine m ON m.MedicineID = od.MedicineID
ORDER BY 
    o.OrderID, od.MedicineID;
-------------------------------------------------------------------


-- temporal feature
CREATE OR REPLACE FUNCTION CalculateDaysRemaining(p_targetDate IN DATE) RETURN NUMBER IS
    v_currentDate DATE := CURRENT_DATE;
    v_daysRemaining NUMBER;
BEGIN
    v_daysRemaining := TRUNC(p_targetDate) - TRUNC(v_currentDate);
    RETURN v_daysRemaining;
END CalculateDaysRemaining;
/
DECLARE
    v_daysRemaining NUMBER;
BEGIN
    v_daysRemaining := CalculateDaysRemaining(TO_DATE('2024-12-31', 'YYYY-MM-DD')); -- target date
    DBMS_OUTPUT.PUT_LINE('Days remaining: ' || v_daysRemaining);
END;
/
SELECT 
    MedicineID, 
    Name, 
    ExpDate, 
    CalculateDaysRemaining(ExpDate) AS DaysRemaining
FROM 
    Medicine;
-----------------------------------------------------------------------------


--OLAP
SELECT 
    TO_CHAR(m.ExpDate, 'YYYY') AS MedicineExpYear,
    TO_CHAR(m.ExpDate, 'MM') AS MedicineExpMonth,
    TO_CHAR(o.DateOrdered, 'YYYY') AS OrderYear,
    TO_CHAR(o.DateOrdered, 'MM') AS OrderMonth,
    SUM(b.TotalAmount) AS TotalSales,
    COUNT(o.OrderID) AS NumberOfOrders
FROM 
    Medicine m
JOIN 
    OrderMedicine om ON m.MedicineID = om.MedicineID
JOIN 
    Orders o ON om.OrderID = o.OrderID
JOIN 
    Bill b ON o.OrderID = b.OrderID
GROUP BY 
    ROLLUP (TO_CHAR(m.ExpDate, 'YYYY'), TO_CHAR(o.DateOrdered, 'YYYY')),
    CUBE (TO_CHAR(m.ExpDate, 'MM'), TO_CHAR(o.DateOrdered, 'MM'));

