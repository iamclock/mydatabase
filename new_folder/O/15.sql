#15. Найти игроков, для которых выполнено хотя бы 4 условия из следующего списка:
#1) Суммарный уровень игрока больше 10
#2) Предпочитаемое время: от 14:00 до 18:00
#3) Игроком выбрано не менее 5 профессий
#4) Игрок имеет класс не относящийся к магии
#5) Игрок имеет хотя бы одну профессию, скилл по которой достигает максимального значения с погрешностью в 10%
#Вывод: Имена игроков.

select  players.name
from players
left outer join
(
	(
		# summary iLVL > 10
		select player_id as id, 1 as cond
		from player_specs
		where iLVL > 10
	) 
	union all
	(
		#prefered RT between 14:00 and 18:00
		select players.id as id, 1 as cond
		from players
		where 
			pref_RT_start is not null and pref_RT_end is not null
			and pref_RT_start <= TIME('14:00') and pref_RT_end >= TIME('18:00')
	)
	union all
	(
		#having 5 proffs or more
		select player_id as id, 1 as cond
		from player_proffs
		group by player_id
		having count(player_id) >= 5
	) 
    union all
	(
		#not a magic class
		select players.id as id, 1 as cond
		from players
		inner join clases
			on players.class_id = clases.id
		where class not in ('Warrior','Hunter','Rogue')
	)
	union all
    (
		#have at least one almost full profession
		select distinct player_id as id, 1 as cond
		from player_proffs
		where skill between 450*0.9 and 450
	)
) as t
on players.id = t.id
group by players.id
having count(cond)>=4;