16. Найти пользователей, для которых есть заказы стоимость которых (столбец total) 
отличается от действительной стоимости заказа.
Вывод: Имя пользователя, Идентификатор найденного заказа, Оплачен или нет заказ.

SELECT `user`.`fist_name`,`order`.`id`,`order`.`payed` FROM `order` 
	JOIN(
		SELECT `order_id`,`user`.`id` as user_id, SUM(`quantity`*`cost`) as total  FROM `order`
			JOIN `item_in_order` ON `order`.`id`=`order_id`
            JOIN `item` ON `item_id`=`item`.`id`
            JOIN `user` ON `user`.`id`=`user_id`
		GROUP BY `order`.`id`,`user`.`id`
        ) AS t ON `order`.`id`=t.`order_id`
	JOIN `user` ON `user`.`id`=t.`user_id`
	WHERE t.`total`=`order`.`total`;