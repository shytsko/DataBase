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


