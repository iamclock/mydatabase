15. Найти пользователей, для которых выполнится по крайней мере 4 условия из следующего списка
1) Делал заказы на сумму более 1000 у.е
2) Имеет более одного адреса
3) Почтовый адрес из домена tomsk.ru
4) Все заказы, которые он делал оплачены
5) Число разных вещей в каком-либо заказе больше чем усреднённое количество вещей в заказах (усреднение по всем заказам, а не только по заказам пользователя)
Вывод: Имя пользователя, Фамилия, Имя.

SELECT `user`.`username`,`user`.`last_name`,`user`.`fist_name`  FROM `user` 
JOIN(
    	(
        SELECT DISTINCT `user_id`, 1 AS c FROM `order`
		JOIN `item_in_order` ON `order`.`id`=`order_id`
        JOIN `item` ON `item_id`=`item`.`id`
		GROUP BY `order`.`id`,`user_id` HAVING SUM(`quantity`*`cost`) > 1000
        )
        
        UNION ALL (
        SELECT `user_id`, 1 AS c FROM user 
			JOIN `user_address` ON `user`.`id`=`user_id`
		GROUP BY `user`.`id` HAVING COUNT(`address_id`) > 1
        )
        
        UNION ALL (
		SELECT `user`.`id`, 1 AS c  FROM user
			WHERE `email` LIKE '%@tomsk.ru'
        )
        
        UNION ALL (
        SELECT DISTINCT t1.`user_id`, 1 AS c FROM 
				(
				SELECT `user_id`,COUNT(`user_id`) AS count FROM `order`
					WHERE `payed`=true
				GROUP BY `user_id`,`payed`
				) AS t1
			JOIN (
				SELECT `user_id`,COUNT(`user_id`) AS count FROM `order`
				GROUP BY `user_id`,`payed`
				) AS t2 ON t1.`user_id`=t2.`user_id`
			WHERE t1.`count`=t2.`count`
        )
        
        UNION ALL (
        SELECT DISTINCT `user_id`, 1 AS c FROM `item_in_order`
			JOIN `order` ON `order_id`=`order`.`id`
        GROUP BY `order_id`,`user_id` 
			HAVING COUNT(`item_id`) > (SELECT AVG(`item_id`) FROM `item_in_order`)
		)
	) AS p ON `user_id`=`user`.`id`
    GROUP BY `user`.`id` HAVING COUNT(`c`) > 3;