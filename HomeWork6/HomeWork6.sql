CREATE DATABASE lesson_6;
use lesson_6;

-- 1.	Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DELIMITER //
CREATE PROCEDURE time_period(seconds INT)
BEGIN
	DECLARE days, hours, minutes INT DEFAULT 0;
    DECLARE sec_per_minutes INT DEFAULT 60;
    DECLARE min_per_hours INT DEFAULT 60;
    DECLARE hours_per_days INT DEFAULT 24;
    
    SET minutes = seconds DIV sec_per_minutes;
    SET seconds = seconds % sec_per_minutes;
    SET hours = minutes DIV min_per_hours;
    SET minutes = minutes % min_per_hours;
    SET days = hours DIV hours_per_days;
    SET hours = hours % hours_per_days;

    SELECT concat(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds ') AS period;
END //
DELIMITER ;

CALL time_period(123456);


-- 2.	Выведите только четные числа от 1 до 10 включительно.
-- Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)

DELIMITER //
CREATE PROCEDURE get_even(`start` INT, `end` INT)
BEGIN
	DECLARE i INT DEFAULT `start`;
    DECLARE res_str TEXT DEFAULT NULL;
    WHILE  i<=`end` DO
        IF i%2 = 0 THEN
			IF res_str IS NULL THEN
				SET res_str = concat(i);
			ELSE
				SET res_str = concat(res_str, ', ', i);
			END IF;
		END IF;
        SET i = i + 1;
    END WHILE;
	SELECT res_str;
END //
DELIMITER ;

CALL get_even(1, 10);