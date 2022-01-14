-- Shop Creation 
create table customers
(
    id int auto_increment primary key,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(100)
);

create table orders
(
    id int AUTO_INCREMENT PRIMARY key,
    order_date Date,
    amount decimal(18,2),
    customer_id int,
    FOREIGN key (customer_id) references customers(id)
);
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
       INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

-- Shop Basic Queries

SELECT * FROM customers, orders 
WHERE customers.id = orders.customer_id;

ELECT first_name, last_name, order_date, amount
FROM customers, orders 
    WHERE customers.id = orders.customer_id;
    
    
select first_name,  last_name, order_date, amount FROM customers join orders on customers.id = orders.customer_id;


--LEFTJOIN--

select first_name,  last_name, order_date, sum(amount) as total FROM customers join orders on customers.id = orders.customer_id
group by orders.customer_id order by total DESC;

select * from customers left join orders on customers.id = orders.customer_id;

select first_name,  last_name, ifnull( sum(amount), 0) as total FROM customers left join orders on customers.id = orders.customer_id
group by orders.customer_id order by total DESC;


--RightJoin--
select first_name,  last_name, ifnull( sum(amount), 0) as total FROM customers right join orders on customers.id = orders.customer_id
group by orders.customer_id order by total DESC;


-- Queries That do stuff to strings and count
select reverse('Why does my cat look at me with such hatered?');
select reverse(upper('Why does my cat look at me with such hatered?'));
select replace(title, ' ', '->') from books;
SELECT author_lname as last, reverse(author_lname) as backwards FROM books;
select concat(upper(author_fname), upper(author_lname)) from books;
select concat(title, ' was published in ', released_year, '.') as blurb from books;
select title, CHAR_LENGTH(title) AS 'char count' from books;
select 
concat(substring(title, 1 , 10), '...' )as 'short title'
,concat(author_fname, ',', author_lname) as auth,
concat(stock_quantity, ' in stock') as quantity  from books;

 select title, released_year from books where author_lname = 'lahiri' and released_year > 2000;
 
 select title, pages from books where pages BETWEEN 100 and 200;
 
 select author_lname, title from books where author_lname like "c%" or author_lname like 's%';
 
 select title ,
    CASE
        when title like '%stories%' then 'Shorts'
        when title = 'just kids' or title = 'the amazing adventures of kavalier & clay' then 'Memo'
        else 'novie'
    end as type
    from books;
    
    select author_lname, 
        case 
        when count(*) = 1 then '1 bookie'
        else concat(count(*), 'books')
        end as total
        from books
        group by author_lname;