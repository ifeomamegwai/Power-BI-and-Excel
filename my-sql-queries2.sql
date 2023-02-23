--SELECT STATEMENT| used to query(retrieve) data from tables in database. SELECT statement has many clauses.
--i. SELECT DISTINCT rows using the DISTINCT OPERATOR
--ii. sort rows using ORDER BY clause
--iii. filter rows using WHERE clause
--iv. select a subset of rows from a table using LIMIT clause
--v group rows into groups by using GROUP BY clause
--vi filter groups using HAVING clause
--vii join with other tables using JOIN

--SELECT STATEMENT TO SELECT ALL COLUMNS IN ACTOR TABLE
SELECT *
FROM actor

--SELECT STATEMENT TO SELECT NAMED COLUMNS FROM ACTOR TABLE
SELECT first_name, last_name
FROM actor


--SELECT COLUMNS FROM CUSTOMER TABLE. e.g We want to send out a promotional email to our existing customers. We would need their emails, first_name and last_name.

SELECT email, first_name, last_name
FROM customer

--SELECT DISTINCT: USED TO EXTRACT UNIQUE VALUES ONLY, IT HELP USE FIND THE UNIQUE VALUES IN A TABLE AND REMOVE DUPLICATES
--we want to know the different release year that is in the film table.
SELECT DISTINCT release_year
FROM film

--SELECT DISTINCT RATING FROM FILM TABLE
SELECT DISTINCT rating
FROM film

--LIMIT CLAUSE: limit the number of rows i get back after a query
SELECT *
FROM customer
LIMIT 10

--ORDER BY CLAUSE: allows you sort the rows returned by the SELECT statementin ascending or descending order based on specified criteria
SELECT first_name, last_name, email
FROM customer
ORDER BY first_name ASC --NB ASC means Ascending order and DESC means descending order

--USE THE LIMIT AND ORDER BY TOGETHER. get the customer id for the top highest amounts. Amounts and customer_id points us to the payment table
--REMEMBER, ALWAYS USE ORDER BY B/4 LIMIT, LIMIT CLAUSE SHOULD ALWAYS COME LAST
SELECT customer_id, amount
FROM payment
ORDER BY amount DESC
LIMIT 10

--get the title of the movies with film IDs 1-5. This points us to the film table
SELECT film_id, title
FROM film
ORDER BY film_id ASC
LIMIT 5

--WHERE CLAUSE |USED TO SELECT ROWS THAT SATISFY A SPECIFIED CONDITION. The WHERE clause appears right after the FROM clause of the SELECT statement. The WHERE clause uses the condition to filter the rows returned from the SELECT statement.
--WHERE clause uses the following operators: =, <>/!=, >, <, >=, <=, AND, OR, BETWEEN, IN, LIKE, NOT
-- eg.1.SELECT ALL CUSTOMERS WHOSE NAMES ARE JAMIE. HERE WE USE THE = OPERATOR
SELECT first_name, last_name
FROM customer
WHERE first_name ='Jamie'

--e.g.2 a customer is late on their movie return. I know his address is '259 Ipon Drive' I want to call him to let me know. can you get me the phone number of the person who lives at '259 Ipoh Drive'
SELECT phone
FROM address
WHERE address = '259 Ipoh Drive'

--eg.3 A customer wants to know what the movie "Outlaw Hanky" is about. Could you give them the description for the movie.
SELECT description, title
FROM film
WHERE title = 'Outlaw Hanky'

--USING WHERE with AND
--e.g. 1. All records of the customers whose first_name is Jamie and last_name is rice. we will use the AND logical operator to combine the 2 conditions
SELECT first_name, last_name
FROM customer
WHERE first_name = 'Jamie' AND last_name = 'Rice'

--e.g.2. A customer forgot her wallet at our store. we need to track down their email to reach out to reach to him/her. Fortunately, we located an ID card in the wallet. Her name is Nancy Thomas. use SQL to get her email.
SELECT email
FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas'

--Using WHERE with OR together
--I want to know who paid the rental rate which amount is less than 1USD OR greater than 8USD. here use the OR operator
SELECT customer_id, amount
FROM payment
WHERE amount <1 OR amount >8

--let us see where amount is not equal 4.99. there are 2 ways
SELECT customer_id, amount
FROM payment
WHERE amount <> 4.99

--OR
SELECT customer_id, amount
FROM payment
WHERE amount != 4.99

--BETWEEN OPERATOR| selects value within a given range. the values can be numbers, text ior dates. Both the begin and end values are inclusive.
--works with AND
SELECT customer_id, rental_id, amount
FROM payment
WHERE amount BETWEEN 8 AND 9

--BETWEEN operator can be rewritten using the >= , <= operators
SELECT customer_id, rental_id, amount
FROM payment
WHERE amount >= 8 AND amount <=9

--example 2
SELECT customer_id, rental_id, amount
FROM payment
WHERE amount NOT BETWEEN 8 AND 9

--OR
SELECT customer_id, rental_id, amount
FROM payment
WHERE amount <>8 AND amount <> 9

--OR
SELECT customer_id, rental_id, amount
FROM payment
WHERE amount != 8 AND amount != 9

--eg. 3 show payment that occurred between February/1/2007 and March/1/2007
SELECT payment_date, amount
FROM payment
WHERE payment_date BETWEEN 'February/1/2007' AND 'March/1/2007'

--IN OPERATOR| this allows you to specify multiple values in a WHERE clause. 
--the IN operator is a shorthand for multiple OR conditions.
--eg. supposed I want to know the rental_id of customer_id 1 and 2 and dates they returned their DVDs
SELECT customer_id, rental_id, return_date
FROM rental
WHERE customer_id IN(1,2) --NB, U CAN ALSO USE THE OR OPERATOR HERE
ORDER BY customer_id ASC

--EXAMPLE 2
--i want to see all the details of payments that are either 7.99 or 8.99USD
SELECT *
FROM payment
WHERE amount IN(7.99, 8.99)

--NOT IN statement| used to show values that does not match a list of values.
--e.g. supposed I want to know the rental_id of customer_id that are not 1 and 2 and dates they returned their DVDs
SELECT customer_id, rental_id, return_date
FROM rental
WHERE customer_id NOT IN (1,2)
ORDER BY customer_id ASC;


--LIKE OPERATOR & WILDCARD CHARACTERS
--the LIKE operator is used to fetch information from a database where one remembers some part of the information sought using Wlidcard characters.
--There are  2 wildcard characcters: 1. Percent sign(%): used when you are not sure of how many characters comes before or after the character you can remember. stands for many charcters.,
--2. Underscore sign(_): used when you are sure of the number of characters that should be returned. This stands for one character or number.
--e.g. of % wildcard character:I want to see first_name of customers that ends with 'er'
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE '%er'

--I want to see first_name of customers that begins with 'Jen'
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'Jen%'
--'Jen%' and '%er' are referred to as patterns and the % is used to indicate the position where 'Jen' or 'er' will be in our return value; alternatively, you can say that the % stays where the value you are looking for will be placed when found.

--more examples: list the actors with first name that starts with the letter P
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'P%'

-----OR, since you are listing all the actors, you can also use the codes below to achieve same result, but this time SQL will list all the columns in that table. this won't be ideal for very large dataset with lots of columns.
SELECT *
FROM actor
WHERE first_name LIKE 'P%'

--How many actors have a first name that starts with the letter P?
SELECT COUNT(*)
FROM actor
WHERE first_name LIKE 'P%'

--E.G. of underscore(_) wildcard: I want to see the first_name of customers that has 'her' as the second alphabets. it means that one single alphabet comes first before 'her' and we are not sure how many characters come after 'her'
SELECT first_name , last_name
FROM customer
WHERE first_name LIKE '_her%';
--we can also have '__er%', it means two alphabets comes before the ones we can remember, and there are also characters after the ones we know.

--NOT LIKE operator| this is the opposite of the LIKE operator
--eg
SELECT first_name, last_name
FROM customer
WHERE first_name NOT LIKE 'Jen%'

--ILIKE OPREATOR| This does everything that LIKE operator does, the only difference is that while LIKE operator is case sensitive, ILIKE is not.
--e.g the following two ILIKE codes below will still run and return output despite the way i wrote Jen; however, the 2nd code will not return out put with LIKE because LIKE is case sensitive and will not see jeN in the table
SELECT first_name, last_name
FROM customer
WHERE first_name ILIKE 'Jen%'

SELECT first_name, last_name
FROM customer
WHERE first_name ILIKE 'jeN%'



--AGGREGATE FUNCTIONS| SUM, AVG, COUNT, MIN, MAX
--find total amount
SELECT SUM(amount)
FROM payment; 
--find how many entries/to get the number of items i.e. count
SELECT COUNT(amount)
FROM payment;
--find mean value i.e. average
SELECT AVG(amount)
FROM payment;
--find minimum value
SELECT MIN(amount)
FROM payment;
--find maximum amount
SELECT MAX(amount)
FROM payment;

--GROUP BY| This clause divides the rows returned from SELECT statement into groups and for each of those groups, we can apply an aggregate function eg. SUM() & COUNT()
--in other words, we usually use our aggregate functions with our GROUP BY clause;
--eg.1
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY customer_id ASC
--NB you group by a column not within the aggregate function, that's why we grouped by customer_id and not amount

--NB if you just want the sum for just a particular customer, then you can add the WHERE clause directly under FROM clause eg. WHERE customer_id = 314 , before you add the GROUP BY clause
--eg 2
SELECT customer_id, SUM(amount)
FROM payment
WHERE customer_id = 314
GROUP BY customer_id

--eg. 3
SELECT staff_id, COUNT(payment_id)
FROM payment
GROUP BY staff_id

--e.g 4 We have two staff members with Staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments.
--How many payments did each staff member handle? And how much was the total amount processed by each staff member?
SELECT staff_id, COUNT (amount), SUM(amount)
FROM payment
GROUP by staff_id
--in above example b/c I already knew that there are only staff_id 1 & 2 in my payment table that is why I did not add the where clause;
--if not the where clause thus: WHERE staff_id IN(1,2) under FROM clause.

--e.g 5 Corporate headquarters is auditing our store. They want to know the average replacement cost of movies by rating
SELECT rating, AVG( replacement_cost)
FROM film
GROUP BY rating;

--e.g 6 We want to send coupons to the 5 customers who have spent the most amount of money
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5

--HAVING CLAUSE: only used in conjuction with GROUP By clause to filter group rows only and not normal row. used only where the condition is related to the GROUP BY and used on the aggregate function.
--NB, HAVING clause is used in numeric fields and aggregate function after using the Group BY clause.
--eg 1, we want to get the customer_id who spent above $200 
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM (amount) > 200

--e.g2, we want to know the average rental rate for rating type R, PG, G. use HAVING clause to filter AVG rental rate above 3USD
SELECT rating, AVG(rental_rate)
FROM film
WHERE rating IN('R', 'PG', 'G')
GROUP BY rating
HAVING AVG (rental_rate) > 3

--e.g. 3 We want to know what customers are eligible for our platinum credit card. The requirements are that the customer has at least a total of 40 transaction payments. What customers are eligible for the credit card?
SELECT customer_id, COUNT(payment_id)
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id) >=40

--e.g. 4 When Grouped by rating, what movie ratings have an average rental duration of more than 5 days?
SELECT rating, AVG(rental_duration)
FROM film
GROUP BY rating
HAVING AVG(rental_duration)> 5

--eg 5, Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.
SELECT customer_id, SUM(amount)
from payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount)>=110

--SEQUENCE FOR USING ALL CLAUSES
--SELECT>>FROM>>WHERE>>GROUP BY>>HAVING>>ORDER BY>>LIMIT


--GENERAL CHALLENGE
--1.  How many films begin with the letter J?
SELECT COUNT(*)
FROM film
WHERE title LIKE 'J%';

--2. What customer has the highest customer ID number whose name starts with an ‘E’ and has an address ID lower than 500?
SELECT first_name, last_name, address_id, customer_id
FROM customer
WHERE first_name LIKE 'E%' AND address_id < '500'
ORDER BY customer_id DESC

--3. How many films have the word Truman somewhere in the title?
SELECT COUNT(*)
FROM film
WHERE title LIKE '%Truman%'; --NB LIKE statement is very case sensitive, so if you are not certain about the case of the phrase in the quote with the wild character, please use ILIKE instead of LIKE.

--4. How many payment transactions were greater than $5.00?
SELECT COUNT(amount)
FROM payment
WHERE amount > 5;

--5. How many unique districts are our customers from?
SELECT COUNT(DISTINCT(district))
FROM address

--6. Retrieve the list of names for those distinct districts from the previous question 5 above
SELECT DISTINCT(district)
FROM address

--7.How many films have a rating of R and a replacement cost between $5 and $15?
SELECT COUNT(*)
FROM film
WHERE rating = 'R'
AND replacement_cost BETWEEN 5 AND 15

--ALIAS
--The AS statement helps us assign alias to column names to make it easy for readers to understand output
--e.g
SELECT customer_id, COUNT(payment_id)AS no_of_payment
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id) >=40

--eg. 2
SELECT customer_id, SUM(amount)AS total_sum
from payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount)>=110

--JOIN STATEMENT| the Join statement is used to combine columns from one or more tables based on the values of common columns between related tables.
--The common columns are typically the primary key column of the first table which is a foreign key column in the 2nd table.
--JOIN statement is followed by an ON statement which we use to specify a JOIN condition
--syntax SELECT column 1 of table1, column 2 of table 2...
--       FROM table 1
--       JOIN table 2
--       ON table1.column_pkey=table2.column_fkey
--After the JOIN is effected, the output will be a single table.
--4 types of JOIN. 1. INNER JOIN. 2. FULL OUTER JOIN. 3. LEFT JOIN 4. RIGHT JOIN
--INNER JOIN is like a venn diagram, the inner join selects records that have matching values in both tables. u get a data output values in those tables that interset
--you can only join two tables if the have primary/foreign keys in common. eg. customer_id in customer table to connect to customer_id in payment table to join the two tables together and return the columns you want from both table
--eg. 1. I have a payment table that contains payment_id, customer_id, staff_id, rental_id, amount and payment_date column but I want to see the first_name and last_name of the customers that made those payments.
--I can get these first_name & last_name from customer table, so I need to JOIN the two tables the columns both table have in common(which is a primary key (customer_id)in customer table connecting to now foreign key (customer_id) in payment table)
SELECT payment_id, customer_id, first_name, last_name, rental_id, amount, payment_date
FROM customer AS a
JOIN payment AS b
ON a.customer_id = b.customer_id
--running above code as it is returns an error saying customer_id is ambiguous, this is b/c we have customer_id in both table and SQL is confused as to which of them we call, to solve this we need to affix the table alias of one of the table to customer_id in the SELECT clause thus:
SELECT payment_id, a.customer_id, first_name, last_name, rental_id, amount, payment_date
FROM customer AS a
JOIN payment AS b
ON a.customer_id = b.customer_id

--eg. 2 Let’s fetch the addresses of all the customers in the customer table. Hint:Use the INNER JOIN to join the address and customer table. Return only the important fields; customer_id, first_name, last_name address_id and address
SELECT customer_id, first_name, last_name, a.address_id, address
FROM customer AS a
JOIN address AS b
ON a.address_id = b.address_id


--UNION operator| combines result sets of two or more  SELECT statements into a single result set.
--The following illustrates the syntax of the UNION operator that  combines result sets from two queries:
--SYNTAX:
--SELECT column1, column2
--FROM table1
--UNION
--SELECT column1, column2
--FROM table2

--There are two rules to follow: 1. Both queries must return the same number of columns. 
--2.The corresponding columns in the queries must have  compatible data types. for instance, if your first column in your first select statement is of integer datatype, then your first column in your 2nd select statement must also be of integer datatype.

--The UNION operator removes all duplicates rows unless the UNION ALL is used.
--to illustrate UNION we are going to create and populate two new tables in our First SQL Class database using the queries below
CREATE TABLE top_rated_films(
	title VARCHAR NOT NULL,
	release_year SMALLINT
);


CREATE TABLE most_popular_films(
	title VARCHAR NOT NULL,
	release_year SMALLINT
);

INSERT INTO 
   top_rated_films(title,release_year)
VALUES
   ('The Shawshank Redemption',1994),
   ('The Godfather',1972),
   ('12 Angry Men',1957);

INSERT INTO 
   most_popular_films(title,release_year)
VALUES
   ('An American Pickle',2020),
   ('The Godfather',1972),
   ('Greyhound',2020);

SELECT *
FROM top_rated_films
UNION
SELECT *
FROM most_popular_films

--when UNION operator is used, one single table with expanded rows and not expanded columns, in other words, the numbers of columns remains the same from what it was before the UNION

--How to connect PowerBI to your postgres database:
--Open Powe BI>>Get data>>postgreSQL database>>connect>>server(use localhost:2011 this is my pgadmin 4 host name and port)>>Database(use DVD Rentals)>>ok>>User name(use postgres)>>Password(use your pgAdmin4 password)>>connect>>encripton support(ok)
--congratulation your Power BI is now connected to the postgreSQl database, u can begin your ETL, modelling and visualization

--Alternatively, you can just merely download your SQL query output and save it in your computer as csv files, with that, u don't have to connect your power BI to your database anymore, you merely fetch your data from your computer.
--You can also save your queries by either copying them and pasting them in your microsoft words and saving it in your computer; or you can click of the 'save'icon on top of your query tool environment, select your destination and click on 'create'














