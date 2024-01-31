DROP TABLE IF EXISTS GOLDUSERS_SIGNUP;


CREATE TABLE GOLDUSERS_SIGNUP(USERID
INT,GOLD_SIGNUP_DATE DATE);


INSERT INTO GOLDUSERS_SIGNUP(USERID,GOLD_SIGNUP_DATE)
VALUES (1,'09-22-2017'),(3,'04-21-2017')


DROP TABLE IF EXISTS USERS;
CREATE TABLE USERS(USERID INT,SIGNUP_DATE DATE);


INSERT INTO USERS(USERID,SIGNUP_DATE)
VALUES(1,'1-09-2014'),(2,'01-15-2015'),(3,'04-11-2014');


DROP TABLE IF EXISTS SALES;
CREATE TABLE SALES(USERID INT,CREATED_DATE DATE,PRODUCT_ID INT);


INSERT INTO SALES(USERID,CREATED_DATE,PRODUCT_ID)
VALUES(1,'04-19-2017',2),
(3,'12-18-2019',1),
(2,'07-20-2020',3),
(1,'10-23-2019',2),
(1,'03-19-2018',3),
(2,'12-20-2016',2),
(1,'11-09-2016',1),
(1,'05-20-2016',3),
(2,'09-24-2017',1),
(1,'03-11-2017',2),
(1,'03-11-2016',1),
(3,'11-10-2016',1),
(3,'12-07-2017',2),
(3,'12-15-2016',2),
(2,'11-08-2017',2),
(2,'09-10-2018',3);


DROP TABLE IF EXISTS PRODUCT;
CREATE TABLE PRODUCT(PRODUCT_ID
INT,PRODUCT_NAME TEXT,PRICE INT);


INSERT INTO PRODUCT(PRODUCT_ID,PRODUCT_NAME,PRICE)
VALUES
(1,'P1',980),
(2,'P2',870),
(3,'P3',330);


SELECT * FROM SALES
SELECT * FROM PRODUCT
SELECT * FROM GOLDUSERS_SIGNUP
SELECT * FROM USERS


1   WHAT IS THE TOTAL AMOUNT EACH CUSTOMER SPENT ON ZOMATO ? 

SELECT A.USERID,SUM(B.PRICE) TOTAL_AMT_SPENT FROM SALES A INNER JOIN PRODUCT B ON A.PRODUCT_ID=B.PRODUCT_ID GROUP BY A.USERID


2   HOW MANY DAYS HAS EACH CUSTOMER VISITED ZOMATO ?

SELECT USERID,COUNT(DISTINCT CREATED_DATE)  DISTINCT_DAYS FROM SALES GROUP BY USERID;


3   WHAT WAS THE FIRST PRODUCT PURCHASED BY EACH CUSTOMER ?

select * from
(SELECT *,RANK() OVER (PARTITION BY USERID ORDER BY CREATED_DATE) RNK FROM SALES) a WHERE RNK=1


4    what is the most purchased item on the menu and how many times was it purchased by all customers ?

select USERID,COUNT(product_id) cnt from SALES where PRODUCT_ID=(select top 1 PRODUCT_ID from SALES group by PRODUCT_ID order by COUNT(product_id)desc) group by USERID

5    which item was the most popular for each customer ?
select * from 
(select *,RANK()over(partition by userid order by cnt desc) rnk from
(select USERID,product_id,count(product_id) cnt from sales group by USERID,PRODUCT_ID)a)b
where rnk=1

6    which item was purchased first by the customer after they became a member ?

select * from
(select c.*,RANK()over(partition by userid order by created_date)rnk from 
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from SALES a inner join
GOLDUSERS_SIGNUP b on a.USERID=b.USERID and CREATED_DATE>=GOLD_SIGNUP_DATE)c)d where rnk=1;



7    which item was purchased just before the customer became a member ?

select * from
(select c.*,RANK()over(partition by userid order by created_date desc)rnk from 
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from SALES a inner join
GOLDUSERS_SIGNUP b on a.USERID=b.USERID and CREATED_DATE<=GOLD_SIGNUP_DATE)c)d where rnk=1;




8     what is the total orders and amount spent for each member before they became a member ?

select USERid,count (created_date) order_purchased,sum(price) total_amt_spent from
(select c.*,price from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a inner join
GOLDUSERS_SIGNUP b on a.USERID=b.USERID and CREATED_DATE<=GOLD_SIGNUP_DATE)c inner join PRODUCT d on c.PRODUCT_ID=d.PRODUCT_ID)e
 group by userid;



 9    rank all the transaction of the customers

 select*,RANK()over(partition by userid order by created_date)rnk from SALES;




