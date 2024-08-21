# 1. Delete Empty cells from the datasource in the given columns

delete from yuma.sales1
where PricePerUnit = '' or TotalAmount = '' or CustomerID = '' or TransactionDate = '';

# 2. Changing datatype of TransactionDate column

alter table yuma.sales1
modify column TransactionDate DATETIME;

# 3. Updating ProductID column 

update yuma.sales1
set ProductID = case
    when ProductCategory = 'Grocery' then 2001
    when ProductCategory = 'Toys' then 2002
    when ProductCategory = 'Home Decor' then 2003
    when ProductCategory = 'Fashion' then 2004
    when ProductCategory = 'Electronics' then 2005
    else productID 
end;

# 4. Updating Negative quantity values

update yuma.sales1
set Quantity = abs(Quantity)
where Quantity < 0;

# 5. Drop rows where quantity values is 0

delete from yuma.sales1
where Quantity = 0;

# 6. Recalculate TotalAmount column to maintain consistent data

update yuma.sales1
set TotalAmount = PricePerUnit * Quantity;

# 7. Updating Negative TrustPointsUsed values

update yuma.sales1
set TrustPointsUsed = abs(TrustPointsUsed)
where TrustPointsUsed < 0;

# 8. Updating nan values for PaymentMethod

update yuma.sales1
set PaymentMethod = CASE
    when PaymentMethod = 'nan' 
    then
        case
            when TrustPointsUsed != 0 then 'Trust Points'
            else 'Credit Card/Cash'
        end
    else PaymentMethod
end;

# 9. Total Amount to be paid by the Customers

alter table yuma.sales1
add column AmountToBePaid DECIMAL(10, 2);

update yuma.sales1
set AmountToBePaid = TotalAmount * (1 - IFNULL(DiscountApplied, 0) / 100);