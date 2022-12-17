# 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными

CREATE TABLE sales 
(
sale_id INT PRIMARY KEY AUTO_INCREMENT,
phone_id INT NOT NULL,
count INT NOT NULL,
FOREIGN KEY (phone_id) REFERENCES phones (phone_id)
);

INSERT sales(phone_id, count)
VALUES (6, 25), (1, 16), (5, 100), (4, 11), (6, 70),
(3, 1000), (4, 80), (2, 66), (4, 88), (6, 200);

# 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
SELECT * FROM phones;


SELECT model, sales_total, IF (sales_total<100, "Мало продаж", "Много продаж")
FROM
(SELECT sales.phone_id, phones.model, SUM(sales.count) AS sales_total
FROM sales, phones
WHERE phones.phone_id = sales.phone_id
GROUP BY phone_id) AS T1;


# 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
# 4. Чем NULL отличается от 0?