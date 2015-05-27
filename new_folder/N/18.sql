18. Найти все пары пользователей, города проживания которых совпадают 
(имеется ввиду города, которые указаны в адресах этих пользователей). 
Причём если пара (i, j) выведена, то пару (j, i) выводить не нужно.
Вывод: Найденные пары

SELECT DISTINCT CONCAT(
		'(',
        least(`usr1`.`id`,`usr2`.`id`),
        ', ',
        greatest(`usr1`.`id`,`usr2`.`id`),
        ')'
) AS str
 FROM 
	(
    SELECT `user`.`id`,`address`.`city` FROM `user`
	JOIN `user_address` ON `user`.`id`=`user_id`
    JOIN `address` ON `address`.`id`=`address_id`
    ) AS usr1
    JOIN (
	SELECT `user`.`id`,`address`.`city` FROM `user`
	JOIN `user_address` ON `user`.`id`=`user_id`
    JOIN `address` ON `address`.`id`=`address_id`
    ) AS usr2 ON usr1.`city`=usr2.`city` AND usr1.`id`<>usr2.`id`;
    