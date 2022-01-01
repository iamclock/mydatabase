17. Для каждой вещи сформировать строку вида. "Вещь НАЗВАНИЕ_ВЕЩИ стоит СТОИМОСТЬ ВЕЩИ у.е., размер
вещи равен РАЗМЕР_ВЕЩИ. Вещь была заказана КОЛИЧЕСТВО_ПОЛЬЗОВАТЕЛЕЙ_ЗАКАЗАВШИХ ВЕЩЬ paз. 
Вещь ХРАНИТСЯ/НЕ ХРАНИТСЯ на складах города Томска. Максимальная стоимость заказа, 
включающего эту вещь достигает МАКСИМАЛЬНАЯ_СТОИМОСТЬ у.е" 
Вывод: Построенная строка

SELECT CONCAT(
	'Вещь ', `itm`.`name`,
    ' стоит ', `itm`.`cost`,'0',
	' у.е., размер вещи равен ', `itm`.`size`,
	' . Вещь была заказана более чем ', ifnull(`c`.`count_p`,'0'),
	' . Вещь ', if(`s`.`s`,'не храниться','храниться'),
    ' на складах города Томска. Максимальная стоимость заказа,  включающего эту вещь достигает ',
   ifnull(`m`.`max`,'0'), ' у.е'
) AS str
FROM (
	SELECT `item`.`id`,`item`.`name`,`item`.`cost`,`item`.`size` FROM `item`
) AS `itm`
JOIN (
	SELECT `item`.`id` AS `id`,COUNT(`order_id`) AS `count_p` FROM `item`
		LEFT JOIN `item_in_order` ON `item`.`id`=`item_id`
    GROUP BY `item`.`id`
) AS c ON itm.`id`=c.`id`
JOIN (
   SELECT `item`.`id`,`item_id`as s FROM `item`
    LEFT JOIN (
    	SELECT `item_id` FROM `storehouse_has_item`
			JOIN `storehouse` ON `storehouse_id`=`storehouse`.`id`
			JOIN `address` ON `address`.`id`=`address_id`
		WHERE `city` like 'Tomsk'
    ) AS t ON `item`.`id`=t.`item_id`
) AS s ON s.`id`=itm.`id`
JOIN (
	SELECT `item`.`id` as id, MAX(`total`) AS max FROM `item`
	LEFT JOIN `item_in_order` AS i ON `item`.`id`=`item_id`
	LEFT JOIN (
		SELECT `order_id`, SUM(`quantity`*`cost`) as total FROM `item_in_order`
            JOIN `item` ON `item_id`=`item`.`id`
		GROUP BY `order_id`
	) AS t ON i.`order_id`=t.`order_id` 
	GROUP BY `item`.`id`
) AS m ON itm.`id`=m.`id`;
