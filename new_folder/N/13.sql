13. Для каждой вещи можно определить количество заказов, в которых она участвовала.
Требуется для каждой вещи определить сколько есть других вещей, для которых количество 
заказов строго меньше чем количество заказов для данной вещи. Если для некоторой вещи
количество найденных (по вышеуказанному условию) вещей более 75% от их общего количества,
то для такой вещи вывести строку "Наиболее популярная вещь". Если найденное количество в
пределах от 25% до 75% от общего числа вещей, то вывести строку "Средняя популярность". 
Если найденное количество менее 25%, то вывести строку "Наименее популярная вещь".
Вывод: Название вещи, Цена вещи, Найденная строка.

CREATE TEMPORARY TABLE IF NOT EXISTS top
(
	`start` int primary key,
    `end`  int,
    `name` varchar(255)
);

INSERT INTO top VALUES
	(0,24,'Наименее популярная вещь'),
	(25,74,'Средняя популярность'),
	(75,100,'Наиболее популярная вещь');

SELECT `item`.`name`,`item`.`cost`,`top`.`name` FROM 
	(
		SELECT t.`item_id`, 
		COUNT(p.`item_id`) / ( SELECT COUNT(`item`.`id`) FROM `item` ) * 100 AS `count` 
		FROM `item` 
		JOIN (
				SELECT `item_id`,COUNT(`order_id`) AS `count` FROM `item_in_order`
				GROUP BY `item_id`
			) AS t
		JOIN (
			SELECT `item_id`,COUNT(`order_id`) AS `count` FROM `item_in_order`
			GROUP BY `item_id`
		) AS p ON t.`count` > p.`count`
		WHERE p.`item_id`=`item`.`id`
		GROUP BY t.`item_id`
    ) AS s
JOIN `top` ON `count` BETWEEN `start` AND `end`
JOIN `item` ON `item`.`id`= s.`item_id`; 