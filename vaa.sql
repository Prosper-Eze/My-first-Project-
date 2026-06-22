-- Retrieve all customer Details.
select * from customers;

-- Title and authors of all books.
select title, author from books;

-- Total number of books sold.
select sum(quantity) as total_books_sold from orders;

-- Total number of books sold.
select sum(amount) as total_revenue from payments;

-- Names of customers who have placed orders.
select distinct name from customers join orders on customers.customer_id = orders.customer_id;

-- Which customer made the highest payment?.
select name, amount from customers c join orders o on c.customer_id = o.customer_id join payments p on o.order_id = p.order_id
order by amount desc limit 1;

-- Which customer has made the most orders?
select name, count(order_id) as order_count from customers join orders on customers.customer_id = orders.customer_id
group by name order by order_count desc limit 1;

-- Names of customers who have NOT placed any orders.
select name from customers left join orders on customers.customer_id = orders.customer_id where orders.order_id is null;

-- Which book has the highest price?
select title, price from books order by price desc limit 1;

-- How many books were sold to each customer?
select name, sum(quantity) as books_bought from customers left join orders on customers.customer_id = orders.customer_id group by name;

-- Trigger: Prevent inserting a payment with a negative amount
DELIMITER //
CREATE TRIGGER before_payment_insert
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
    IF NEW.amount < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment amount cannot be negative';
    END IF;
END //
DELIMITER ;
-- Trigger: Automatically update a log (if you had an audit table) or just adjust data
DELIMITER //
CREATE TRIGGER after_payment_update
AFTER UPDATE ON payments
FOR EACH ROW
BEGIN
    -- This is where you would usually log that a price was changed
END //
DELIMITER ;

-- Trigger: Prevent deletion of an order if it has an associated payment
DELIMITER //
CREATE TRIGGER before_order_delete
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    DECLARE payment_exists INT;
    SELECT COUNT(*) INTO payment_exists FROM payments WHERE order_id = OLD.order_id;
    IF payment_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete order with existing payment';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetBooksByAuthor(IN author_name VARCHAR(255))
BEGIN
    SELECT * FROM books WHERE author = author_name;
END //
DELIMITER ;

-- To run it:
CALL GetBooksByAuthor('Author 1');

-- Create a new user (change 'password123' to your choice)
CREATE USER 'bookstore_staff'@'localhost' IDENTIFIED BY 'password123';

-- Grant SELECT, INSERT, and ALTER privileges
GRANT SELECT, INSERT, ALTER ON bookstore_db.* TO 'bookstore_staff'@'localhost';

-- Apply the changes
FLUSH PRIVILEGES;

-- To Backup (Run in terminal/cmd)
-- mysqldump -u root -p bookstore_db > bookstore_backup.sql

-- To Restore (Run in terminal/cmd)
-- mysqldump -u root -p bookstore_db < bookstore_backup.sql

-- Whats the difference between SQL and MySQL.
/* SQL is the language. It is the set of commands (like SELECT, INSERT, UPDATE) used to talk to databases.
MySQL is the software. It is the actual database program that stores your data and understands the SQL language.
Think of it like a smartphone: MySQL is like the Android Phone, and SQL is The touchscreen Gestures*/

-- Why are triggers created in a database?
/* Triggers are created to act as the automated security guards, personal assistants, and auditors of your database. 
Triggers take the human error out of the equation by running automatically behind the scenes*/

-- What is the different between a Primary key and a Foreign Key?.
/*Primary Key (PK): The unique ID for a table. Every single row must have one, and it ensures no two records are exactly 
alike (like your national ID card or a student matriculation number).
Foreign Key (FK): A link to another table. It points directly to the Primary Key of a different table to connect the two (like an Order 
record storing a Customer's ID to show who bought the item).*/

-- What is the difference between a DBMS and RDBMS?.
/* DBMS (Database Management System): A general software system used to store and manage data. It typically stores data as flat files or 
a hierarchical structure, where relationships between data points aren't strictly enforced.
RDBMS (Relational Database Management System): An advanced type of DBMS that stores data specifically in structured tables (rows and 
columns). It uses keys (Primary Keys and Foreign Keys) to create explicit relationships between those tables.
Every RDBMS is a DBMS, but not every DBMS is an RDBMS.*/


