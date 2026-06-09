CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    registration_date DATE
) ENGINE=InnoDB;


CREATE TABLE books(
  id INT AUTO_INCREMENT PRIMARY KEY,
  book_name VARCHAR(100) NOT NULL,
  author VARCHAR(100) NOT NULL,
  price INT NOT NULL,
  stock INT DEFAULT 0
 )ENGINE=InnoDB;


CREATE TABLE orders(
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_ID INT NOT NULL,
  order_data DATE,
  status VARCHAR(50),
  FOREIGN KEY (customer_ID)
    REFERENCES customers(id)
)ENGINE=InnoDB;

CREATE TABLE order_items(
  order_id INT,
  book_id INT,
  quantity INT NOT NULL,
  PRIMARY KEY (order_id, book_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(id),

    FOREIGN KEY (book_id)
        REFERENCES books(id)
) ENGINE=InnoDB;

INSERT into customers (name, email, registration_date)
VALUES
("Alimkhanov Alimkhan", "alimkhan111106@icloud.com", "2019-02-22" ),
("Alimkhanova Robiya", "rabiya05@gmail.com", "2020-03-13"),
("Alimkhanova Umida", "umida@mail.ru", "2021-09-17"),
("Hakimbek Dias", "dias007@gmail.com", "2023-08-20"),
("Alibek Bekasyl", "beka0110@mail.ru", "2010-10-10");

INSERT into books (book_name, author, price, stock )
VALUES
("Абай жолы", 'Mukhtar Auezov', 3600, 10),
('Қан мен тер', 'Abdijapil NURPEYISOV', 4200, 6),
('Көшпенділер', 'Iliyas Esenberlin', 3000, 20),
('Менің атым Қожа', 'Berdibek Soqpaqbaev', 600, 10),
('Garry Potter', 'Джоан Роулинг', 4000, 8),
('Маленький принц', 'Антуан де Сент-Экзюпери', 5000, 18),
('Властелин колец', 'Джон Рональд Руэл Толкин', 800, 24),
('Война и мир', 'Лев Толстой', 3200, 14),
('Қара сөз', 'Abay Qunanbaev', 4600, 11),
('Ulpan', "Gabit", 500, 30);

INSERT INTO orders (customer_id, order_data, status)
VALUES
(1, '2020-10-20', 'paid'  ),
(2, '2026-02-1', 'delivered'),
(3, '2026-04-26','paid'),
(4, '2026-06-5', 'in processing');
 

INSERT into order_items (order_id, book_id, quantity)
VALUES
(1, 1, 2),
(2, 1, 3),

(3, 2, 1),
(4, 1, 2),

(1, 7, 3),
(3, 3, 8),

(2, 6, 1),
(4, 10, 2);

SELECT *
FROM books
WHERE price > 1000;
SELECT *
FROM books
WHERE price <1000
ORDER BY price DESC;
 
SELECT
    o.id AS order_id,
    c.name,
    o.order_data,
    o.status
FROM orders o
JOIN customers c
    ON o.customer_id = c.id;
    SELECT
    o.id AS order_id,
    c.name,
    b.book_name,
    oi.quantity
FROM orders o
JOIN customers c
    ON o.customer_id = c.id
JOIN order_items oi
    ON o.id = oi.order_id
JOIN books b
    ON oi.book_id = b.id
WHERE o.id = 1;

SELECT
    c.name,
    COUNT(o.id) AS order_count
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
GROUP BY c.id, c.name;


SELECT
    o.id AS order_id,
    SUM(b.price * oi.quantity) AS total_amount
FROM orders o
JOIN order_items oi
    ON o.id = oi.order_id
JOIN books b
    ON oi.book_id = b.id
GROUP BY o.id;


