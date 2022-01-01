19. Для каждого пользователя можно найти среднюю стоимость его заказов 
(усреднение проводить по всем заказам пользователя). Требуется найти 
пользователей среднии стоимости заказов которых находятся в пределах 
от 90% до 100% от максимального значения средней стоимости заказов 
(максимальное значение ищется по всем пользователям).
Вывод: Имя пользователя, Среднее значение стоимости заказов пользователя.

SELECT t2.`name`, t2.`total` FROM (
	SELECT MAX(m.total)*0.9 as min, MAX(m.total) as max FROM (
		SELECT `user`.`username` as `name`, SUM(`quantity`*`cost`)/COUNT(DISTINCT `order`.`id`)  as total  
		FROM `order`
		JOIN `item_in_order` ON `order`.`id`=`order_id`
		JOIN `item` ON `item_id`=`item`.`id`
		JOIN `user` ON `user`.`id`=`user_id`
		GROUP BY `user`.`id`,`user`.`username`
    ) as m ) as t1
     JOIN(
		SELECT `user`.`username` as `name`, SUM(`quantity`*`cost`)/COUNT(DISTINCT `order`.`id`)  as total  
		FROM `order`
		JOIN `item_in_order` ON `order`.`id`=`order_id`
		JOIN `item` ON `item_id`=`item`.`id`
		JOIN `user` ON `user`.`id`=`user_id`
		GROUP BY `user`.`id`,`user`.`username`
    ) as t2 ON t2.total between t1.min and t1.max; 