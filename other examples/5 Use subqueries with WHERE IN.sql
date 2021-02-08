SELECT product_cd, cust_id, avail_balance
FROM account 
WHERE product_cd IN (SELECT product_cd FROM product where product_type_cd = 'ACCOUNT');
