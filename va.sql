
create database bookstore_db;
use bookstore_db;
create table books (book_id int primary key, title varchar(255), author varchar(255), price decimal(10, 2));
create table customers (customer_id int primary key, name varchar(255), email varchar(255), address varchar(255));
create table orders (order_id int primary key, customer_id int primary key, book_id int, quantity int, order_date date,
foreign key (customer_id) references customers(customer_id), foreign key (book_id) references books(book_id));
create table payments (payment_id int primary key, order_id int, payment_date date, amount decimal(10,2),
foreign key (order_id) references orders(order_id));
insert into books values(1, 'Book 1', 'Author 1', 10.99), (2, 'Book 2', 'Author 2', 12.99), (3, 'Book 3', 'Author 3', 9.99),
(4, 'Book 4', 'Author 4', 15.99), (5, 'Book 5', 'Author 5', 8.99);
insert into customers values(1, 'Customer 1', 'customer1@example.com', 'Address 1'), (2, 'Customer 2', 'customer2@example.com', 'Address 2'),
(3, 'Customer 3', 'customer3@example.com', 'Address 3'), (4, 'Customer 4', 'customer4@example.com', 'Address 4'), 
(5, 'Customer 5', 'customer5@example.com', 'Address 5');
insert into orders values (1, 1, 1, 2, '2023-06-01'), (2, 2, 3, 1, '2023-06-02'), (3, 3, 2, 3, '2023-06-03'),
(4, 4, 4, 2, '2023-06-04'), (5, 5, 5, 1, '2023-06-05');
insert into payments values (1, 1, '2023-06-02', 21.98), (2, 2, '2023-06-03', 9.99), (3, 3, '2023-06-04', 38.97), 
(4, 4, '2023-06-05', 31.98), (5, 5, '2023-06-06', 8.99);
use bookstore_db;
select * from customers;











