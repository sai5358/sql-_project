## ZOMATO DATA ANALYSIS

### INTRODUCTION

THIS IS AN END TO END PROJECT ON ZOMATO DATA ANALYSIS USING SQL

### SKILLS APPLIED
SQL
- WINDOW FUNCTIONS
- AGGREGATION
- JOINS

### QUESTIONS

1) WHAT IS THE TOTAL AMOUNT EACH CUSTOMER SPENT ON ZOMATO ?
2) HOW MANY DAYS HAS EACH CUSTOMER VISITED ZOMATO ?
3) WHAT IS THE FIRST PRODUCT PURCHASED BY EACH CUSTOMER ?
4) WHAT IS THE MOST PURCHASED ITEM ON THE MENU AND HOW MANY TIMES WAS IT PURCHASED BY ALL CUSTOMERS ?
5) WHICH ITEM WAS THE MOST POPULAR FOR EACH CUSTOMER ?
6) WHICH ITEM WAS PURCHASED FIRST BY THE CUSTOMER AFTER THEY BECAME A MEMBER ?
7) WHICH ITEM WAS PURCHASED JUST BEFORE THE CUSTOMER BECAME A MEMBER ?
8) WHAT IS THE TOTAL ORDERS AND AMOUNT SPENT FOR EACH MEMBER BEFORE THEY BECAME A MEMBER ?
9) RANK ALL THE TRANSACTIONS OF THE CUSTOMERS ?

### SOME INTERESTING QUERIES

7) which item was purchased just before the customer became a member ?

select * from
(select c.*,RANK()over(partition by userid order by created_date desc)rnk from 
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from SALES a inner join
GOLDUSERS_SIGNUP b on a.USERID=b.USERID and CREATED_DATE<=GOLD_SIGNUP_DATE)c)d where rnk=1;

8) what is the total orders and amount spent for each member before they became a member ?

select USERid,count (created_date) order_purchased,sum(price) total_amt_spent from
(select c.*,price from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a inner join
GOLDUSERS_SIGNUP b on a.USERID=b.USERID and CREATED_DATE<=GOLD_SIGNUP_DATE)c inner join PRODUCT d on c.PRODUCT_ID=d.PRODUCT_ID)e
 group by userid;


### INSIGHTS
- CUSTOMER 1 SPENT MORE COMPARE TO OTHER 2 CUSTOMERS
- CUSTOMER 1 HAS THE MOST VISITED CUSTOMER ON ZOMATO
- PRODUCT_ID 2 IS THE MOST PURCHASED ITEM ON THE MENU
- BEFORE THEY BECOMING THE MEMBER ON ZOMATO THE TOTAL ORDERS IS 5 AND 3 AND TOTAL AMOUNT SPENT ON EACH CUSTOMER IS 4030 AND 1850.



