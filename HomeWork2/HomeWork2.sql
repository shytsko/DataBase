-- -------- Домашнее задание №1 ----------------------------------

#1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. Заполните БД данными

CREATE DATABASE mobileshop;

USE mobileshop;

drop TABLE phones;

CREATE TABLE phones (
	phone_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(50) NOT NULL,
    vendor VARCHAR(20) NOT NULL,
    os VARCHAR(20) NOT NULL,
    display_size DECIMAL(4,2) NOT NULL,
    cpu_type VARCHAR(50) NOT NULL,
    cpu_speed DECIMAL(4,2) NOT NULL,
    ram INTEGER,
    rom INTEGER,
    count INTEGER NOT NULL DEFAULT 0,
    price DECIMAL(16,2) NOT NULL DEFAULT 0.0
);

INSERT phones(model, vendor, os, display_size, cpu_type, cpu_speed, ram, rom, count, price)
VALUES
("Mate 50 Pro DCO-LX9", "Huawei", "Android 11", 6.74, "Qualcomm Snapdragon 8+ Gen1", 3.2, 8, 256, 10, 3499.00),
("X8", "HONOR", "Android 11", 6.7, "Qualcomm Snapdragon 680", 2.4, 6, 128, 5, 749.00),
("Galaxy S22 5G", "Samsung", "Android 12", 6.1, "Exynos 2200", 2.8, 8, 128, 1, 2045.00),
("iPhone 11 64GB", "Apple", "iOS 13", 6.1, "Apple A13 Bionic", 2.65, 4, 64, 1, 1399.00),
("Redmi 10", "Xiaomi", "Android 11", 6.5, "Mediatek Helio G88", 2.0, 6, 128, 3, 555.00),
("Galaxy A32", "Samsung", "Android 11", 6.4, "Mediatek Helio G80", 2.0, 4, 64, 8, 699.00);

SELECT * FROM phones;

#2. Выведите название, производителя и цену для товаров, количество которых превышает 2

SELECT model, vendor, price FROM phones WHERE count>2;

#3. Выведите весь ассортимент товаров марки “Samsung”

SELECT * FROM phones WHERE  vendor="Samsung";


-- -------- Домашнее задание №2 ----------------------------------

# 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными

CREATE TABLE sales 
(
	sale_id INT PRIMARY KEY AUTO_INCREMENT,
	phone_id INT NOT NULL,
	count INT NOT NULL,
	FOREIGN KEY (phone_id) REFERENCES phones (phone_id)
);

INSERT sales(phone_id, count)
VALUES (6, 30), (1, 16), (5, 100), (4, 11), (6, 70), (3, 1000), (4, 80), (2, 66), (4, 88), (6, 200);

# 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.

SELECT sales_group, GROUP_CONCAT(model SEPARATOR ', ') AS models
FROM
	(SELECT phone_id, model, sales_total,
		(CASE
			WHEN sales_total<100 THEN "Мало продаж"
            WHEN sales_total>=100 AND sales_total<=300 THEN "Много продаж"
            ELSE "Очень много продаж"
        END) AS sales_group
	FROM
		(SELECT sales.phone_id, CONCAT(phones.vendor, " ", phones.model) AS model, SUM(sales.count) AS sales_total
		FROM sales, phones
		WHERE phones.phone_id = sales.phone_id
		GROUP BY phone_id) AS temp1) AS temp2
GROUP BY sales_group;


# 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE

CREATE TABLE orders
(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
	create_data TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_data TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	customer_name VARCHAR (100) NOT NULL,
	order_status INT NOT NULL DEFAULT 1 
);

INSERT orders(customer_name)
VALUES ("Вася Пупкин"), ("Билл Гейтс"), ("Иван Иванов"), ("Чингачгук"),
	("Карлсон"), ("Илон Маск"), ("Папа Карло"), ("Буратино"), ("Артемон");

UPDATE orders SET order_status=2 WHERE order_id=1;
UPDATE orders SET order_status=3 WHERE order_id=4;
UPDATE orders SET order_status=4 WHERE order_id=2;
UPDATE orders SET order_status=0 WHERE order_id=8;
UPDATE orders SET order_status=-1 WHERE order_id=6;

SELECT order_id, create_data, update_data, customer_name, 
(CASE
	WHEN order_status=1 THEN "Заказ формируется"
    WHEN order_status=0 THEN "Заказ завершен"
    WHEN order_status=2 THEN "Заказ подтвержден"
    WHEN order_status=3 THEN "Заказ оплачен"
    WHEN order_status=4 THEN "Заказ в доставке"
    WHEN order_status=-1 THEN "Заказ отменен"
    ELSE "Не верный статус"
END) AS full_status
FROM orders;

# 4. Чем NULL отличается от 0?

-- NULL это пустое значение (в поле ничего не храниться), а 0 это конкретное значение полей числовых типов