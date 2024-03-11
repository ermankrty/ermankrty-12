CREATE DATABASE IF NOT EXISTS `kurtay_pizzaria_ristorante`;

USE `kurtay_pizzaria_ristorante`;

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(100) NULL,
  `phone_number` VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS `order` (
  `order_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date_time` DATETIME NOT NULL,
  FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`)
);

CREATE TABLE IF NOT EXISTS `pizza` (
  `pizza_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `pizza_name` VARCHAR(35) NOT NULL,
  `pizza_price` DECIMAL(4,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS `pizza_order`(
  `order_id` INT NOT NULL,
  `pizza_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  FOREIGN KEY (`pizza_id`) REFERENCES `pizza` (`pizza_id`)
);

INSERT INTO `customer` (`customer_name`, `phone_number`) VALUES
('Trevor Page', '226-555-4982'),
('John Doe', '555-555-9498');

INSERT INTO `order` (`customer_id`, `order_date_time`) VALUES
(1, '2014-09-10 09:47:00'),
(2, '2014-09-10 13:20:00'),
(1, '2014-09-10 09:47:00');

INSERT INTO `pizza` (`pizza_name`, `pizza_price`) VALUES
('Pepperoni & Cheese', 7.99),
('Vegetarian', 9.99),
('Meat Lovers', 14.99),
('Hawaiian', 12.99);

INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(2, 3, 2),
(3, 3, 1),
(3, 4, 1);

SELECT cust.customer_name AS 'Customer', 
       SUM(pizza.pizza_price * pizza_order.quantity) AS 'Total Spent'
FROM customer AS cust
JOIN `order` AS ord ON cust.customer_id = ord.customer_id
JOIN pizza_order ON pizza_order.order_id = ord.order_id
JOIN pizza ON pizza.pizza_id = pizza_order.pizza_id
GROUP BY cust.customer_id;

SELECT cust.customer_name AS 'Customer', 
       DATE(ord.order_date_time) AS 'Date',
       SUM(pizza.pizza_price * pizza_order.quantity) AS 'Total Spent'
FROM customer AS cust
JOIN `order` AS ord ON cust.customer_id = ord.customer_id
JOIN pizza_order ON pizza_order.order_id = ord.order_id
JOIN pizza ON pizza.pizza_id = pizza_order.pizza_id
GROUP BY cust.customer_id, DATE(ord.order_date_time);
