#11. Найти усреднённое значение "скилов" профессий для каждого игрока. 
#	 	После чего просуммировать полученные значения по каждому классу. 
#		Т.о. для класса будут найдены суммарное значение средних показателей игроков этих классов.

#Вывод: Имя класса, Найденное суммарное среднее значение скилов.

select class, sum(av) as summary_skill
from (
	select class,av
	from (
	(# average player skills as t
		select player_id, avg(skill) as av
		from player_proffs
		group by player_id
	) as t 
	# join w/ players to get class_id
	inner join players 
		on t.player_id = players.id
	# join w/ classes to get class names
    inner join clases
		on class_id = clases.id
	)
) as res
group by class
;