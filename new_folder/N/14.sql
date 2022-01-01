14. Найти пользователей покупавших вещи, которые храняться на наибольшем числе складов.
Вывод: Имя пользователя, Фамилия, Имя.

SELECT `user`.`username`,`user`.`last_name`,`user`.`fist_name` FROM `user` 
		JOIN (
		SELECT  `user`.`id` as `user`, COUNT(DISTINCT `storehouse`.`id`) as `n_house` FROM  `item`
					 JOIN `item_in_order` ON `item`.`id`=`item_id`
					 JOIN `order` ON `order`.`id`=`item_in_order`.`order_id`
                     JOIN `storehouse_has_item` ON `storehouse_has_item`.`item_id`=`item`.`id`
                     JOIN `user` ON `user`.`id`=`user_id`
                     JOIN `storehouse` ON `storehouse`.`id`=`storehouse_id`
			GROUP BY `item`.`id`
	) AS t
    WHERE t.`n_house`=(
			SELECT  COUNT(DISTINCT `storehouse`.`id`) as `max` FROM  `item`
					 JOIN `item_in_order` ON `item`.`id`=`item_id`
					 JOIN `order` ON `order`.`id`=`item_in_order`.`order_id`
                     JOIN `storehouse_has_item` ON `storehouse_has_item`.`item_id`=`item`.`id`
                     JOIN `storehouse` ON `storehouse`.`id`=`storehouse_id`
			GROUP BY `item`.`id` ASC limit 1
    )
    AND `user`.`id`=t.`user`;