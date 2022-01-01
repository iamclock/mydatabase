11. Для каждого заказа можно посчитать его суммарную стоимость, 
как сумму произведений количества вещей в заказе на их стоимость.
После чего для каждого пользователя найти среднюю стоимость заказов, 
усреднение проводить по всем заказам которые сделал пользователь.
Вывод: Имя пользователя, Усредненная стоимость заказа

SELECT `user`.`username` as `name`, SUM(`quantity`*`cost`)/COUNT(DISTINCT `order`.`id`) 
	as total  FROM `order`
	JOIN `item_in_order` ON `order`.`id`=`order_id`
    JOIN `item` ON `item_id`=`item`.`id`
    JOIN `user` ON `user`.`id`=`user_id`
	GROUP BY `user`.`id`,`user`.`username`;