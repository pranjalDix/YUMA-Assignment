-- 1. Count the total number of Transactions

select COUNT(distinct TransactionID) as total_transactions from yuma.sales1;

-- 2. Count total number of Unique Customers

select COUNT(distinct CustomerID) as unique_customers from yuma.sales1;

-- 3. Total number of purchases by each customer

select CustomerID, COUNT(*) as 'Total Purchases' from yuma.sales1
group by CustomerID
order by CustomerID;

-- 4. Count the total number of Products

select COUNT(distinct ProductID) as Unique_Products from yuma.sales1;

-- 5. Total number of sales by each product Category

select ProductID, COUNT(*) as 'Sales Amount' from yuma.sales1
group by ProductID
order by COUNT(*) desc;

-- 6. Total quantities sold 

select SUM(Quantity) as Total_Quantities from yuma.sales1;

-- 7. Quantities sold for each product category

select ProductCategory, SUM(Quantity) as quantities from yuma.sales1
group by ProductCategory
order by quantities desc;

-- 8. Total trust points used by each customer

select CustomerID, SUM(TrustPointsUsed) as trust_points from yuma.sales1
group by CustomerID
order by trust_points desc;

-- 9. Total amount paid by each customer

select CustomerID, SUM(AmountToBePaid) as amount_paid from yuma.sales1
group by CustomerID
order by amount_paid desc;

-- 10. Max, Min, Average Discount applied

select MAX(DiscountApplied) as Maximum, MIN(DiscountApplied) as Minimum, AVG(DiscountApplied) as Average from yuma.sales1;

-- 11. Payment Method Transactions grouping

select PaymentMethod, COUNT(TransactionID) from yuma.sales1
group by PaymentMethod;

-- 12. Calculate the percentage for each Payment type

select PaymentMethod, COUNT(TransactionID) as transactions, 
(COUNT(TransactionID)/(select COUNT(*) from yuma.sales1))*100 as Percentage
from yuma.sales1
group by PaymentMethod;

-- 13. Count number of Transactions for each day

select DATE(TransactionDate) as t_date, COUNT(TransactionID)as t_id from yuma.sales1
group by t_date
order by t_id desc;

-- 14. Create Time Frame Groups and Calculate the total sales

select 
    case 
        when HOUR(TransactionDate) >= 0 and HOUR(TransactionDate) < 6 then '00:00-06:00'
        when HOUR(TransactionDate) >= 6 and HOUR(TransactionDate) < 12 then '06:00-12:00'
        when HOUR(TransactionDate) >= 12 and HOUR(TransactionDate) < 18 then '12:00-18:00'
        else '18:00-00:00'
    end as TimeFrame,
    SUM(AmountToBePaid) AS total_amount
from yuma.sales1
group by TimeFrame
order by total_amount desc;