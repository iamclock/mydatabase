12. Найти вещи, которые покупались всеми пользователями,
но которые не храняться ни на одном из складов.
Вывод: Название вещи, Стоимость вещи

SELECT `item`.`name`,`item`.`cost` FROM `item`
	JOIN (select COUNT(*) as c from `user`) as n
    JOIN(
		SELECT `item`.`id`, COUNT(DISTINCT `user_id`) as c FROM `order`
		JOIN `item_in_order` ON `order`.`id`=`order_id` 
        JOIN `item` ON `item_id`=`item`.`id`
		GROUP BY `item`.`id`
     ) AS t ON `item`.`id`=t.`id`
     WHERE t.c=n.c
     AND NOT EXISTS(
		SELECT * FROM `storehouse` 
				JOIN `storehouse_has_item` ON `storehouse`.`id`=`storehouse_id`
           WHERE `item_id`=t.`id`    
     );