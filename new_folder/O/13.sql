#13. Для каждого игрока можно посчитать его суммарный уровень (по выбранным специальностям). 
#	 Требуется для каждого игрока определить сколько есть других игроков, суммарный уровень которых выше, чем его.
#	 Если найденное значение окажется 
#			 от 0 до 25% от общего числа игроков, то вывести строку "Топовый игрок", 
#		если от 25% до 75% - то строку "Основной игрок", 
#		если от 75% до 100% - то строку "Начинающий игрок" 
#Вывод: Имя игрока, Расса игрока, Фракция игрока, Найденная строка.

create temporary table if not exists ranks
(
	rank_st int primary key,
    rank_end int,
    rank_name varchar(255)
);

insert into ranks values
	(0,24,'Топовый игрок'),
	(25,74,'Основной игрок'),
	(75,100,'Начинающий игрок')
;

select players.name, players.race, players.faction, ranks.rank_name
from
(
	# percents of players with higher iLVLs
	select distinct player_id, 
			100 * higher_players.num / (select count(*) from (select distinct player_id from player_specs) as t)
				as val
	from
	(
		# player id : number of players with higher iLVL
		select t1.player_id, count(t2.player_id) as num
		from 
		(
			# summary iLVLs of every player
			select player_id, sum(iLVL) as summary_lvl
			from player_specs
			group by player_id
		) as t1
		left outer join 
		(
			# summary iLVLs of every player
			select player_id, sum(iLVL) as summary_lvl
			from player_specs
			group by player_id
		) as t2
		on t1.summary_lvl < t2.summary_lvl 
		group by t1.player_id
	) as higher_players
) as percents
inner join ranks
	on percents.val between rank_st and rank_end
inner join players
	on players.id = percents.player_id